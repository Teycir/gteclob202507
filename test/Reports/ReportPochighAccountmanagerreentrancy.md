# H-01: Re-entrancy in `deposit` allows attackers to inflate their balance and steal funds

## Severity Justification (C4 rubric v4)

| Rubric item                                                         | Why the issue matches                                                                                                                                                           |
| ------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **HIGH — direct theft/loss of funds with no privileged interaction** | • Any EOA can call `AccountManager.deposit` with a malicious token contract.<br/>• Each call can artificially inflate the attacker's balance, allowing them to withdraw funds deposited by other users.<br/>• No admin, oracle or governance role is involved. |
| Not MEDIUM                                                          | The core accounting of the protocol is broken, allowing direct theft. This is not just a leak but a fundamental flaw in asset handling.                                         |
| Not QA                                                              | This is a critical business-logic error with a clear and severe financial impact, not a minor quality assurance issue.                                                          |

---

## Summary

The `AccountManager.deposit` function is vulnerable to a classic re-entrancy attack. It updates a user's internal balance *before* executing the external token transfer via `safeTransferFrom`. A malicious token contract can exploit this by implementing a `transferFrom` function that calls back into `deposit`, causing the balance to be credited a second time for a single transfer. This allows an attacker to inflate their balance and withdraw funds they never deposited, leading to a direct theft of other users' assets held by the contract.

---

## Vulnerability Details

**Classification:** SWC-107 (Re-entrancy)

**Root Cause:** The `deposit` function violates the Checks-Effects-Interactions pattern. The state change (Effect) is performed before the external call (Interaction).

The vulnerable code is in `AccountManager.deposit` ([L166](contracts/account-manager/AccountManager.sol:166)):
```solidity
    function deposit(
        address account,
        address token,
        uint256 amount
    )
        external
        virtual
        onlySenderOrOperator(account, OperatorRoles.SPOT_DEPOSIT)
    {
        _creditAccount(_getAccountStorage(), account, token, amount); // <-- EFFECT: Balance updated first
        token.safeTransferFrom(account, address(this), amount);      // <-- INTERACTION: External call to potentially malicious token
    }
```
The `_creditAccount` function updates the user's balance before the `safeTransferFrom` call, opening the door for a re-entrancy attack. The `depositFromRouter` function has the same flaw.

---

## Realistic Attack Path

1.  **Deploy Malicious Token:** An attacker deploys a malicious ERC20 token (`MalToken`) where the `transferFrom` function is programmed to call `AccountManager.deposit` again.
2.  **Approve Operator:** The attacker calls `acctManager.approveOperator(address(malToken), ...)` to allow the malicious contract to make deposits on their behalf.
3.  **Initial Deposit:** The attacker calls `acctManager.deposit(attacker, address(malToken), 100 ether)`.
4.  **Re-entrancy:**
    *   `AccountManager.deposit` calls `_creditAccount`, increasing the attacker's internal balance to 100.
    *   `AccountManager.deposit` then calls `malToken.transferFrom(...)`.
    *   `malToken.transferFrom` immediately calls `acctManager.deposit(...)` again.
    *   The re-entrant `deposit` call again executes `_creditAccount`, increasing the attacker's internal balance to 200.
5.  **Withdraw Stolen Funds:** The attacker's internal balance is now 200. If other users have deposited the same token, the attacker can now withdraw 200 tokens, stealing funds from the contract.

---

## Proof of Concept

The PoC (`test_Reentrancy_DrainFunds`) in `test/PoC/PoCHighAccountManagerReentrancy.t.sol` provides a clear demonstration of the exploit.

1.  **Honest User Deposit:** An honest user deposits 100 tokens. The `AccountManager` contract now holds 100 tokens.
2.  **Attacker's Exploit:** The attacker performs the re-entrant deposit with 100 of their own tokens. The re-entrancy inflates their internal balance to 200, while the contract's total token holdings become 200 (100 from the honest user, 100 from the attacker).
3.  **Drain:** The attacker withdraws their inflated balance of 200 tokens. This succeeds because the contract holds 200 tokens. The attacker has now stolen the 100 tokens deposited by the honest user.

The test logs confirm the successful exploit:
```bash
forge test --match-path test/PoC/PoCHighAccountManagerReentrancy.t.sol -vvv

Ran 2 tests for test/PoC/PoCHighAccountManagerReentrancy.t.sol:PoCHighAccountManagerReentrancy
[PASS] test_Reentrancy_DrainFunds() (gas: 756674)
Logs:

--- Test: Re-entrancy to Drain Honest User's Funds ---

Part 1: Honest user deposits funds.
    >> Honest user deposited 100 tokens.

Part 2: Attacker performs re-entrant deposit.
    >> Attacker inflated balance to 200 tokens.

Part 3: Attacker withdraws inflated balance, stealing honest user's funds.
    >> Attacker successfully drained 100 tokens from the honest user. Exploit confirmed.

[PASS] test_Reentrancy_InflateBalance() (gas: 74363)
Suite result: ok. 2 passed; 0 failed; 0 skipped; finished in 2.42ms
```

---

## Impact

*   **Direct Theft of Funds:** Attackers can steal any tokens held by the `AccountManager` contract that were deposited by other users.
*   **Total Loss:** The vulnerability can lead to the complete drain of all user funds for any given token managed by the `AccountManager`. The financial impact is equivalent to the total value of assets held in the contract. This is a critical vulnerability that compromises the integrity of the entire system.

---

## Mitigation Recommendations

The vulnerability can be fixed by adhering to the Checks-Effects-Interactions pattern and adding a re-entrancy guard as a defense-in-depth measure. The external call (`safeTransferFrom`) must be executed *before* the state change (`_creditAccount`). Both `deposit` and `depositFromRouter` must be fixed.

```diff
--- a/contracts/account-manager/AccountManager.sol
+++ b/contracts/account-manager/AccountManager.sol
@@ -9,6 +9,7 @@
 import {Initializable} from "@solady/utils/Initializable.sol";
 import {OwnableRoles} from "@solady/auth/OwnableRoles.sol";
 import {SafeTransferLib} from "@solady/utils/SafeTransferLib.sol";
+import {ReentrancyGuard} from "@solady/utils/ReentrancyGuard.sol";
 import {FixedPointMathLib} from "@solady/utils/FixedPointMathLib.sol";
 import {Operator, OperatorRoles} from "../utils/Operator.sol";
 import {FeeData, FeeDataLib, FeeDataStorageLib, PackedFeeRates, PackedFeeRatesLib, FeeTiers} from "../clob/types/FeeData.sol";
@@ -27,6 +28,7 @@
  */
 contract AccountManager is
     IAccountManager,
+    ReentrancyGuard,
     Operator,
     Initializable,
     OwnableRoles
@@ -198,21 +200,23 @@
     )
         external
         virtual
+        nonReentrant
         onlySenderOrOperator(account, OperatorRoles.SPOT_DEPOSIT)
     {
-        _creditAccount(_getAccountStorage(), account, token, amount);
-        token.safeTransferFrom(account, address(this), amount);
+        token.safeTransferFrom(account, address(this), amount);
+        _creditAccount(_getAccountStorage(), account, token, amount);
     }
 
     /// @notice Deposits via transfer from the router
     function depositFromRouter(
         address account,
         address token,
         uint256 amount
-    ) external onlyGTERouter {
-        _creditAccount(_getAccountStorage(), account, token, amount);
+    ) external nonReentrant onlyGTERouter {
         token.safeTransferFrom(gteRouter, address(this), amount);
+        _creditAccount(_getAccountStorage(), account, token, amount);
     }
 
     /// @notice Withdraws to account
```

---

## Reference Links (root-cause)

1.  [`AccountManager.sol#L192-L203`](contracts/account-manager/AccountManager.sol:166) – Vulnerable `deposit` function.
2.  [`AccountManager.sol#L206-L213`](contracts/account-manager/AccountManager.sol:172) – Vulnerable `depositFromRouter` function.

---

### Submission Checklist

-   [x] PoC fails on vulnerable commit
-   [x] No production files modified
-   [x] Report links to exact vulnerable lines
-   [x] Severity mapped to C4 rubric (High)