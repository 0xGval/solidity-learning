// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

/*
This contract:
1. Demonstrates the use of mappings in Solidity
2. Shows how to build a simple ETH-based banking system using mapping + struct logic
3. Covers account creation, deposits, withdrawals, balance checks, and account closure
4. Reinforces understanding of storage, modifiers, payable functions, and mapping interactions
*/

contract MyBank {

    /* STATE VARIABLES */

    address public immutable i_owner; // The contract owner’s address (set once and forever immutable)

    constructor() {
        i_owner = msg.sender; // The address that deploys the contract becomes the owner
    } 

    /* MODIFIERS */

    modifier onlyOwner {
        require(msg.sender == i_owner, "Not owner"); // Restrict access: only owner can call certain functions
        _; // Continue execution if condition passes
    }

    modifier onlyAccountHolder {
        require(hasAccount[msg.sender], "You don't have an account!"); // Restrict access to users who opened an account
        _; // Continue function execution
    }

    /* MAPPINGS */

    mapping(address => uint256) public balances; // Maps each address to its stored ETH balance
    mapping(address => bool) public hasAccount;  // Tracks whether an address has already created an account

    /* STRUCTS */

    // Struct representing an account’s data
    struct Account {
        string name;        // The user’s chosen account name
        uint256 balance;    // The user’s current ETH balance
        bool isActive;      // Tracks whether the account is currently active
    }

    // Mapping each user’s address to their account struct
    mapping(address => Account) public accounts; 

    /* CREATE ACCOUNT */

    // Function to open a new account
    function openAccount(string memory _name) public {
        require(hasAccount[msg.sender] == false, "You already have an account!"); // Ensure user doesn’t already have one
        hasAccount[msg.sender] = true; // Mark the user as having an account
        accounts[msg.sender] = Account(_name, 0, true); // Create new Account struct with provided name and 0 balance
        balances[msg.sender] = 0; // Initialize simple mapping balance to 0
    }

    /* DEPOSIT FUNDS */

    // Deposit ETH into your account
    function deposit() public payable onlyAccountHolder {
        balances[msg.sender] += msg.value; // Increase user’s stored balance in balances mapping
        accounts[msg.sender].balance += msg.value; // Also increase balance inside their Account struct
        // NOTE: We update both mappings here for demonstration — in real use, one would be enough
    }

    /* WITHDRAW FUNDS */

    // Withdraw ETH from your account
    function withdraw(uint256 _amount) public onlyAccountHolder {
        require(_amount > 0, "Amount must be > 0"); // Prevent withdrawing 0 ETH
        require(accounts[msg.sender].balance >= _amount, "You can't withdraw more than you own"); // Check sufficient funds
        balances[msg.sender] -= _amount; // Deduct from simple balance mapping
        accounts[msg.sender].balance -= _amount; // Deduct from structured mapping balance as well

        // Send ETH back to the user using low-level call
        (bool callSuccess, ) = payable(msg.sender).call{value: _amount}("");
        require(callSuccess, "Failed to send ETH"); // Revert if transfer fails
    }

    /* CHECK BALANCE */

    // View your current balance (from the simple mapping)
    function checkBalance() public view onlyAccountHolder returns (uint256) {
        return balances[msg.sender]; // Returns the stored ETH balance of the caller
    }

    /* CLOSE ACCOUNT */

    // Close your account and withdraw all remaining ETH
    function closeAccount() public onlyAccountHolder {
        // First, return all remaining ETH to the user
        (bool callSuccess, ) = payable(msg.sender).call{value: balances[msg.sender]}("");
        require(callSuccess, "Failed to send ETH");

        // Then, clean up user data from mappings
        delete balances[msg.sender]; // Reset user balance to 0
        delete accounts[msg.sender]; // Remove the user’s Account struct (sets fields to defaults)
        hasAccount[msg.sender] = false; // Mark the account as closed
    }

    /* OWNER FUNCTIONS */

    // Check if a specific account is active (restricted to contract owner)
    function isAccountActive(address _user) public view onlyOwner returns (bool) {
        return hasAccount[_user]; // Return whether the user currently has an account open
    }

    // Retrieve full account info for a user (restricted to owner)
    function getAccountInfo(address _user) public view onlyOwner returns (Account memory) {
        return accounts[_user]; // Return the entire Account struct for the given address
    }
}
