// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;  // Solidity version pinned to 0.8.18 or greater

// The EVM can read and write to several places
// - Stack - Memory - Storage - Calldata - Returndata - Code
//   (Write—not read—logs, and Read—not write—chain data) ++ more advanced stuff
contract Memory {

    // calldata, memory, storage

    struct Person {
        uint256 favNumber;
        string name;
    }

    // We are creating an empty array using the Person type we created above.
    // Since it's outside of a function it will be a storage variable (see below).
    Person[] public listOfPeople;

    function addPerson(uint256 _favNumber, string memory _name) public {
        listOfPeople.push(Person(_favNumber, _name));
    }

    // when we call addPerson we pass e.g. 15, "Jhon" but we can never access that variable again
    // because it existed in memory only and within the function execution.

    // similarly below we have the same function with calldata
    function addPersonWithCalldata(uint256 _favNumber, string calldata _name) public {
        // we are using .push to add new Persons to the listOfPeople array
        listOfPeople.push(Person(_favNumber, _name));
    }

    /*
    Both memory and calldata mean temporary variables; by default most variables INSIDE functions are in memory.

    For strings you need to specify if in memory or calldata because they are an array of bytes and not a primitive type like uint.

    Difference between memory and calldata is that memory variables can be manipulated
    while calldata variables are immutable. See below:

    function addPersonWithCalldata(uint256 _favNumber, string calldata _name) public {
        _name = "Hello"; // this will not compile because calldata is immutable
                         // while it would compile if the _name variable was in memory
        listOfPeople.push(Person(_favNumber, _name));
    }
    */

    // Variables defined outside of functions are defaulted as storage variables
    // (same as Person[] public listOfPeople above)

    string public myName;          // empty string by default
    uint256 myFavNumber = 1;       // example init (default would be 0 if not set)

    function store(uint256 myFavNumber_) public {
        myFavNumber = myFavNumber_;
    }

    function retrieve() public view returns (uint256) {
        return myFavNumber;
    }

    /*
    Variables like myName and myFavNumber are stored on the blockchain (storage),
    they exist outside function calls and can be retrieved at any moment.
    */
}
