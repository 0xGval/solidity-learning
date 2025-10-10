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
    uint256 number; // Default value is 0. We could set it we set public (uint256 public number) to be read from outside the contract, but we will create a getter (read only) function for this variable below

    // Visibility Specifiers:
    // public   - visible internally and externally (creates a getter)
    // private  - only visible in the current contract 
    // external - only visible externally (for functions only)
    // internal - visible internally and in derived contracts (default for state variables)

    // Function to modify state (costs gas)
    function store(uint256 _number) public {   //We are declaring the function store with a uint256 type argument _number. The public specifier makes this function callable from outside the contract.
        number = _number;  // Assigning the value of _number to number variable above (originally defaulted to 0)
    } 

    // Read-only function (no gas if called externally)
    function retrieve() public view returns (uint256) {  // The view keyword tells the compiler that this function does not modify the state of the contract. Its the same as adding public to the variable declarataion.
        return number;
    }

    // "view" = reads state, doesn't modify
    // "pure" = doesn't even read state (math-only)
    // none   = modifies state (costs gas)

    uint256[] public listOfNumbers; // Dynamic array of unsigned integers. For instance [5, 77, 88] and we refer based on position 0. 1. 2.


    // Solidity lets you create custom types using structs
    struct Person {                  // Custom type definition
        uint256 favNumber;
        string name;
    }
    
    // Example Person instances
    Person public Jhon = Person({favNumber: 6, name: "Jhon"});
    Person public Luke = Person({favNumber: 7, name: "Luke"});
    Person public Ed   = Person({favNumber: 87, name: "Ed"});
    
    // Dynamic arrays can grow or shrink at runtime.
    // For a fixed-size array, use: Person[5] public listOfPeople;
    Person[] public listOfPeople;    // Empty array of Person structs
    
    // Function to add new entries to the listOfPeople array
    function addPerson(uint256 _favNumber, string memory _name) public {
        // Anyone can call this function (public)
        // It takes a uint and a string, creates a new Person struct, 
        // and pushes it to the listOfPeople array.
        listOfPeople.push(Person(_favNumber, _name));
        // Because listOfPeople is public, Solidity auto-generates a getter 
        // that lets you fetch a Person by index.
}



// To test in Remix:
// 1. Deploy the contract.
// 2. Call store(42).
// 3. Call retrieve() → should return 42.
// 4. Call addPerson(10, "Alice").
// 5. Call listOfPeople(0) → returns (10, "Alice").

}
