// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18; // Solidity version pinned to 0.8.18 or greater

/*
AllowanceWallet:
- Anyone can deposit ETH into the contract
- The contract owner can assign, increase, reduce or revoke allowances for users
- Users can withdraw up to their allowance amount
- The owner can withdraw any excess funds (not reserved by allowances)
*/

contract AllowanceWallet {

    // Immutable variable set only once in the constructor, represents contract owner
    address public immutable i_owner;

    // Constructor runs only once when contract is deployed and sets deployer as owner
    constructor () {
        i_owner = msg.sender;
    }

    // Modifier used to restrict access to owner-only functions
    modifier onlyOwner {
        require (msg.sender == i_owner, "Not owner"); // check if caller is contract owner
        _; // continue with function execution
    }

    // Mapping to store each user's assigned allowance (ETH they can withdraw)
    mapping(address user => uint256 allowance) public allowances;

    // Dynamic array that keeps track of all users who have an assigned allowance
    address[] public users;

    // Owner sets or updates a user allowance (cannot exceed total contract balance)
    function setAllowance(address _user, uint256 amount) public onlyOwner {
        require (amount <= address(this).balance, "Not enough balance"); // check if contract has enough ETH
        if (allowances[_user] == 0) users.push(_user); // if user has no allowance yet, add them to users array
        allowances[_user] = amount; // assign or update allowance value
    }

    // Owner can reduce a user's allowance
    function reduceAllowance(address _user, uint256 amount) public onlyOwner {
        allowances[_user] -= amount; // decrease allowance by specific amount
    }

    // Owner can increase a user's allowance (cannot exceed contract balance)
    function increaseAllowance(address _user, uint256 amount) public onlyOwner {
        require ((allowances[_user] + amount) < address(this).balance, "Not enough balance"); // check contract balance
        allowances[_user] += amount; // increase allowance by specified amount
    }

    // Owner can completely remove a user's allowance
    function revokeAllowance (address _user) public onlyOwner {
        allowances[_user] = 0; // reset allowance to zero
    }

    // Public & payable so anyone can deposit ETH into the contract
    function deposit () public payable {
        require(msg.value > 0, "You can't deposit 0 ETH"); // prevent 0-value deposits
    }

    // Allows users to withdraw ETH up to their current allowance
    function withdraw (uint256 amount) public {
        require(amount > 0, "You can't withdraw 0"); // cannot withdraw 0
        require(allowances[msg.sender] >= amount, "Not enough allowance!"); // check if user has enough allowance
        require(amount <= address(this).balance, "Contract does not have enough balance"); // check contract balance
        allowances[msg.sender] -= amount; // reduce user's allowance by withdrawn amount
        (bool callSuccess, ) = payable(msg.sender).call{value: amount}(""); // send ETH to user
        require(callSuccess, "Call failed!"); // revert if transaction fails
    }

    // Owner-only view function to check total ETH stored in the contract
    function getContractBalance() public view onlyOwner returns (uint256) {
        return address(this).balance; // returns total contract balance in Wei
    }

    // Public view function to check any user's current allowance
    function getUserAllowance(address _user) public view returns (uint256) {
        return allowances[_user]; // returns the allowance assigned to a user
    }

    // Owner-only function to withdraw funds that exceed total user allowances
    function withdrawExcess() public onlyOwner {
        uint256 totalAllowances; // temporary variable to store total assigned allowances
        for (uint256 i = 0; i < users.length; i++) {
            totalAllowances += allowances[users[i]]; // sum all user allowances
        }
        uint256 excess = address(this).balance - totalAllowances; // calculate remaining (unallocated) balance
        payable(i_owner).transfer(excess); // transfer excess ETH to contract owner
    }

    // receive() runs automatically when ETH is sent with no data
    receive() external payable {
        revert("Direct transfers not allowed."); // reject direct ETH transfers
    }

    // fallback() runs when data or unknown function is sent to the contract
    fallback() external payable {
        revert("Direct transfers not allowed."); // reject invalid transactions
    }  
}
