// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

/*
This contract:
1. Shows how to use arrays in Solidity
2. Demonstrates adding, reading, updating, deleting, and looping through arrays
3. Includes both simple arrays (uint256, address) and structured arrays (with structs)
*/

contract Arrays {

    // An array is a list of elements that can be accessed using an index (starting from 0)
    uint256[] public numbers; // A public array storing unsigned integers
    address[] public users;   // A public array storing addresses

    // Structs let us group different data types together
    struct Person {
        string name;
        uint256 favNumber;
    }

    // A public array of Person structs
    Person[] public listOfPersons;

    /* ADDING TO ARRAYS */

    // Add to simple arrays
    function addToSimpleArray(uint256 _number, address _user) public {
        numbers.push(_number); // Add the number passed as argument to the numbers array
        users.push(_user);     // Add the user address passed as argument to the users array
    }

    // Add to structured array (array of structs)
    function addToStructuredArray(string memory _name, uint256 _favNumber) public {
        listOfPersons.push(Person(_name, _favNumber)); // Add a new Person to the listOfPersons array
    }

    /* READING FROM ARRAYS */

    // Read from arrays using index (arrays are 0-based)
    function getNumberAtIndex(uint256 index) public view returns (uint256) {
        return numbers[index]; // Return the number at the given index
    }

    function getUserAtIndex(uint256 index) public view returns (address) {
        return users[index]; // Return the address at the given index
    }

    function getPersonAtIndex(uint256 index) public view returns (Person memory) {
    return listOfPersons[index]; // Return the person struct at the given index
    }

    // A variant would be returning Person individual values
    function getPersonFields(uint256 index) public view returns (string memory, uint256) {
        Person memory person = listOfPersons[index]; // Load struct into memory
        return (person.name, person.favNumber); // Return both fields separately
    }

    /* UPDATING ARRAYS */

    // Update an element in the numbers array
    function updateNumber(uint256 index, uint256 newValue) public {
        require(index < numbers.length, "Index out of range"); // Check that the index exists
        numbers[index] = newValue; // Replace the value at that index with newValue
    }

    // Update an element in the users array
        function updateUser(uint256 index, address newUser) public {
            require(index < users.length, "Index out of range"); // Check that the index exists
            users[index] = newUser; // Replace the address at that index with newUser
        }   

    // Update an element in the structured listOfPersons array
            function updatePerson(uint256 index, string memory newPerson, uint256 newFavNumber) public {
                require(index < listOfPersons.length, "Index out of range"); // Check that the index exists
                listOfPersons[index] = Person(newPerson, newFavNumber); // Replace the person at that index
            } 


    /* DELETING ENTRIES FROM ARRAYS */
       

    // Delete number from numbers array (resets it to default value but keeps array length same)
    function deleteNumber(uint256 index) public {
        require(index < numbers.length, "Index out of range");
        delete numbers[index]; // Sets the value at that index back to 0
    }

    // It is the same for other arrays, just replace numbers with users or listOfPersons


    /* REMOVING ENTRIES FROM ARRAYS & SHRINKING THE ARRAY */


    // Remove element properly using swap-and-pop method (saves gas)
    function removeNumber(uint256 index) public {
        require(index < numbers.length, "Index out of range");
        numbers[index] = numbers[numbers.length - 1]; // Move last element into the deleted spot
        numbers.pop(); // Remove the last element (reduces array length by 1)
    }

   // It is the same for other arrays, just replace numbers with users or listOfPersons
    
    /* RESETTING ARRAYS */

    function resetNumbers() public {
            delete numbers; // Deletes the whole array
        }

   // It is the same for other arrays, just replace numbers with users or listOfPersons


    /* LOOPING THROUGH ARRAYS */

    // Loop through the numbers array and return the total sum
    function sumNumbers() public view returns (uint256 sum) {
        for (uint256 i = 0; i < numbers.length; i++) { // Start from index 0, loop until last index
            sum += numbers[i]; // Add each element to the running total
        }
    }

    /* HANDLING EMPTY ARRAYS */

    // Handling empty arrays
    function isArrayEmpty() public view returns (bool) {
        return numbers.length == 0; // Returns true if the array is empty
    }

    // Function to check the length of arrays
    function getArrayLength() public view returns (uint256) {
        return numbers.length; // Returns the current length of the numbers array
    }
    
}
