// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18; // Solidity version pinned to 0.8.18 or greater

contract Mappings {

    // Simple number storage example
    uint256 number;

    function store(uint256 myFavNumber_) public {
        number = myFavNumber_;
    }

    function retrieve() public view returns (uint256) {
        return number;
    }

    // Struct to define a person
    struct Person {
        uint256 favNumber;
        string name;
    }

    // Dynamic array to hold Person structs
    Person[] public listOfPeople;

    // Add a new Person to the array
    function addPerson(uint256 _favNumber, string memory _name) public {
        listOfPeople.push(Person(_favNumber, _name));
        // Note: We use push() to add a new entry to the end of the array
    }

       /*
    The dynamic array listOfPeople stores all Person structs we add.
    If we want to find one specific person (for example, by name),
    we would need to loop through every index in the array until we find a match.

    This works but becomes inefficient as the array grows — 
    looping costs gas and takes more computation.

    A better way is to use a mapping — a sort of key → value dictionary.
    In this case, we can directly link a person's name to their favorite number
    and retrieve it instantly without looping.
    */

    // A mapping connects a unique key (string name) to a value (favorite number)
    mapping(string => uint256) public nameToFavNumber; 

    // Add a new entry to the mapping (key-value pair)
    function addPersonToMapping(string memory _name, uint256 _favNumber) public {
        // Save the favorite number for a given name
        nameToFavNumber[_name] = _favNumber;
    }


}
