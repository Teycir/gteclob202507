// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*───────────────────────────────────────────────────────────────
         ROUTING ENGINE – TOKEN CONTINUITY INVARIANT
─────────────────────────────────────────────────────────────────
  Property: After any sequence of calls a user performs through
  GTERouter, the router itself must **never** keep any ERC-20
  balance.  (Tokens must either be deposited into AccountManager
  or returned to the user.)

  – We exercise the two public entry-points that move tokens
    through the router (`spotDeposit` and `spotWithdraw`).
  – A lightweight in-memory AccountManager is mocked so the whole
    stack compiles quickly and runs inside Echidna.
  – Two dummy ERC-20s are deployed (one doubles as WETH).
  – The single invariant simply checks that the router’s balance
    of *any* tracked token is always zero or decreases (i.e. can
    never be positive).

  Run:
      echidna-test . --contract EchidnaRouterTokenContinuity \
                     --filter "(^echidna_)"
───────────────────────────────────────────────────────────────*/

import {GTERouter} from "../../contracts/router/GTERouter.sol";
import {SafeTransferLib} from "@solady/utils/SafeTransferLib.sol";

/*───── Minimal ERC-20 implementation good enough for SafeTransferLib ────*/
contract ERC20Mock {
    string public name;
    string public symbol;
    uint8 public constant decimals = 18;
    uint256 public totalSupply;

    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    constructor(string memory n, string memory s) {
        name = n;
        symbol = s;
    }

    function _mint(address to, uint256 amount) internal {
        balanceOf[to] += amount;
        totalSupply += amount;
        emit Transfer(address(0), to, amount);
    }

    /* --- ERC-20 --- */
    function approve(address spender, uint256 amount) external returns (bool) {
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }
    function transfer(address to, uint256 amount) external returns (bool) {
        _transfer(msg.sender, to, amount);
        return true;
    }
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool) {
        uint256 a = allowance[from][msg.sender];
        require(a >= amount, "allow");
        allowance[from][msg.sender] = a - amount;
        _transfer(from, to, amount);
        return true;
    }
    /* --- helpers --- */
    function mint(address to, uint256 amount) external {
        _mint(to, amount);
    }

    function _transfer(address from, address to, uint256 amount) internal {
        require(balanceOf[from] >= amount, "bal");
        unchecked {
            balanceOf[from] -= amount;
        }
        balanceOf[to] += amount;
        emit Transfer(from, to, amount);
    }
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
}

/*───── Very small WETH replacement (only deposit/withdraw) ────*/
contract WETHMock is ERC20Mock("Wrapped Ether", "WETH") {
    function deposit() external payable {
        _mint(msg.sender, msg.value);
    }
    function withdraw(uint256 amount) external {
        require(balanceOf[msg.sender] >= amount, "bal");
        unchecked {
            balanceOf[msg.sender] -= amount;
        }
        payable(msg.sender).transfer(amount);
    }
    receive() external payable {}
}

/*───── Minimal AccountManager used by router ────*/
contract MiniAccountManager {
    using SafeTransferLib for address;

    address public immutable gteRouter;
    mapping(address => mapping(address => uint256)) public balance;

    constructor(address _router) {
        gteRouter = _router;
    }

    /* spot deposit coming from router */
    function depositFromRouter(
        address account,
        address token,
        uint256 amount
    ) external {
        require(msg.sender == gteRouter, "not router");
        token.safeTransferFrom(msg.sender, address(this), amount);
        balance[account][token] += amount;
    }

    /* router-initiated withdrawal back to router */
    function withdrawToRouter(
        address account,
        address token,
        uint256 amount
    ) external {
        require(msg.sender == gteRouter, "not router");
        uint256 bal = balance[account][token];
        require(bal >= amount, "bal");
        balance[account][token] = bal - amount;
        token.safeTransfer(gteRouter, amount);
    }

    /* direct user calls – simplified; only what the harness needs */
    function deposit(address account, address token, uint256 amount) external {
        token.safeTransferFrom(account, address(this), amount);
        balance[account][token] += amount;
    }
    function withdraw(address account, address token, uint256 amount) external {
        require(msg.sender == account, "auth");
        uint256 bal = balance[account][token];
        require(bal >= amount, "bal");
        balance[account][token] = bal - amount;
        token.safeTransfer(account, amount);
    }

    /* dummy stubs so the compile succeeds */
    function registerMarket(address) external {}
    function settleIncomingOrder(GTERouter) external returns (uint256) {
        return 0;
    }
}

/*────────────────────────── Echidna Harness ───────────────────────────*/
contract EchidnaRouterTokenContinuity {
    using SafeTransferLib for address;

    /* test actors */
    WETHMock internal weth;
    ERC20Mock internal token; // some random ERC-20
    GTERouter internal router;
    MiniAccountManager internal acct;

    constructor() payable {
        weth = new WETHMock();
        token = new ERC20Mock("Mock", "MOCK");

        /* deploy minimal account manager first (router address not yet known),
           then router, finally tell AM its router address through constructor arg */
        acct = new MiniAccountManager(address(0)); // temp 0; fixed below
        router = new GTERouter(
            payable(address(weth)),
            address(0), // launchpad
            address(acct), // account manager
            address(0), // clobManager
            address(0), // uniV2 router
            address(0) // permit2
        );

        /* make router address immutable inside MiniAccountManager */
        // (we cannot assign after construction; deploy a fresh one correctly)
        acct = new MiniAccountManager(address(router));
        // Re-wire router to new AM (storage update via assembly is over-kill for the test;
        // just deploy again fresh)
        router = new GTERouter(
            payable(address(weth)),
            address(0),
            address(acct),
            address(0),
            address(0),
            address(0)
        );

        /* give Echidna plenty of tokens to play with */
        token.mint(address(this), 1e30);
        weth.mint(address(this), 1e30);
    }

    /*===================  FUZZABLE ENTRY-POINTS  ===================*/

    /* user deposits directly through the router (fromRouter=true) */
    function fuzz_deposit_via_router(uint256 amt) public {
        amt = bound(amt, 1, 1e24);
        token.approve(address(router), amt);
        router.spotDeposit(address(token), amt, true);
    }

    /* user withdraws directly through the router */
    function fuzz_withdraw_via_router(uint256 amt) public {
        uint256 bal = acct.balance(address(this), address(token));
        if (bal == 0) return;
        amt = bound(amt, 1, bal);
        router.spotWithdraw(address(token), amt);
    }

    /* dummy noop so Echidna can insert gaps */
    function noop() external {}

    /*=====================  HELPERS  =====================*/

    function bound(
        uint256 x,
        uint256 min,
        uint256 max
    ) internal pure returns (uint256) {
        return x < min ? min : (x > max ? max : x);
    }

    /*=====================  INVARIANT  =====================*/

    function echidna_router_holds_no_tokens() external view returns (bool ok) {
        ok =
            (token.balanceOf(address(router)) == 0) &&
            (weth.balanceOf(address(router)) == 0);
    }
}
