// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

/*
Day 4 – Contract Factory

A factory contract can create and keep track of other contracts.
Here we build a simple example that deploys many SimpleStorage contracts
and lets us interact with each one.

Smart contracts are composable and can interact with each other permissionlessly.

We can import other contracts as follows:

*/

import "./SimpleStorage.sol"; // this is like copy pasting SimpleStorage in here. Be carefull of solidity versions across imports.

// However it's better to import as follows, because inside eg. SimpleStorage we could have multiple contracts and we want to import only some

import {SimpleStorage, SimpleStorage2} from "./SimpleStorage.sol";

contract StorageFactory {

    /* We declare a variable - type visibility name,
     SimpleStorage is the contract type we can access through the import above
     public is the visibility
     simpleStorage is the variable name
    */

    SimpleStorage public simpleStorage; // declaring a variable of contract type SimpleStorage

    // This variable will store the address of a deployed SimpleStorage contract.

    function createStorageContract () public {
        simpleStorage = new SimpleStorage (); // the keyword "new" is used to create contract instances. 
        // We assign the newly created contract SimpleStorage to the variable simpleStorage we created above.
    }


    // Below, instead, we declare a array of SimpleStorage contracts called simpleStorageArray with public visibility
    SimpleStorage [] public simpleStorageArray;

    function createStorageInArray () public {
        simpleStorageArray.push(new SimpleStorage()); 
        //Similarly to function createStorageContract, we create a new SimpleStorage contract instance.
        //We then add the new SimpleStorage contract to simpleStorageArray
    }


    // Call the store() function on one of the deployed SimpleStorage contracts
function sfStore(uint256 _simpleStorageIndex, uint256 _newSimpleStorageNumber) public {
    /*
    To interact with another contract we need two things:
    1. Its address  → where it lives on the blockchain
    2. Its ABI      → what functions it has and how to call them

    In this case, we already have both:
    - The address is stored inside simpleStorageArray[_simpleStorageIndex]
    - The ABI comes from the import of SimpleStorage at the top
    */

    // Get the SimpleStorage contract we want to work with
    SimpleStorage mySimpleStorage = simpleStorageArray[_simpleStorageIndex];

    // Call the store() function from that specific SimpleStorage contract
    mySimpleStorage.store(_newSimpleStorageNumber);
}


    

    function sfRetrieve(uint256 _simpleStorageIndex) public view returns (uint256) { 
    // Get the SimpleStorage contract from the array
    SimpleStorage mySimpleStorage = simpleStorageArray[_simpleStorageIndex];
    // Call the `retrieve()` function from SimpleStorage to get the stored number
    return mySimpleStorage.retrieve();

    // a more condensed way would be  
    // return simpleStorageArray[_simpleStorageIndex].retrieve();
}

    }