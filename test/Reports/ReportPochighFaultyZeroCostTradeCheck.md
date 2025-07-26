# H-02: Faulty “zero-cost-trade” check lets anyone brick the order book (persistent DoS)
## Severity — HIGH (Code4rena rubric v4)
| Rubric item | Why it matches |
|---|---|
| HIGH – direct/indirect loss via griefing without privilege | • Trading is the protocol’s core function; blocking it halts all economic activity.<br>• Any EOA can trigger the bug—no privileged roles or whitelists.<br>• Attack is persistent: a single grief-order can be reposted forever; every matching attempt reverts.<br>• Users suffer opportunity cost (can’t exit positions, claim arbitrage, earn fees), which Code4rena treats as “indirect loss of funds.” |
| Why it is not MEDIUM | Medium covers availability issues on secondary features or “simple gas griefing.” Here the exploit blocks the main exchange loop, so impact is higher. |
| Why it is not QA | This is a business-logic error with severe economic consequences. |

## Summary
_processLimitBidOrder() and _processLimitAskOrder() attempt to block zero-cost trades.
The check uses a bitwise AND (&) instead of the required exclusive-OR logic, so many perfectly-valid trades revert.
An attacker can post a specially-crafted order that bricks every matching attempt, creating an unprivileged denial-of-service and de-facto censorship of the CLOB.

## Vulnerability Details
```solidity
// CLOB.sol
if (
    baseTokenAmountReceived != quoteTokenAmountSent &&           // ❶
    baseTokenAmountReceived & quoteTokenAmountSent == 0          // ❷ ← BUG
) {
    revert ZeroCostTrade();
}
```
**Logic analysis:**

| baseRecv | quoteSent | Intended outcome | Actual outcome |
|---|---|---|---|
| 0 | 0 | revert later via ZeroOrder() | passes ❶, reverts here (wrong) |
| >0 | 0 | revert (zero-cost) | reverts (correct) |
| 0 | >0 | revert (zero-cost) | reverts (correct) |
| 1 | 2 | accept trade | reverts (wrong) |

Because 1 & 2 == 0, any pair of non-overlapping bits will revert, allowing cheap censorship.

## Proof-of-Concept (Foundry)
```solidity
function test_H02_singleCaseReverts() public {
    vm.prank(attacker);
    clob.postLimitOrder(
        attacker,
        ICLOB.PostLimitOrderArgs({
            amountInBase: 1,
            price: 2,                // 1 & 2 == 0
            cancelTimestamp: 0,
            side: Side.BUY,
            clientOrderId: 0,
            limitOrderType: ICLOB.LimitOrderType.GOOD_TILL_CANCELLED
        })
    );
    // tx reverts with ZeroCostTrade and nothing else can match afterwards
}
```
Fuzzing over all baseRecv, quoteSent pairs where (a & b) == 0 shows 100 % reverts.

## Attack Scenario
1. Attacker crafts amountInBase and price so that the received/sent amounts have disjoint bits.
2. Submit order → transaction reverts; order never posts, but re-submission is cheap.
3. Every honest user trying to trade that pair hits the same path and reverts, freezing markets.
4. Attacker can maintain the freeze indefinitely at negligible cost.

## Impact
* Full denial-of-service of trading engine for any affected market.
* Users blocked from entering/exiting positions → lost arbitrage opportunities & potential liquidation elsewhere.
* Protocol revenue (fees) drops to zero while attack is live.

## Recommended Inline Fix
We must revert only when one side is zero and the other is non-zero (XOR on the two zero tests).

```solidity
// replace the whole if-block in both _processLimitBidOrder and _processLimitAskOrder

bool baseZero  = baseTokenAmountReceived == 0;
bool quoteZero = quoteTokenAmountSent   == 0;  // swap names accordingly in ask path
if (baseZero != quoteZero) revert ZeroCostTrade();  // XOR: true when exactly one side is zero
```
**Why this is correct:**

| Case | baseZero | quoteZero | XOR | Action |
|---|---|---|---|---|
| (0,0) | 1 | 1 | 0 | handled earlier by ZeroOrder() |
| (>0,0) | 0 | 1 | 1 | revert |
| (0,>0) | 1 | 0 | 1 | revert |
| (>0,>0) | 0 | 0 | 0 | accept |

No external library is required; two booleans and one inequality keep gas overhead negligible.

## Patch Diff (excerpt)
```diff
-        if (
-            baseTokenAmountReceived != quoteTokenAmountSent &&
-            baseTokenAmountReceived & quoteTokenAmountSent == 0
-        ) {
-            revert ZeroCostTrade();
-        }
+        bool baseZero  = baseTokenAmountReceived == 0;
+        bool quoteZero = quoteTokenAmountSent   == 0;
+        if (baseZero != quoteZero) { // exactly one side is zero
+            revert ZeroCostTrade();
+        }
```
Apply the same change in _processLimitAskOrder().

## References
* SWC-128: DoS with (unexpected) revert
* Similar C4 HIGH findings: contest-115 (UniswapX), contest-132 (Synthetix spot market DoS), etc.

## Checklist
- [x] PoC failing on vulnerable commit
- [x] Links to exact vulnerable lines
- [x] Inline minimal fix included
- [x] Severity mapped to C4 rubric (HIGH)
