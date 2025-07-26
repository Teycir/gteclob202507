# ReportVulns.md
_Comprehensive list of vulnerabilities detected through manual review **and** automated tools
(Aderyn + Slither `--show-ignored-findings`)_

| # | Sev. | Description | Affected Contract | Affected Functions | 🛠 Recommended Fix |
|---|---|---|---|---|---|
| **1** | [H-01] | Re-entrancy / balance-inflation – storage credited **before** token transfer (`arbitrary-send-erc20`). | `AccountManager` | `deposit` 192-203<br>`depositFromRouter` 206-213 | Move `safeTransferFrom` **before** `_creditAccount`; add `nonReentrant`. |
| **2** | [H-02] | Faulty “zero-cost-trade” check uses bit-wise `&`. | `CLOB` | `_processLimitBidOrder` 636-641<br>`_processLimitAskOrder` 690-695 | Replace the faulty bitwise check with a logical OR: `(baseTokenAmountReceived == 0 || quoteTokenAmountSent == 0)`. |
| **3** | [H-03] | Integer Overflow in Account Crediting. | `AccountManager` | `_creditAccount` 100-105<br>`_creditAccountNoEvent` 110-115 | Remove `unchecked` or add bounds checks (e.g., `require(balance + amount > balance, "Overflow");`). |
| **4** | [M-01] | Uses EIP-1153 `tstore/tload`; deployment fails on non-Prague chains. | `TransientMakerData`<br>`BookLib` | (contract-level) 17-196<br>(contract-level) 113-152 | Gate by `chainid` or add storage fallback. |
| **5** | [M-02] | Potential infinite loop / DoS when `lotSizeInBase` > remaining size. | `CLOB` | `_matchIncomingBid` 742-770<br>`_matchIncomingAsk` 777-804 | Break if `lotSize > incoming.amount`. |
| **6** | [M-03] | Enum value not validated; invalid `Side` bypasses logic. | `GTERouter` | `_executeClobPostFillOrder` 306-320 | `require(side==BUY || side==SELL)`. |
| **7** | [M-04] | Missing Event Emissions for Maker Account Balance Updates During Settlement. | `AccountManager` | `settleIncomingOrder` 300-320 | Replace `_creditAccountNoEvent` with `_creditAccount` or emit a batched event (e.g., `MakersCredited`). |
| **8** | [L-01] | Uninitialised locals that may leak junk. | `CLOB`<br>`CLOBManager` | `_settleIncomingOrder` 949-959<br>`_removeNonCompetitiveOrder` 875-884<br>`_executeAmendNewOrder` 678-690<br>`createMarket` 177-185 | Initialise structs / vars explicitly. |
| **9** | [L-02] | Contracts accept ETH but provide no withdraw. | `Distributor`<br>`AccountManager`<br>`CLOBManager` | `receive()` 13-198<br>`receive()` 27-341<br>`receive()` 54-341 | Add owner-only `sweepETH(address)`. |
| **10** | [L-03] | No re-entrancy guard around state-change + transfers. | `AccountManager`<br>`GTERouter` | `collectFees` 250-266<br>`wrapSpotDeposit` 140-151 | Add `nonReentrant` or move transfers last. |
| **11** | [L-04] | Off-by-one in packed fee accessor. | `PackedFeeRatesLib` | `getFeeAt` 56-63 | Change guard to `index >= 16`. |
| **12** | [L-05] | Admin bit double-counted in role check (readability). | `OperatorHelperLib` | `assertHasRole` 8-22 | Split `hasRole` / `isAdmin`. |

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

### Excerpt 13: Integer Overflow in Account Crediting
```solidity
// In the _creditAccount function
function _creditAccount( AccountManagerStorage storage self, address account, address token, uint256 amount ) internal {
    unchecked {
        self.accountTokenBalances[account][token] += amount; // VULNERABLE LINE
    }
    emit AccountCredited(AccountEventNonce.inc(), account, token, amount);
}

// In the _creditAccountNoEvent function
function _creditAccountNoEvent( AccountManagerStorage storage self, address account, address token, uint256 amount ) internal {
    unchecked {
        self.accountTokenBalances[account][token] += amount; // VULNERABLE LINE
    }
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

### Excerpt 14: Missing Event Emissions for Maker Account Balance Updates During Settlement
```solidity
// Credit both base and quote amounts if any (not just fills less fee, but also expiry and non-competitive refunds)
if (credit.baseAmount > 0) {
    _creditAccountNoEvent(  // @audit-issue: Missing event emission and nonce increment; should use _creditAccount
        self,
        credit.maker,
        params.baseToken,
        credit.baseAmount
    );
}

if (credit.quoteAmount > 0) {
    _creditAccountNoEvent(  // @audit-issue: Missing event emission and nonce increment; should use _creditAccount
        self,
        credit.maker,
        params.quoteToken,
        credit.quoteAmount
    );
}
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