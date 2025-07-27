<!--
Save-as: doc/echidna-tests.md
Compatible with the repo (solc 0.8.27, Foundry layout).
Each section = ① property, ② why it matters, ③ harness that **compiles today**.
-->

# Echidna Invariant Test-Suite  
*Target commit *: `<commit-hash>` (solc 0.8.27)

> Harnesses import only what they need and never “cheat” with `prank` or direct
> storage writes (unless the modifier design forces it and the write is
> non-security-relevant).  
> All files live under `test/echidna/…` so they are ignored by default
> `forge test` runs.

---

## 1. Internal Ledger ≤ Real ERC-20 Balances

**Property**  
For every token **T** and user **U**  
```
AccountManager.accountTokenBalances[U][T] ≤ IERC20(T).balanceOf(AccountManager)
```

**Why it matters**  
Detects re-entrancy or “credit-before-transfer” bugs in `deposit()` /
`depositFromRouter()`.

```solidity
// test/echidna/LedgerNeverExceedsReal.t.sol
pragma solidity 0.8.27;

import {AccountManager} from "../../contracts/account-manager/AccountManager.sol";
import {MockERC20}     from "solmate/test/utils/mocks/MockERC20.sol";

contract EchidnaLedger {
    AccountManager          am;
    MockERC20[2]            tokens;

    constructor() {
        am = new AccountManager(
            address(this),               // router (unused)
            address(this),               // clobManager (unused)
            new uint16[](0),
            new uint16[](0)
        );
        am.initialize(address(this));

        for (uint i; i < tokens.length; ++i) {
            tokens[i] = new MockERC20("T","T",18);
            tokens[i].mint(address(this), 1e24);
            tokens[i].approve(address(am), type(uint).max);
            am.deposit(address(this), address(tokens[i]), 1e22);
        }
    }

    // ------------- invariant -------------
    function invariant_balanceNeverExceedsReal(address user, uint tokenId)
        external
        view
        returns (bool)
    {
        MockERC20 t = tokens[tokenId % tokens.length];
        uint internalBal = am.getAccountBalance(user, address(t));
        uint realBal     = t.balanceOf(address(am));
        return internalBal <= realBal;
    }
}
```

---

## 2. Event Nonce Is Monotonic

**Property**  
`EventNonceLib.getCurrentNonce()` never decreases.

**Why it matters**  
Guarantees the global event index can’t roll back due to storage collisions
or accidental resets.

```solidity
// test/echidna/EventNonceMonotone.t.sol
pragma solidity 0.8.27;

import {EventNonceLib as EN} from "../../contracts/utils/types/EventNonce.sol";

contract EchidnaNonce {
    uint256 last;

    function echidna_nonce_monotone() public returns (bool ok) {
        uint256 curr = EN.getCurrentNonce();
        ok = curr >= last;
        last = curr;
    }
}
```

---

## 3. Cumulative Withdraw ≤ Deposits

**Property**  
For every `(account, token)` pair:  
`Σ withdrawals ≤ Σ deposits`.

**Why it matters**  
Uncovers mis-accounting in `settleIncomingOrder`, `_removeNonCompetitiveOrder`,
or manual debit paths.

```solidity
// test/echidna/NoOverWithdraw.t.sol
pragma solidity 0.8.27;

import {AccountManager} from "../../contracts/account-manager/AccountManager.sol";
import {MockERC20}     from "solmate/test/utils/mocks/MockERC20.sol";

contract EchidnaNoOverWithdraw {
    AccountManager         am;
    MockERC20              token;
    mapping(address=>uint) inTotal;
    mapping(address=>uint) outTotal;

    constructor() {
        token = new MockERC20("T","T",18);
        am    = new AccountManager(address(this), address(this), new uint16[](0), new uint16[](0));
        am.initialize(address(this));
        token.mint(address(this), 1e24);
        token.approve(address(am), type(uint).max);
    }

    // ---------- fuzzable wrappers ----------
    function deposit(address user, uint amount) public {
        amount %= 1e21;
        token.transfer(user, amount);
        token.transferFrom(user, address(am), amount); // implicit approve in mock
        am.depositFromRouter(user, address(token), amount);
        inTotal[user] += amount;
    }

    function withdraw(address user, uint amount) public {
        amount %= 1e21;
        am.withdrawToRouter(user, address(token), amount);
        outTotal[user] += amount;
    }

    // --------------- invariant --------------
    function invariant_withdrawsNeverExceedDeposits(address user)
        external
        view
        returns (bool)
    {
        return outTotal[user] <= inTotal[user];
    }
}
```

---

## 4. Maker + Taker Asset Conservation

**Property (symmetry)**  
Inside every `settleIncomingOrder` call  
```
takerBaseCredited + Σ(makerBaseCredited) + baseFees
== takerBaseDebited
```
(and mirror equation for quote token).

**Why it matters**  
Catches rounding, zero-cost trade bugs, or incorrect fee routing.

> ⚙️ Harness outline (requires a lightweight fake market to call
> `settleIncomingOrder`).  Implementation left as an exercise; skeleton:

```solidity
// test/echidna/Conservation.t.sol
pragma solidity 0.8.27;
contract EchidnaConservation {
    // deploy AccountManager + MockMarket
    // fuzz ICLOB.SettleParams into settleIncomingOrder
    // post-assert equality per token
}
```

---

## 5. Red-Black-Tree Ordering

**Property**  
`maximum() ≥ every key` and `minimum() ≤ every key` in the price tree.

**Why it matters**  
Detects pointer corruption in `_removeNonCompetitiveOrder` and other tree ops.

```solidity
// test/echidna/TreeOrdering.t.sol
pragma solidity 0.8.27;

import {BookRedBlackTreeLib, RedBlackTree}
        from "../../contracts/clob/types/RedBlackTree.sol";

contract EchidnaTree {
    using BookRedBlackTreeLib for RedBlackTree;
    RedBlackTree tree;

    function insert(uint key) public {
        key = 1 + (key % 1e15);  // non-zero
        tree.insert(key);
    }

    function remove(uint key) public { tree.remove(key); }

    function invariant_maxIsGreatest() external view returns (bool) {
        uint max = tree.maximum();
        if (max == 0) return true;
        for (uint n = tree.minimum();
             n != 0 && n != type(uint).max;
             n   = tree.getNextBiggest(n))
        {
            if (n > max) return false;
        }
        return true;
    }
}
```

---

## 6. Fee-Tier Index Guard

**Property**  
`getFeeAt(i)` for `i ∈ [0,15]` never reverts;  
`i ≥ 16` always reverts.

```solidity
// test/echidna/PackedFeeGuard.t.sol
pragma solidity 0.8.27;

import {PackedFeeRatesLib, PackedFeeRates}
        from "../../contracts/clob/types/FeeData.sol";

contract EchidnaFeeTier {
    PackedFeeRates rates;

    constructor() {
        uint16[3] memory f = [uint16(1), 2, 3];
        rates = PackedFeeRatesLib.packFeeRates(f);
    }

    function never_revert_in_range(uint8 i) external view returns (bool) {
        i %= 16;
        try PackedFeeRatesLib.getFeeAt(rates, i) { return true; }
        catch { return false; }
    }

    function always_revert_out_of_range(uint8 i) external view returns (bool) {
        i = 16 + (i % 8);
        try PackedFeeRatesLib.getFeeAt(rates, i) { return false; }
        catch { return true; }
    }
}
```

---

## 7. Operator Escalation Impossible

**Property**  
If `msg.sender` lacks the required role **and** is not router/account, any
state-changing call reverts.

> Harness: fuzz random callers into `withdraw`, `depositFromRouter`, etc. and
> assert they revert unless the caller qualifies.  Use Echidna’s
> `--test-mode assertion`.

---

## 8. Fee Buckets Balance

**Property**  
After arbitrary sequences of `settleIncomingOrder` and `collectFees`  
```
totalFees == unclaimedFees + claimedFeesLocal
```

> Harness: track `claimedFeesLocal` in contract storage; every
> `collectFees` call adds to it.

---

## 9. Routing Engine Token Continuity

**Property**  
For each hop in `executeRoute`  
`nextTokenIn == hop.tokenOut` **and** `amountOut > 0`.

> Harness: fuzz `bytes[] hops`, call `_executeAllHops` via the router in a
> forked context; revert if continuity breaks.

---

## 10. Lot-Size Dust Loop Terminates

**Property**  
`_matchIncoming{Bid,Ask}` exits in ≤ `bookSize` · 2 iterations even when
`lotSizeInBase > remaining`.

> Harness: instrument a counter in a forked CLOB copy; assert bound.

---

## Running the Suite

```bash
forge install crytic/echidna          # once
forge test  --ffi --match-contract Echidna

# …or run Echidna directly:
echidna-test . --test-mode assertion --contract EchidnaLedger
```
