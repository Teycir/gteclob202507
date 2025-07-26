# Low-Severity / QA Findings: GTE Protocol – Code4rena Audit

Below is a single consolidated Low-severity report containing five informational / defence-in-depth issues.
Each subsection is self-contained (title, location, details, recommendation).

---

### [L-01] Uninitialised locals that may leak junk

| Item | Value |
| --- | --- |
| **Contract** | `CLOBManager.sol` |
| **Function** | `_settleIncomingOrder` (949-959), `_removeNonCompetitiveOrder` (875-884), `_executeAmendNewOrder` (678-690), `createMarket` (177-185) |
| **Severity** | Low (QA) – defensive-coding / future-proofing |

**Details**

Memory structs like `SettleParams` are not explicitly initialized, potentially containing stack garbage. While current usage partially overwrites fields, future code changes could propagate junk data, leading to mis-settlements or invalid events. Solidity does not zero-initialize memory structs, unlike storage.

```solidity
// CLOBManager::_settleIncomingOrder (snippet)
SettleParams memory settleParams;          // uninitialised
(settleParams.quoteToken, settleParams.baseToken) = …
```

**Recommendation**

Explicitly initialize all struct fields:

```solidity
SettleParams memory settleParams = SettleParams({
    side: Side.BUY, // or appropriate default
    taker: address(0),
    takerBaseAmount: 0,
    takerQuoteAmount: 0,
    baseToken: address(0),
    quoteToken: address(0),
    makerCredits: new MakerCredit[](0)
});
```

---

### [L-02] Contracts accept ETH but provide no withdraw

| Item | Value |
| --- | --- |
| **Contract** | `Distributor.sol`, `AccountManager.sol`, `CLOBManager.sol` |
| **Function** | `receive()` (13-198 in Distributor, 27-341 in AccountManager, 54-341 in CLOBManager) |
| **Severity** | Low (QA) – operational / asset-recovery |

**Details**

Contracts implement `receive() external payable {}` allowing ETH reception via transfers or `selfdestruct`, but lack a withdrawal mechanism. This risks permanent fund lockup and breaks balance invariants, potentially complicating audits or causing accounting issues.

**Recommendation**

Add an owner-only sweep function:

```solidity
function sweepETH(address to, uint256 amt) external onlyOwner {
    payable(to).transfer(amt == 0 ? address(this).balance : amt);
}
```

---

### [L-03] No re-entrancy guard around state-change + transfers

| Item | Value |
| --- | --- |
| **Contract** | `AccountManager.sol`, `GTERouter.sol` |
| **Function** | `collectFees` (250-266 in AccountManager), `wrapSpotDeposit` (140-151 in GTERouter) |
| **Severity** | Low (QA) – reentrancy / defense-in-depth |

**Details**

External calls precede state updates, opening re-entrancy windows. In `collectFees`, token transfer before fee subtraction risks double-claiming. In `wrapSpotDeposit`, WETH deposit before balance update could allow re-entrancy if WETH is compromised, though currently trusted.

```solidity
// AccountManager.collectFees (snippet)
fee = feeData.claimFees(token);          // storage update
if (fee > 0) token.safeTransfer(feeRecipient, fee);  // external
```

**Recommendation**

Add `nonReentrant` modifier or strictly follow Checks-Effects-Interactions:

```solidity
function collectFees(address token, address feeRecipient) external nonReentrant {
    // ...
}
```

---

### [L-04] Off-by-one in packed fee accessor

| Item | Value |
| --- | --- |
| **Contract** | `PackedFeeRatesLib.sol` |
| **Function** | `getFeeAt` (56-63) |
| **Severity** | Low (QA) – logic-error / data-corruption |

**Details**

The guard `if (index >= 15) revert FeeTierIndexOutOfBounds();` allows indices 0-14 but skips 15 in a `uint128` packed with 16 `uint8` fees (indices 0-15). This silently corrupts fees for index 15 and confuses callers expecting 16 values.

```solidity
if (index >= 15) revert FeeTierIndexOutOfBounds();
uint8 fee = uint8(packed >> (index * 8));
```

**Recommendation**

Update guard to allow 0-15:

```solidity
if (index >= 16) revert FeeTierIndexOutOfBounds();
```

---

### [L-05] Admin bit double-counted in role check (readability)

| Item | Value |
| --- | --- |
| **Contract** | `OperatorHelperLib.sol` |
| **Function** | `assertHasRole` (8-22) |
| **Severity** | Low (QA) – readability / maintenance |

**Details**

The admin check is duplicated in the role assertion, which is functionally redundant but reduces code clarity. This could lead to bugs during future modifications or confuse reviewers about authorization logic.

```solidity
function assertHasRole(bytes32 role) internal view {
    if (!(roles[msg.sender] == ADMIN || roles[msg.sender] == role || roles[msg.sender] == ADMIN)) {
        revert();
    }
}
```

**Recommendation**

Refactor for clarity:

```solidity
function isAdmin(address a) internal view returns (bool) {
    return roles[a] == ADMIN;
}
function hasRole(address a, bytes32 role) internal view returns (bool) {
    return isAdmin(a) || roles[a] == role;
}
