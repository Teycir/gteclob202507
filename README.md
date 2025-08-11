# Smart Contract Security Audit Findings

This document summarizes the findings from a comprehensive security audit of the GTE CLOB Exchange protocol's smart contracts. The audit identified several critical and high-severity vulnerabilities that could lead to permanent loss of funds, denial of service, and theft.

## Key Vulnerabilities Discovered

The detailed findings for each vulnerability are available in the `test/Reports` folder.

### High Severity Vulnerabilities

1.  **Re-entrancy in `deposit` leading to Balance Inflation and Theft of Funds**
    A critical re-entrancy vulnerability exists in the `AccountManager` contract. The `deposit` function updates a user's internal balance *before* executing the external token transfer. A malicious token contract can call back into the `deposit` function, causing the balance to be credited a second time for a single transfer. This allows an attacker to inflate their balance and withdraw funds they never deposited, leading to a direct theft of other users' assets.

2.  **Faulty “Zero-Cost-Trade” Check Leading to Persistent Denial of Service**
    The `CLOB` contract contains a flawed check intended to prevent zero-cost trades. The implementation uses a bitwise AND (`&`) instead of the correct logical operator, causing many valid trades to revert. An attacker can post a specially-crafted order that bricks every matching attempt, creating an unprivileged, persistent denial-of-service and effectively censoring the order book.

3.  **Integer Overflow in Credit Functions Allowing Arbitrary Fund Creation**
    The `_creditAccount` and `_creditAccountNoEvent` functions in the `AccountManager` contract use `unchecked` blocks for arithmetic operations. This allows for integer overflows to occur without being detected. An attacker can exploit this vulnerability to wrap their account balance from a small amount to `type(uint256).max`, effectively creating a very large balance from a small one. This could be used to steal all funds from the protocol by withdrawing more than they deposited.

4.  **Arbitrary `transferFrom` in Deposit Functions**
    The `deposit` and `depositFromRouter` functions in the `AccountManager` contract use an arbitrary `from` address in `transferFrom` calls. This allows a malicious actor to specify a `from` address other than `msg.sender`, potentially leading to unauthorized fund transfers if approvals are not handled carefully.

### Medium Severity Vulnerabilities

5.  **Usage of `TSTORE` Opcode Bricks Contract on Pre-Cancun Chains**
    The contracts `Book.sol` and `TransientMakerData.sol` make use of the `TSTORE` and `TLOAD` opcodes, which were introduced in the Cancun hard-fork. On EVM-compatible chains that have not yet undergone the Cancun upgrade, these opcodes are not recognized and will cause any transaction that uses them to revert. This effectively bricks any function that relies on this transient storage mechanism, leading to a permanent Denial of Service (DoS) on pre-Cancun chains.

6.  **GTERouter Does Not Validate Inner `hopType`, Leading to Permanent DoS**
    The `GTERouter` does not validate the inner `hopType` from `ClobHopArgs`, allowing an attacker to create a malicious `hops` payload where the outer `hopType` is `CLOB_FILL`, but the inner `hopType` is different. This inconsistency causes the router to fail when looking up the CLOB address, leading to a revert. This allows any user to trigger a permanent denial of service for any market pair.

7.  **Contracts Lock Ether Without a Withdraw Function**
    Several contracts, including `Distributor`, `AccountManager`, and `CLOBManager`, can receive Ether but lack a function to withdraw it. This leads to Ether being permanently locked in the contract.

## Professional Services

For professional smart contract security audits and vulnerability assessments, please contact: teycir@pxdmail.net
