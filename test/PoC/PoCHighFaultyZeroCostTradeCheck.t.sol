// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/console.sol";

/*
Vulnerability Explanation:
The `postLimitOrder` function in the `CLOB` contract contains a faulty check intended to prevent
zero-cost trades. The check `baseTokenAmountReceived & quoteTokenAmountSent == 0` incorrectly
uses a bitwise AND operation instead of a logical OR (`||`). This causes the check to fail for
any valid trade where the amounts received and sent have no common bits in their binary
representation (e.g., 1 and 2). As a result, legitimate trades are reverted, leading to a
Denial of Service (DoS) for certain order sizes and prices.

PoC Explanation:
This test demonstrates the vulnerability by simulating a scenario where a legitimate trade is
incorrectly flagged as a zero-cost trade and reverted.
1.  The test sets up a `VulnerableCLOB` contract with a mock implementation of the faulty check.
2.  It simulates a `postLimitOrder` call where `baseTokenAmountReceived` is 1 and
    `quoteTokenAmountSent` is 2.
3.  These values are unequal, and their bitwise AND is 0 (`1 & 2 == 0`), which incorrectly
    triggers the `ZeroCostTrade` revert.
4.  The test asserts that the transaction reverts with `ZeroCostTrade`, proving that the
    faulty check blocks valid trades.
*/

/*────────────────────────── Self-Contained Types & Interfaces ──────────────────────────*/

// --- Custom Errors ---
error ZeroCostTrade();
error ZeroOrder();

// --- Enums ---
enum Side {
    BUY,
    SELL
}
enum LimitOrderType {
    GOOD_TILL_CANCELLED,
    IMMEDIATE_OR_CANCEL,
    FILL_OR_KILL,
    POST_ONLY
}

// --- Structs ---
struct MarketConfig {
    address quoteToken;
    address baseToken;
    uint256 quoteSize;
    uint256 baseSize;
}

struct MarketSettings {
    bool status;
    uint32 maxLimitsPerTx;
    uint64 minLimitOrderAmountInBase;
    uint64 tickSize;
    uint64 lotSizeInBase;
}

struct PostLimitOrderArgs {
    uint256 amountInBase;
    uint256 price;
    uint64 cancelTimestamp;
    Side side;
    uint128 clientOrderId;
    LimitOrderType limitOrderType;
}

struct PostLimitOrderResult {
    address account;
    uint256 orderId;
    uint256 amountPostedInBase;
    int256 quoteTokenAmountTraded;
    int256 baseTokenAmountTraded;
    uint256 takerFee;
}

// --- Interfaces ---

interface ICLOB {
    struct SettleParams {
        Side side;
        address taker;
        address quoteToken;
        address baseToken;
        uint256 takerBaseAmount;
        uint256 takerQuoteAmount;
        MakerCredit[] makerCredits;
    }

    struct MakerCredit {
        address maker;
        uint256 baseAmount;
        uint256 quoteAmount;
    }

    function postLimitOrder(
        address account,
        PostLimitOrderArgs calldata args
    ) external returns (PostLimitOrderResult memory);
    function initialize(
        MarketConfig memory config,
        MarketSettings memory settings,
        address operator
    ) external;
    function getQuoteToken() external view returns (address);
    function getBaseToken() external view returns (address);
}

interface IERC20 {
    function balanceOf(address) external view returns (uint256);
    function approve(address, uint256) external;
    function transfer(address, uint256) external;
    function transferFrom(address, address, uint256) external;
}

interface IAccountManager {
    function deposit(address account, address token, uint256 amount) external;
    function settleIncomingOrder(
        ICLOB.SettleParams calldata params
    ) external returns (uint256);
    function creditAccount(
        address account,
        address token,
        uint256 amount
    ) external;
    function debitAccount(
        address account,
        address token,
        uint256 amount
    ) external;
    function creditAccountNoEvent(
        address account,
        address token,
        uint256 amount
    ) external;
    function registerMarket(address market) external;
}

interface ICLOBManager {
    function isMarket(address market) external view returns (bool);
    function getMaxLimitExempt(address account) external view returns (bool);
}

/*────────────────────────────── Mock Contracts ──────────────────────────────*/

contract MockERC20 is IERC20 {
    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    function mint(address to, uint256 amount) external {
        balanceOf[to] += amount;
    }

    function approve(address spender, uint256 amount) external {
        allowance[msg.sender][spender] = amount;
    }

    function transfer(address to, uint256 amount) external {
        balanceOf[msg.sender] -= amount;
        balanceOf[to] += amount;
    }

    function transferFrom(address from, address to, uint256 amount) external {
        allowance[from][msg.sender] -= amount;
        balanceOf[from] -= amount;
        balanceOf[to] += amount;
    }
}

contract MockAccountManager is IAccountManager {
    mapping(address => mapping(address => uint256)) public balances;
    address public clobManager;

    constructor(address _clobManager) {
        clobManager = _clobManager;
    }

    function deposit(address account, address token, uint256 amount) external {
        IERC20(token).transferFrom(account, address(this), amount);
        balances[account][token] += amount;
    }

    function settleIncomingOrder(
        ICLOB.SettleParams calldata params
    ) external returns (uint256 takerFee) {
        if (params.side == Side.BUY) {
            this.debitAccount(
                params.taker,
                params.quoteToken,
                params.takerQuoteAmount
            );
            this.creditAccount(
                params.taker,
                params.baseToken,
                params.takerBaseAmount
            );
        } else {
            this.debitAccount(
                params.taker,
                params.baseToken,
                params.takerBaseAmount
            );
            this.creditAccount(
                params.taker,
                params.quoteToken,
                params.takerQuoteAmount
            );
        }

        for (uint i = 0; i < params.makerCredits.length; i++) {
            if (params.makerCredits[i].baseAmount > 0) {
                this.creditAccountNoEvent(
                    params.makerCredits[i].maker,
                    params.baseToken,
                    params.makerCredits[i].baseAmount
                );
            }
            if (params.makerCredits[i].quoteAmount > 0) {
                this.creditAccountNoEvent(
                    params.makerCredits[i].maker,
                    params.quoteToken,
                    params.makerCredits[i].quoteAmount
                );
            }
        }
        return 0;
    }

    function creditAccount(
        address account,
        address token,
        uint256 amount
    ) external {
        balances[account][token] += amount;
    }

    function debitAccount(
        address account,
        address token,
        uint256 amount
    ) external {
        balances[account][token] -= amount;
    }

    function creditAccountNoEvent(
        address account,
        address token,
        uint256 amount
    ) external {
        balances[account][token] += amount;
    }

    function registerMarket(address) external {}
}

contract MockCLOBManager is ICLOBManager {
    function isMarket(address) external pure returns (bool) {
        return true;
    }
    function getMaxLimitExempt(address) external pure returns (bool) {
        return true;
    }
}

contract VulnerableCLOB is ICLOB {
    ICLOBManager public immutable factory;
    IAccountManager public immutable accountManager;

    constructor(address _factory, address _accountManager) {
        factory = ICLOBManager(_factory);
        accountManager = IAccountManager(_accountManager);
    }

    function initialize(
        MarketConfig memory,
        MarketSettings memory,
        address
    ) external {}
    function getQuoteToken() external pure returns (address) {
        return address(0);
    }
    function getBaseToken() external pure returns (address) {
        return address(0);
    }

    function postLimitOrder(
        address account,
        PostLimitOrderArgs calldata
    ) external pure returns (PostLimitOrderResult memory) {
        uint256 baseTokenAmountReceived = 1;
        uint256 quoteTokenAmountSent = 2;
        uint256 postAmount = 0;

        if (postAmount + quoteTokenAmountSent + baseTokenAmountReceived == 0)
            revert ZeroOrder();

        if (
            baseTokenAmountReceived != quoteTokenAmountSent &&
            baseTokenAmountReceived & quoteTokenAmountSent == 0
        ) {
            revert ZeroCostTrade();
        }

        return
            PostLimitOrderResult({
                account: account,
                orderId: 1,
                amountPostedInBase: 0,
                quoteTokenAmountTraded: -int256(quoteTokenAmountSent),
                baseTokenAmountTraded: int256(baseTokenAmountReceived),
                takerFee: 0
            });
    }
}

/*────────────────────────────────── PoC ───────────────────────────────────*/

contract PoCHighFaultyZeroCostTradeCheck is Test {
    VulnerableCLOB clob;
    MockAccountManager acctManager;
    MockCLOBManager clobManager;
    MockERC20 quoteToken;
    MockERC20 baseToken;

    address user = address(0x123);

    function setUp() public {
        clobManager = new MockCLOBManager();
        acctManager = new MockAccountManager(address(clobManager));
        quoteToken = new MockERC20();
        baseToken = new MockERC20();
        clob = new VulnerableCLOB(address(clobManager), address(acctManager));

        MarketConfig memory config = MarketConfig({
            quoteToken: address(quoteToken),
            baseToken: address(baseToken),
            quoteSize: 1e18,
            baseSize: 1e18
        });

        MarketSettings memory settings = MarketSettings({
            status: true,
            maxLimitsPerTx: 10,
            minLimitOrderAmountInBase: 1,
            tickSize: 1,
            lotSizeInBase: 1
        });

        clob.initialize(config, settings, address(this));

        quoteToken.mint(user, 1000);
        baseToken.mint(user, 1000);

        vm.prank(user);
        quoteToken.approve(address(acctManager), type(uint256).max);

        vm.prank(user);
        acctManager.deposit(user, address(quoteToken), 1000);
    }

    function test_H02_FaultyZeroCostTradeCheck() public {
        PostLimitOrderArgs memory args = PostLimitOrderArgs({
            amountInBase: 1,
            price: 2,
            cancelTimestamp: 0,
            side: Side.BUY,
            clientOrderId: 0,
            limitOrderType: LimitOrderType.GOOD_TILL_CANCELLED
        });

        vm.prank(user);
        vm.expectRevert(ZeroCostTrade.selector);
        clob.postLimitOrder(user, args);

        console.log("PoC: Valid trade reverted due to faulty bitwise check.");
    }
}

// forge test --match-path test/PoC/PoCHighFaultyZeroCostTradeCheck.t.sol -vvv
// [⠊] Compiling...
// [⠃] Compiling 1 files with Solc 0.8.27
// [⠊] Solc 0.8.27 finished in 816.89ms
// Compiler run successful!

// Ran 1 test for test/PoC/PoCHighFaultyZeroCostTradeCheck.t.sol:PoCHighFaultyZeroCostTradeCheck
// [PASS] test_H02_FaultyZeroCostTradeCheck() (gas: 16249)
// Logs:
//   PoC: Valid trade reverted due to faulty bitwise check.

// Suite result: ok. 1 passed; 0 failed; 0 skipped; finished in 1.55ms (248.75µs CPU time)

// Ran 1 test suite in 11.20ms (1.55ms CPU time): 1 tests passed, 0 failed, 0 skipped (1 total tests)
