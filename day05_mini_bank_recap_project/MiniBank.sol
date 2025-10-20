// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18; // Solidity version pinned to 0.8.18 or greater

/*
MiniBank:
- Users can deposit and withdraw ETH.
- The contract owner can check the total balance held by the contract.
- Keeps track of individual user balances.
*/

contract MiniBank {

    // Immutable owner variable, set only once during deployment (gas-efficient)
    address public immutable i_owner; 

    // Constructor runs once at deployment; sets deployer as contract owner
    constructor () {
        i_owner = msg.sender;
    }

    // Modifier restricts function access to the owner only
    modifier onlyOwner () {
        require(msg.sender == i_owner, "Only owner can call this function");
        _; // Continue executing the rest of the function
    }

    // Dynamic array storing addresses of all users who have ever deposited
    address[] public users; 

    // Mapping that tracks how much ETH each address has deposited
    mapping(address user => uint256 balance) public balances; 

    // Public & payable so anyone can deposit ETH
    function deposit () public payable {
        require(msg.value > 0, "You can't deposit 0 ETH"); // Ensure deposit > 0

        // If this is the user's first deposit, add them to the users array
        if (balances[msg.sender] == 0) {
            balances[msg.sender] = msg.value; // Initialize balance
            users.push(msg.sender); // Record new user
        } else { 
            balances[msg.sender] += msg.value; // Add new deposit to existing balance
        }
    }

    // Withdraw a specific amount of ETH from your balance
    function withdraw (uint256 amount) public {
        require(amount <= balances[msg.sender], "You can't withdraw more than you have"); // Ensure enough balance
        balances[msg.sender] -= amount; // Deduct withdrawn amount
        (bool callSuccess, ) = payable(msg.sender).call{value: amount}(""); // Send ETH to user
        require(callSuccess, "Failed to send ETH"); // Revert if transfer fails
    }

    // Owner-only function to check total ETH held in the contract
    function getTotalBankBalance() public view onlyOwner returns (uint256) {
        return address(this).balance; // Contract balance (sum of all deposits)
    }

    // Returns number of unique users who have deposited
    function getUserCount() public view returns (uint256) {
        return users.length;
    }

    // receive() runs when ETH is sent with no data (plain transfer)
    receive() external payable {
        deposit();
    }

    // fallback() runs when ETH or data is sent but no matching function exists
    fallback() external payable {
        deposit();
    }    
}
