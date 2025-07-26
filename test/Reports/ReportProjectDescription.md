### Project Description: Decentralized CLOB Exchange

This project implements a sophisticated decentralized exchange that operates on a central limit order book model, similar to traditional financial exchanges. The architecture is modular, separating concerns into distinct, interacting smart contracts.

**Core Components:**

*   **`CLOBManager.sol` (The Market Regulator):** This contract acts as the central authority for creating and managing trading markets.
    *   **Purpose:** It's a factory that deploys new `CLOB` contracts for specific token pairs. Think of it as the city planning office that zones new areas for marketplaces.
    *   **Key State Variables:**
        *   `beacon`: A proxy pattern that allows all `CLOB` contracts to share the same logic, enabling efficient upgrades.
        *   `clob`: A mapping from a token pair to its dedicated market address.
    *   **User-Facing Functions:**
        *   `createMarket`: Allows authorized users to launch a new trading pair.

*   **`CLOB.sol` (The Marketplace):** This is the heart of the exchange, where the actual trading occurs for a single token pair.
    *   **Purpose:** It maintains the order book, matching buy (bid) and sell (ask) orders. It's the digital equivalent of a trading floor.
    *   **Key State Variables:**
        *   `bidTree` & `askTree`: Red-black trees that efficiently store and sort buy and sell orders by price.
        *   `orders`: A mapping that stores the details of every order.
    *   **User-Facing Functions:**
        *   `postLimitOrder`: Place an order to buy or sell at a specific price.
        *   `postFillOrder`: Place an order to buy or sell at the best available market price.
        *   `cancel`: Cancel an existing order.
        *   `amend`: Modify an existing order.

*   **`AccountManager.sol` (The Bank):** This contract is responsible for all user funds and balance management.
    *   **Purpose:** It securely holds user deposits and processes withdrawals, acting as a centralized vault for the entire platform. This separation of funds from the trading logic enhances security.
    *   **Key State Variables:**
        *   `accountTokenBalances`: A mapping that tracks the balance of each token for every user.
    *   **User-Facing Functions:**
        *   `deposit`: Add funds to a trading account.
        *   `withdraw`: Remove funds from a trading account.
        *   `settleIncomingOrder`: An internal-facing function called by a `CLOB` contract after a trade to update the balances of the involved traders and collect fees.

*   **`GTERouter.sol` (The Smart Broker):** This contract provides a powerful interface for executing complex trades.
    *   **Purpose:** It allows users to route trades through multiple markets or even other exchanges (like Uniswap) to find the best possible price. It's like a smart GPS for your trades.
    *   **Key State Variables:**
        *   `uniV2Router`: An interface to an external Uniswap router, enabling cross-exchange swaps.
    *   **User-Facing Functions:**
        *   `executeRoute`: The main function that takes a series of "hops" to execute a multi-step trade.

*   **`Book.sol` (The Ledger):** This library defines the data structures for the order book.
    *   **Purpose:** It provides the blueprint for how orders and price levels are stored and managed within the `CLOB` contract, ensuring data integrity and efficiency.
    *   **Key State Variables:**
        *   `Limit`: A struct representing a single price level in the order book.
        *   `Book`: The main struct that organizes the entire order book.