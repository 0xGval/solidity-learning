// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

/*
This contract:
1. Shows how to use mappings in Solidity
2. Demonstrates adding, reading, updating, and deleting mapping values
3. Includes simple mappings, structured mappings (with structs), and practical interaction patterns
*/

contract Mappings {
    // A mapping is a key-value data structure (like a dictionary or hashmap)
    // It allows fast lookup of values using a unique key (like an address or string)

    mapping (address user => uint256 balance) public balances; // A mapping storing address => balance
    mapping (address user => bool hasProfile) public isRegistered; // A mapping storing address => (registration status) boolean

    struct Person {
        string name;
        uint256 age;
        uint256 favNumber;
    }

    mapping (address user => Person) public persons; // Mapping of addresses to Person structs


    /* ADDING TO MAPPINGS */
    // Add or update a balance for a user (key = address, value = uint)
    function setBalance (address _user, uint256 _balance) public {
        require ( _user != address(0), "Invalid Address"); // Prevent zero address
        balances[_user] = _balance; // Set or update balance
    }

    // Add or update registration status
    function registerUser(address _user) public {
        require(_user != address(0), "Invalid address");
        isRegistered[_user] = true; // Mark as registered
    }

    // Add a structured mapping entry
    function setPerson(address _user, string memory _name, uint256 _age, uint256 _favNumber) public {
        require(_user != address(0), "Invalid address");
        persons[_user] = Person (_name, _age, _favNumber);
    }

    /* READING FROM MAPPINGS */

    // Read balance for a specific user
    function getBalance (address _user) public view returns (uint256) {
        return balances[_user]; // Returns 0 if not set (default)
    }

    // Read registration status for a specific user
    function getRegistrationStatus(address _user) public view returns (bool){
        return isRegistered[_user]; // Returns false if not set (default)
    }
    
    // Read structured Person data for a user
    function getPerson(address _user) public view returns (Person memory) {
        return persons[_user]; // Returns empty struct if not set
    }


    /* UPDATING MAPPINGS */
    function increaseBalance(address _user, uint256 _amount) public {
    require(_user != address(0), "Invalid address");
    balances[_user] += _amount; // Increase the existing balance
    }

    // Decrease balance safely
    function decreaseBalance(address _user, uint256 _amount) public {
    require(_user != address(0), "Invalid address");
    require(balances[_user] >= _amount, "Insufficient balance");
    balances[_user] -= _amount;
    }

    // Update Person struct partially (only favNumber for example)
    function updatePersonFavNumber(address _user, uint256 _newFavNumber) public {
        require(bytes(persons[_user].name).length > 0, "Person not found"); // Ensures the struct exists
        persons[_user].favNumber = _newFavNumber;
    }

    /* DELETING ENTRIES FROM MAPPINGS */
    function deleteBalance(address _user) public {
    require(_user != address(0), "Invalid address");
    balances[_user] = 0; // Reset to 0
    }

    function deletePerson(address _user) public {
    require(_user != address(0), "Invalid address");
    delete persons[_user]; // Reset struct fields to default
    }

    /* CHECKING EXISTENCE */
    // Check if a person exists (by checking if name is set)
    function personExists(address _user) public view returns (bool) {
        return bytes(persons[_user].name).length > 0; // Returns true if name is not empty
    }

    // Check if user has a non-zero balance
    function hasBalance(address _user) public view returns (bool) {
        return (balances[_user] > 0);
    }

    /* RESETTING MAPPINGS */

    // ⚠️ Mappings cannot be deleted or iterated directly like arrays
    // We can only reset specific keys manually (as shown in delete functions)
    // Or recreate the contract state entirely


}