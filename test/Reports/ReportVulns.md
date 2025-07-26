
# ReportVulns.md  
_Comprehensive list of vulnerabilities detected through manual review **and** automated tools  
(Aderyn + Slither `--show-ignored-findings`)_

| # | Sev. | Description | Affected Contract / Function(s) | LOC* | Recommended Fix |
|---|------|-------------|---------------------------------|------|-----------------|
| **1** | 🟥 | Re-entrancy / balance-inflation – balance is credited **before** ERC-20 `transferFrom`; arbitrary-sender vector. | `AccountManager`  <br>• `deposit`  <br>• `depositFromRouter` |  `AccountManager.sol` 166-175 | Move `safeTransferFrom` **before** `_creditAccount`; add `nonReentrant`. |
| **2** | 🟥 | Faulty “zero-cost-trade” check uses bitwise `&`; can revert valid trades or allow dust. | `CLOB`  <br>• `_processLimitBidOrder`  <br>• `_processLimitAskOrder` |  `CLOB.sol` 505-515 & 545-555 | `if (quote==0 || base==0) revert ZeroCostTrade();`. |
| **3** | 🟧 | Relies on EIP-1153 transient storage – deployment reverts on non-Prague chains. | `TransientMakerData` (all fns) <br>`BookLib` transient helpers |  Multiple (`TransientMakerData.sol` 17-196, `Book.sol` 113-152) | Gate by `chainid` or add storage fallback. |
| **4** | 🟧 | Infinite-loop / DoS – matching loop never breaks if `lotSizeInBase` > remaining amount. | `CLOB`  <br>• `_matchIncomingBid`  <br>• `_matchIncomingAsk` | `CLOB.sol` 742-770 & 777-804 | Break early when `lotSize > incoming.amount` or pre-validate. |
| **5** | 🟧 | Strict enum equality without range check; invalid `Side` bypasses logic. | `GTERouter`  <br>• `_executeClobPostFillOrder` | `GTERouter.sol` 306-320 | `require(side==BUY || side==SELL)`. |
| **6** | 🟨 | Uninitialised locals may leak junk on future refactor. | `CLOB`  <br>• `_settleIncomingOrder` (`settleParams`)  <br>• `_removeNonCompetitiveOrder` (`quoteRefunded`,`baseRefunded`)  <br>• `_executeAmendNewOrder` (`newOrder`)  <br>`CLOBManager`  <br>• `createMarket` (`config`) | `CLOB.sol` 949-959, 875-884, 678-690 <br>`CLOBManager.sol` 177-185 | Initialise structs / vars explicitly. |
| **7** | 🟨 | Locked Ether – contracts can receive ETH but lack withdraw. | `Distributor`  (fallback) 13-198 <br>`AccountManager` 27-341 <br>`CLOBManager` 54-341 | — | Add owner-only `sweepETH(address)`. |
| **8** | 🟨 | Missing re-entrancy guards on state-changing functions that transfer tokens. | `AccountManager.collectFees` 214-232 <br>`GTERouter.wrapSpotDeposit` 140-151 <br>`GTERouter.spotDeposit / spotWithdraw / launchpadSell / launchpadBuy` 112-208 | Various | Add `nonReentrant` or move external calls to end. |
| **9** | 🟩 | Off-by-one in fee-array accessor (`index >= 15` cap but 16 slots). | `PackedFeeRatesLib.getFeeAt` | `FeeData.sol` 56-63 | Guard with `index >= 16`. |
| **10** | 🟩 | Role-check helper readability – admin bit double-counted. | `OperatorHelperLib.assertHasRole` | `OperatorHelperLib.sol` 8-22 | Separate `hasRole` & `isAdmin` checks. |
| **11** | ⚙️ | Slither “incorrect-shift / divide-before-multiply / assembly” warnings in **Solady** libs – intentional gas opts. | Solady utils & math | `lib/solady/**` | Accept or replace with safer libs. |
| **12** | ⚙️ | “Locked Ether” on `GTERouter` is false positive – ETH is wrapped immediately. | `GTERouter` (`receive()`, `wrapSpotDeposit`) | `GTERouter.sol` 98-118, 140-151 | No action needed. |

\* **LOC** – approximate line numbers based on commit `9f06332`; adjust if file shifts.

---

### Notes
* Severities align with Code4rena conventions.  
* Rows 11-12 are informational; fix only if desired for cleanliness or tooling.  
* Apply patches, rerun Slither with `--filter-paths "lib/**"` to verify Critical/High items are cleared.
```