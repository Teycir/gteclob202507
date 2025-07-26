```markdown
# ReportVulns.md  
_Comprehensive list of vulnerabilities detected through manual review **and** automated tools  
(Aderyn + Slither `--show-ignored-findings`)_

| # | Severity | Description | Affected Contract / Function(s) | Recommended Fix |
|---|----------|-------------|---------------------------------|-----------------|
| **1** | Critical 🟥 | **Re-entrancy / Balance-inflation** – internal balance credited **before** `transferFrom`, plus arbitrary-sender vector. | `AccountManager`<br>• `deposit`<br>• `depositFromRouter` | Follow CEI: move `safeTransferFrom` **before** `_creditAccount`; add `nonReentrant`. |
| **2** | Critical 🟥 | **Zero-cost-trade check faulty** – uses bit-wise `&`, causing false reverts & dust trades. | `CLOB`<br>• `_processLimitBidOrder`<br>• `_processLimitAskOrder` | Replace with `if (quote == 0 || base == 0) revert ZeroCostTrade();`. |
| **3** | High 🟧 | **EIP-1153 transient storage not live on many chains** – contracts revert on deployment. | `TransientMakerData` library (all fns)<br>`BookLib` transients | Gate by `chainid`, or provide storage fallback until Prague activated. |
| **4** | High 🟧 | **Infinite-loop / DoS** – matching loop never breaks when `lotSizeInBase` > remaining amount. | `CLOB`<br>• `_matchIncomingBid`<br>• `_matchIncomingAsk` | Break early if `lotSize > incoming.amount` or pre-validate lot size. |
| **5** | High 🟧 | **Strict enum equality w/o range check** – undefined `Side` values bypass logic, return junk. | `GTERouter`<br>• `_executeClobPostFillOrder` | Add `require(side==BUY || side==SELL)` or revert `InvalidSide`. |
| **6** | Medium 🟨 | **Uninitialised locals** – may leak junk on future refactor. | `CLOB`<br>• `_settleIncomingOrder` (`settleParams`)<br>• `_removeNonCompetitiveOrder` (`quoteRefunded`, `baseRefunded`)<br>• `_executeAmendNewOrder` (`newOrder`)<br>`CLOBManager`<br>• `createMarket` (`config`) | Initialise structs explicitly (`SettleParams memory s = …`). |
| **7** | Medium 🟨 | **Locked Ether** – contracts receive ETH but lack withdraw. | `Distributor` (fallback)<br>`AccountManager` (inherited payable)<br>`CLOBManager` (inherited payable) | Add owner-only `sweepETH(address)`; refund mistaken deposits. |
| **8** | Medium 🟨 | **Missing re-entrancy guards** on state-changing funcs that transfer tokens. | • `AccountManager.collectFees`<br>• `GTERouter.wrapSpotDeposit`<br>• `GTERouter.spotDeposit / spotWithdraw / launchpadSell / launchpadBuy` | Add `nonReentrant` or move external calls after state updates. |
| **9** | Low 🟩 | **Off-by-one in fee-array accessor** (`index >= 15` cap). | `PackedFeeRatesLib.getFeeAt` (contracts/clob/types/FeeData.sol) | Change guard to `if (index >= 16) revert FeeTierIndexOutOfBounds();`. |
| **10** | Low 🟩 | **Role-check helper readability** – duplicated admin bit logic. | `OperatorHelperLib.assertHasRole` | Compute `hasRole` & `isAdmin` separately for clarity. |
| **11** | Info ⚙️ | Large set of Slither “incorrect-shift / divide-before-multiply / assembly” in **Solady** math libs – intentional gas optimisations. | Solady utility libraries | Accept as-is or swap for safer (slower) math libs. |
| **12** | Info ⚙️ | “Locked Ether” on `GTERouter` is a false positive – ETH immediately wrapped in WETH. | `GTERouter` (`receive()` & `wrapSpotDeposit`) | No action required. |

---

## Notes
* Column **Affected Contract / Function(s)** gives precise touch-points for patching.  
* IDs correspond to internal tracking; severities follow Code4rena conventions.  
* Items 11–12 are informational; include them only if your process requires full traceability.

```