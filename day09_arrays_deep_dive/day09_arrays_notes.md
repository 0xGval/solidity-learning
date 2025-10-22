# 🗓️ Day 9 – Arrays in Solidity
---

## 🧠 Concepts Learned

- **Arrays in Solidity:**
  - Arrays allow you to store multiple values in a single variable.
  - Arrays can be simple (like `uint256[]`) or structured (like `Person[]`).
  - Array elements can be accessed via their index (starting from `0`).
  
- **Types of Arrays:**
  - **Dynamic Arrays:** These can grow or shrink dynamically (`uint256[]`, `address[]`).
  - **Fixed-size Arrays:** Defined with a specific length (`uint256[5]`).
  - **Arrays of Structs:** Arrays that store custom data types, like `Person[]`.

- **Functions on Arrays:**
  - `push()`: Adds a new element to the end of the array.
  - `pop()`: Removes the last element from the array, reducing its size.
  - `length`: A property that returns the current size of the array.
  - **Accessing Elements:** Use an index to read an element from an array.

- **Updating Elements:**
  - You can replace an element at a specific index in an array using `array[index] = value`.

- **Deleting Elements:**
  - `delete` keyword can reset elements to their default values but leaves the array's length unchanged.
  - For reducing the array length, the **swap-and-pop** method is often used to optimize gas usage.

- **Empty Arrays:**
  - Check if an array is empty using the `length` property: `array.length == 0`.

- **Looping Through Arrays:**
  - You can iterate through arrays with a `for` loop.