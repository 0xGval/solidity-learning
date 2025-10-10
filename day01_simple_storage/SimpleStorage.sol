// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;  // Solidity version pinned to 0.8.18 or greater

// Contract definition for SimpleStorage 
contract SimpleStorage {

    // Solidity is a statically typed language = the type of each variable (state and local) needs to be specified.
    // Basic Types: boolean, uint (positive integer), int, address, bytes

    bool hasFavoriteNumber = true;                 // Boolean type
    uint favoriteNumber = 1234;                    // Unsigned integer (default 256 bits)
    uint256 favoriteNumber2 = 123456789;           // Unsigned integer with 256 bits
    int favoriteNumber3 = -123456789;              // Signed integer
    string favoriteNumberInText = "123456789";     // String type
    address favoriteAddress = 0xc18120B4B22C78eA55f8A7acBD7D7082d3C73A2B; // Address (20 bytes)
    bytes32 favoriteBytes = bytes32("abc");        // Bytes type, padded to 32 bytes

    // Variables have default values 
    uint256 number; // Default value is 0. We'll create a getter function below instead of making it public.

    // Visibility Specifiers:
    // public   - visible internally and externally (creates a getter)
    // private  - only visible in the current contract 
    // external - only visible externally (for functions only)
    // internal - visible internally and in derived contracts (default for state variables)

    // Function to modify state (costs gas)
    function store(uint256 _number) public {
        number = _number;
    } 

    // Read-only function (no gas if called externally)
    function retrieve() public view returns (uint256) {
        return number;
    }

    // "view" = reads state, doesn't modify
    // "pure" = doesn't even read state (math-only)
    // none   = modifies state (costs gas)

    uint256[] public listOfNumbers; // Dynamic array of unsigned integers

    // Struct = custom type definition
    struct Person {
        uint256 favNumber;
        string name;
    }

    // Example Person instances
    Person public Banny = Person({favNumber: 6, name: "Banny"});
    Person public Lukash = Person({favNumber: 7, name: "Lukash"});
    Person public Edos = Person({favNumber: 87, name: "Edos"});

    // Dynamic array of Person structs
    Person[] public listOfPeople;

    // Function to add entries to listOfPeople array
    function addPerson(uint256 _favNumber, string memory _name) public {
        listOfPeople.push(Person(_favNumber, _name));
    }
}
