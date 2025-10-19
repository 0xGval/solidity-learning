// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18; 

/*
This contract:
1. Shows how receive() and fallback() work with ETH transactions
2. Demonstrates how the contract reacts when called with or without data
*/

contract FallbackAndReceive {

    uint256 public number; // just a counter to track calls to receive()

    /*
    receive() is triggered when:
    - The contract receives plain ETH (no data attached)
    - msg.data is empty
    - Function is marked as external and payable

    Example:
    If you send ETH to the contract address directly from MetaMask or Remix (no function call),
    this function runs automatically.
    */
    receive() external payable {
        number++; // each time someone sends ETH, we increment number
    }

    /*
    fallback() is triggered when:
    - The contract is called with data but no matching function exists
    - Or, when receive() doesn’t exist and plain ETH is sent

    Common uses:
    - Handling wrong function calls
    - Proxy contracts / low-level delegatecall patterns
    */
    fallback() external payable {
        number = number + 10;
    }
}
