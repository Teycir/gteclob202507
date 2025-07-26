# ReportVulns.md  
_Comprehensive list of vulnerabilities detected through manual review **and** automated tools  
(Aderyn + Slither `--show-ignored-findings`)_

| # | Sev. | Description | Affected Contract | Affected Functions | 🛠 Recommended Fix |
|---|---|---|---|---|---|
| **1** | 🟥 | Re-entrancy / balance-inflation – storage credited **before** token transfer (`arbitrary-send-erc20`). | `AccountManager` | `deposit` 192-203<br>`depositFromRouter` 206-213 | Move `safeTransferFrom` **before** `_creditAccount`; add `nonReentrant`. |
| **2** | 🟥 | Faulty “zero-cost-trade” check uses bit-wise `&`. | `CLOB` | `_processLimitBidOrder` 636-641<br>`_processLimitAskOrder` 690-695 | Replace the faulty bitwise check with a logical OR: `(baseTokenAmountReceived == 0 || quoteTokenAmountSent == 0)`. |
| **3** | 🟧 | Uses EIP-1153 `tstore/tload`; deployment fails on non-Prague chains. | `TransientMakerData`<br>`BookLib` | (contract-level) 17-196<br>(contract-level) 113-152 | Gate by `chainid` or add storage fallback. |
| **4** | 🟧 | Potential infinite loop / DoS when `lotSizeInBase` > remaining size. | `CLOB` | `_matchIncomingBid` 742-770<br>`_matchIncomingAsk` 777-804 | Break if `lotSize > incoming.amount`. |
| **5** | 🟧 | Enum value not validated; invalid `Side` bypasses logic. | `GTERouter` | `_executeClobPostFillOrder` 306-320 | `require(side==BUY || side==SELL)`. |
| **6** | 🟨 | Uninitialised locals that may leak junk. | `CLOB`<br>`CLOBManager` | `_settleIncomingOrder` 949-959<br>`_removeNonCompetitiveOrder` 875-884<br>`_executeAmendNewOrder` 678-690<br>`createMarket` 177-185 | Initialise structs / vars explicitly. |
| **7** | 🟨 | Contracts accept ETH but provide no withdraw. | `Distributor`<br>`AccountManager`<br>`CLOBManager` | `receive()` 13-198<br>`receive()` 27-341<br>`receive()` 54-341 | Add owner-only `sweepETH(address)`. |
| **8** | 🟨 | No re-entrancy guard around state-change + transfers. | `AccountManager`<br>`GTERouter` | `collectFees` 250-266<br>`wrapSpotDeposit` 140-151 | Add `nonReentrant` or move transfers last. |
| **9** | 🟩 | Off-by-one in packed fee accessor. | `PackedFeeRatesLib` | `getFeeAt` 56-63 | Change guard to `index >= 16`. |
| **10** | 🟩 | Admin bit double-counted in role check (readability). | `OperatorHelperLib` | `assertHasRole` 8-22 | Split `hasRole` / `isAdmin`. |
| **11** | ⚙️ | Slither “assembly / shift” in Solady libs – intentional. | `lib/solady/**` | (library-wide) | Accept or swap libs. |
| **12** | ⚙️ | “Locked Ether” on `GTERouter` false positive (ETH wrapped). | `GTERouter` | `receive()` 98-102 | No action. |

---

## Code Excerpts

### Excerpt 1: Re-entrancy / balance-inflation
```solidity
// vulnerable order
_creditAccount(_getAccountStorage(), account, token, amount);
token.safeTransferFrom(account, address(this), amount);
```

### Excerpt 2: Faulty “zero-cost-trade” check
```solidity
if (
    baseTokenAmountReceived != quoteTokenAmountSent &&          // ❶
    baseTokenAmountReceived & quoteTokenAmountSent == 0         // ❷  <-- issue
) {
    revert ZeroCostTrade();
}
```

### Excerpt 3: Uses EIP-1153 `tstore/tload`
```solidity
assembly ("memory-safe") {
    exists := iszero(iszero(tload(slot)))
    /* … more tstore/tload … */
}
```

### Excerpt 4: Potential infinite loop / DoS
```solidity
while (bestAskPrice <= incomingOrder.price && incomingOrder.amount > 0) {
    …
    if (currMatch.baseDelta == 0) break; // missing in original
}
```

### Excerpt 5: Enum value not validated
```solidity
fillArgs.side = ICLOB(market).getQuoteToken() == route.nextTokenIn
    ? Side.BUY : Side.SELL;
// later
if (fillArgs.side == Side.BUY) { … } else { … }
```

### Excerpt 6: Uninitialised locals
```solidity
SettleParams memory settleParams;          // uninitialised
(settleParams.quoteToken, settleParams.baseToken) = …
```

### Excerpt 7: Contracts accept ETH but provide no withdraw
```solidity
receive() external payable {}
```

### Excerpt 8: No re-entrancy guard
```solidity
fee = feeData.claimFees(token);          // storage update
if (fee > 0) token.safeTransfer(feeRecipient, fee);  // external
```

### Excerpt 9: Off-by-one in packed fee accessor
```solidity
if (index >= 15) revert FeeTierIndexOutOfBounds();
```

### Excerpt 10: Admin bit double-counted
```solidity
if (rolesPacked & (1 << uint8(role)) == 0 && rolesPacked & 1 == 0)
    revert OperatorDoesNotHaveRole();
```

### Excerpt 11: Slither “assembly / shift”
```solidity
assembly { … }
```

### Excerpt 12: “Locked Ether” on `GTERouter`
```solidity
receive() external payable {}
```

---
\* **LOC**: line numbers based on commit `9f06332`; adjust if files change.