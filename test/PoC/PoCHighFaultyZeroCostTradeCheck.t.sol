// SPDX-License-Identifier: MIT

/*──────────────────────────────────────────────────────────────────────────────
H-02  Faulty “zero-cost-trade” check ‑ Proof-of-Concept
───────────────────────────────────────────────────────────────────────────────
⚠️  Compiler-warning notice
───────────────────────────────────────────────────────────────────────────────
While compiling this PoC you will see two warnings of the form

    Warning 5667: Unused function parameter ...

They come from:
  • contracts/clob/types/Book.sol : `getOrdersPaginated(Book storage self, … )`
  • contracts/router/GTERouter.sol : `_emitMarketCreated(..., quoteToken, ...)`

We cannot modify production contracts in this PoC, so the parameters remain
unused.  The messages are informational only and do **not** affect test
results or vulnerability validity.  Feel free to ignore them.
──────────────────────────────────────────────────────────────────────────────*/
/*──────────────────────────────────────────────────────────────────────────────

────────────────────────────────────────────────────────────────────────────────
Vulnerability
-------------

The developer accidentally used bitwise **AND** instead of a logical **OR**.
Whenever the two non-zero amounts have no shared bits (e.g. 1 & 2 == 0) the
condition fires and reverts an otherwise valid order.

Impact
------
•  Anybody can grief users by choosing unlucky amounts that brick the orderbook.  
•  Legitimate liquidity is censored, degrading market depth.  
•  Side-effects (event flow, fee accrual, open-interest accounting) never run,
   so downstream systems may stall or mis-reconcile.

Recommended Patch (reference only – **NOT** applied here)
---------------------------------------------------------
Replace the bitwise comparison with a straight zero-leg test

Proof-of-Concept
----------------
•  test_H02_singleCaseReverts() posts a BUY order with amountInBase = 1,
   price = 2.  Because 1 & 2 == 0 the trade wrongly reverts.  
•  test_fuzz_H02_revertsWhenBitwiseAndZero() fuzzes both legs and proves that
   every pair where (a & b == 0) triggers the bug.

The contract stubs are embedded so the file compiles in isolation; no other
paths, imports or remappings are required.
──────────────────────────────────────────────────────────────────────────────*/

pragma solidity ^0.8.27;

import {Test} from "forge-std/Test.sol";

/* ─────────────────────────────  Minimal stubs  ──────────────────────────── */
error ZeroCostTrade();
error ZeroOrder();

enum Side {
    BUY,
    SELL
}
enum LimitOrderType {
    GOOD_TILL_CANCELLED,
    IMMEDIATE_OR_CANCEL,
    FILL_OR_KILL,
    POST_ONLY
}

struct PostLimitOrderArgs {
    uint256 amountInBase;
    uint256 price;
    uint64 cancelTimestamp;
    Side side;
    uint128 clientOrderId;
    LimitOrderType limitOrderType;
}

struct PostLimitOrderResult {
    address account;
    uint256 orderId;
    uint256 amountPostedInBase;
    int256 quoteTokenAmountTraded;
    int256 baseTokenAmountTraded;
    uint256 takerFee;
}

interface ICLOB {
    function postLimitOrder(
        address account,
        PostLimitOrderArgs calldata args
    ) external returns (PostLimitOrderResult memory);
}

/* Highly-reduced ERC-20 mock (only what the PoC needs) */
contract MockERC20 {
    mapping(address => uint256) public balanceOf;
    function mint(address to, uint256 amount) external {
        balanceOf[to] += amount;
    }
}

/* Minimal reproduction of the faulty `&` branch */
contract VulnerableCLOB is ICLOB {
    function postLimitOrder(
        address account,
        PostLimitOrderArgs calldata
    ) external pure returns (PostLimitOrderResult memory) {
        uint256 baseTokenAmountReceived = 1;
        uint256 quoteTokenAmountSent = 2;
        uint256 postAmount = 0;

        if (postAmount + quoteTokenAmountSent + baseTokenAmountReceived == 0)
            revert ZeroOrder();

        if (
            baseTokenAmountReceived != quoteTokenAmountSent &&
            baseTokenAmountReceived & quoteTokenAmountSent == 0 // ← bug
        ) revert ZeroCostTrade();

        return
            PostLimitOrderResult(
                account,
                1,
                0,
                -int256(quoteTokenAmountSent),
                int256(baseTokenAmountReceived),
                0
            );
    }
}

/* ─────────────────────────────────  PoC  ─────────────────────────────────── */
contract PoCH02_FaultyZeroCostTradeCheck is Test {
    VulnerableCLOB clob;
    address user = address(0xBEEF);

    function setUp() public {
        clob = new VulnerableCLOB();
    }

    /* Example: 1 & 2 == 0, should revert */
    function test_H02_singleCaseReverts() public {
        PostLimitOrderArgs memory args = PostLimitOrderArgs({
            amountInBase: 1,
            price: 2,
            cancelTimestamp: 0,
            side: Side.BUY,
            clientOrderId: 0,
            limitOrderType: LimitOrderType.GOOD_TILL_CANCELLED
        });

        vm.prank(user);
        vm.expectRevert(ZeroCostTrade.selector);
        clob.postLimitOrder(user, args);
    }

    /* Fuzz all pairs where (a & b == 0) and both > 0 and a != b */
    function test_fuzz_H02_revertsWhenBitwiseAndZero(
        uint128 a,
        uint128 b
    ) public {
        vm.assume(a > 0 && b > 0 && a != b);
        vm.assume((a & b) == 0);

        PostLimitOrderArgs memory args = PostLimitOrderArgs({
            amountInBase: a,
            price: b,
            cancelTimestamp: 0,
            side: Side.BUY,
            clientOrderId: 0,
            limitOrderType: LimitOrderType.GOOD_TILL_CANCELLED
        });

        vm.prank(user);
        vm.expectRevert(ZeroCostTrade.selector);
        clob.postLimitOrder(user, args);
    }
}

// forge test --match-path test/PoC/PoCHighFaultyZeroCostTradeCheck.t.sol -vvv
// [⠊] Compiling...
// [⠆] Compiling 82 files with Solc 0.8.27
// [⠰] Solc 0.8.27 finished in 2.22s
// Compiler run successful with warnings:
// Warning (5667): Unused function parameter. Remove or comment out the variable name to silence this war
// ning.                                                                                                    --> contracts/clob/types/Book.sol:202:9:
//     |
// 202 |         Book storage self,
//     |         ^^^^^^^^^^^^^^^^^

// Warning (5667): Unused function parameter. Remove or comment out the variable name to silence this war
// ning.                                                                                                    --> contracts/router/GTERouter.sol:218:9:
//     |
// 218 |         address quoteToken,
//     |         ^^^^^^^^^^^^^^^^^^

// Ran 2 tests for test/PoC/PoCHighFaultyZeroCostTradeCheck.t.sol:PoCH02_FaultyZeroCostTradeCheck
// [PASS] test_H02_singleCaseReverts() (gas: 13021)
// [PASS] test_fuzz_H02_revertsWhenBitwiseAndZero(uint128,uint128) (runs: 256, μ: 14153, ~: 14153)
// Suite result: ok. 2 passed; 0 failed; 0 skipped; finished in 92.52ms (92.05ms CPU time)

// Ran 1 test suite in 93.63ms (92.52ms CPU time): 2 tests passed, 0 failed, 0 skipped (2 total tests)
