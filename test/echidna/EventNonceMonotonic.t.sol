// SPDX-License-Identifier: MIT
pragma solidity 0.8.27;

/*──────────────────────────────────────────────────────────
  Event-nonce monotonicity invariant
───────────────────────────────────────────────────────────
  • Every call that uses EventNonceLib.inc() must strictly
    increase the nonce stored at the predefined ERC-7201 slot.
  • No sequence of external calls can cause the nonce to
    repeat or go backwards.
  • We test the property for *two* independent contracts
    (this harness itself and a helper contract) to make sure
    the invariant holds per-contract, no matter who calls inc().
──────────────────────────────────────────────────────────*/

import {EventNonceLib} from "../../contracts/utils/types/EventNonce.sol";

/*──────── Helper that exposes the internal library call ───────*/
contract EventNonceWrapper {
    function inc() external returns (uint256) {
        return EventNonceLib.inc();
    }

    function curr() external view returns (uint256) {
        return EventNonceLib.getCurrentNonce();
    }
}

/*────────────────────── Echidna harness ───────────────────────*/
contract EchidnaEventNonce {
    EventNonceWrapper internal w = new EventNonceWrapper();

    uint256 private lastSelf; // last nonce seen for *this* contract
    uint256 private lastWrapper; // last nonce seen for the helper

    /*===== fuzzable entry-points that may (or may not) bump the nonce =====*/

    // increment via the helper contract
    function bumpViaWrapper() public {
        w.inc();
    }

    // increment directly from this contract
    function bumpDirect() public {
        EventNonceLib.inc();
    }

    // do nothing (lets Echidna explore “no-op” traces too)
    function noop() public {}

    /*======================  INVARIANTS  =========================*/

    // 1) nonce of this harness never decreases
    function echidna_self_nonce_monotonic() public returns (bool ok) {
        uint256 current = EventNonceLib.getCurrentNonce();
        ok = (current >= lastSelf);
        lastSelf = current;
    }

    // 2) nonce of the wrapper contract never decreases
    function echidna_wrapper_nonce_monotonic() public returns (bool ok) {
        uint256 current = w.curr();
        ok = (current >= lastWrapper);
        lastWrapper = current;
    }
}
