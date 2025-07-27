# Updated Vulnerability Matrix

| # | Severity | ID / Title | Affected Contract(s) | Affected Function(s) & LOC | 🛠 Recommended Fix |
|---|----------|------------|----------------------|---------------------------|--------------------|
| 1 | 🟥 High | **[H-01] Re-entrancy / Balance-inflation** – storage credited before token transfer (arbitrary-send-ERC20) | `AccountManager` | `deposit` L192-203<br>`depositFromRouter` L206-213 | • Call `safeTransferFrom` **before** `_creditAccount`.<br>• Add `nonReentrant`. |
| 2 | 🟥 High | **[H-02] Faulty “zero-cost-trade” check** uses bit-wise `&` instead of logical operator | `CLOB` | `_processLimitBidOrder` L636-641<br>`_processLimitAskOrder` L690-695 | Replace with logical OR:<br>```solidity\nif (quoteSent == 0 || baseRecv == 0) revert ZeroCostTrade();\n``` |
| 3 | 🟥 High | **[H-03] Integer overflow** in account crediting (`unchecked`) | `AccountManager` | `_creditAccount` L100-105<br>`_creditAccountNoEvent` L110-115 | Remove `unchecked` **or** add `require(balance + amount >= balance)`. |
| 4 | 🟧 Med | **[M-01] EIP-1153 (`tstore/tload`)** – reverts on non-Prague chains | `TransientMakerData`, `BookLib` | Assembly blocks | Gate by `chainid` or provide classic-storage fallback. |
| 5 | 🟧 Med | **[M-02] Infinite-loop / gas-DoS** when `lotSizeInBase` > remainder | `CLOB` | `_matchIncomingBid` L742-770<br>`_matchIncomingAsk` L777-804 | Break when `lotSize > incoming.amount` **or** ensure `incoming.amount` strictly decreases. |
| 6 | 🟧 Med | **[M-03] Enum value not validated** – crafted calldata can bypass logic | `GTERouter` | `_executeClobPostFillOrder` L306-320 | `require(side == Side.BUY || side == Side.SELL)`. |
| 7 | 🟧 Med | **[M-04] Missing event emissions** during maker settlement | `AccountManager` | `settleIncomingOrder` L300-320 | Emit events **or** use `_creditAccount` instead of `_creditAccountNoEvent`. |
| 8 | 🟨 Low | **[L-01] Un-initialised locals / structs** | `CLOB`, `CLOBManager` | `_settleIncomingOrder` L949-959<br>`_removeNonCompetitiveOrder` L875-884<br>`_executeAmendNewOrder` L678-690<br>`createMarket` L177-185 | Initialise variables explicitly. |
| 9 | 🟨 Low | **[L-02] Contracts receive ETH but lack withdrawal** | `Distributor`, `AccountManager`, `CLOBManager` | `receive()` functions | Add owner-only `sweepETH(address)` or similar. |
| 10 | 🟨 Low | **[L-03] No re-entrancy guard** around state-change + token transfer | `AccountManager`, `GTERouter` | `collectFees` L250-266<br>`wrapSpotDeposit` L140-151 | Add `nonReentrant` **or** move transfers after state-update. |
| 11 | 🟩 Info | **[L-04] Off-by-one in packed-fee accessor** (index 15 skipped) | `PackedFeeRatesLib` | `getFeeAt` L56-63 | Change guard to `if (index > 15) revert …;`. |
| 12 | 🟩 Info | **[L-05] Admin-bit double-counted** in `assertHasRole` | `OperatorHelperLib` | `assertHasRole` L8-22 | Split `isAdmin` vs `hasRole` checks for clarity. |

---

## Code Excerpts

<details>
<summary>1 – Re-entrancy / Balance-inflation</summary>

```solidity
// vulnerable order
_creditAccount(_getAccountStorage(), account, token, amount);
token.safeTransferFrom(account, address(this), amount);
```
</details>

<details>
<summary>2 – Faulty “zero-cost-trade” check</summary>

```solidity
if (
    baseTokenAmountReceived != quoteTokenAmountSent &&
    baseTokenAmountReceived & quoteTokenAmountSent == 0  // <-- issue
) {
    revert ZeroCostTrade();
}
```
</details>

<details>
<summary>3 – Integer overflow when crediting</summary>

```solidity
function _creditAccount(...) internal {
    unchecked {                                  // VULNERABLE
        self.accountTokenBalances[account][token] += amount;
    }
    emit AccountCredited(...);
}
```
</details>

<details>
<summary>4 – EIP-1153 (`tstore/tload`) usage</summary>

```solidity
assembly ("memory-safe") {
    exists := iszero(iszero(tload(slot)))
    /* … */
}
```
</details>

<details>
<summary>5 – Infinite-loop risk in matcher</summary>

```solidity
while (bestAskPrice <= incomingOrder.price && incomingOrder.amount > 0) {
    …
    if (currMatch.baseDelta == 0) break; // missing in original
}
```
</details>

<details>
<summary>6 – Enum not validated</summary>

```solidity
fillArgs.side = ICLOB(market).getQuoteToken() == route.nextTokenIn
    ? Side.BUY
    : Side.SELL;
```
</details>

<details>
<summary>7 – Missing events in settlement</summary>

```solidity
_creditAccountNoEvent(self, credit.maker, params.baseToken, credit.baseAmount);
```
</details>

<details>
<summary>8 – Un-initialised locals</summary>

```solidity
SettleParams memory settleParams; // uninitialised
```
</details>

<details>
<summary>9 – ETH stuck in contracts</summary>

```solidity
receive() external payable {}   // no withdrawal path
```
</details>

<details>
<summary>10 – No `nonReentrant` guard</summary>

```solidity
fee = feeData.claimFees(token);      // state mutated
token.safeTransfer(feeRecipient, fee); // external call
```
</details>

<details>
<summary>11 – Off-by-one in fee accessor</summary>

```solidity
if (index >= 15) revert FeeTierIndexOutOfBounds();
```
</details>

<details>
<summary>12 – Admin bit double-counted</summary>

```solidity
if (rolesPacked & (1 << uint8(role)) == 0 && rolesPacked & 1 == 0)
    revert OperatorDoesNotHaveRole();
```
</details>

---

### Legend
🟥 High | 🟧 Medium | 🟨 Low | 🟩 Info