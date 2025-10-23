# Create a Markdown requirements file for the TaskManagementSystem project

requirements_content = """
# 🧩 Task Management System – Project Requirements

## 📘 Overview
This smart contract is a **Task Management System** built in Solidity that allows users to create, manage, and track tasks directly on the blockchain.  
The contract demonstrates the use of **arrays, structs, modifiers, loops, and access control** while providing CRUD functionality (Create, Read, Update, Delete).

---

## 🧠 Objectives
- Reinforce understanding of **arrays and structs** in Solidity.
- Practice **CRUD operations** with structured data.
- Implement **looping** and **data manipulation** on arrays.
- Apply **access control** via the `onlyOwner` modifier.

---

## ⚙️ Functional Requirements

### 👤 Ownership & Access
- The deployer of the contract becomes the **owner** (`i_owner`).
- Functions that modify state can be restricted using the **`onlyOwner`** modifier (currently applied for demonstration).

### 🧱 Core Features

#### 1. **Create Task**
- Function: `createTask(string taskName, string taskDescription, bool _isCompleted)`  
- Adds a new task to the `listOfTasks` array.  
- Requires both name and description to be non-empty.

#### 2. **Update Task**
- Function: `updateTask(uint256 index, string taskName, string taskDescription, bool _isCompleted)`  
- Allows editing of a task by its index.  
- Validates the index and ensures that inputs are non-empty.

#### 3. **Remove Task**
- Function: `removeTask(uint256 index)`  
- Deletes a task using the **swap-and-pop** method (gas-efficient).  
- Prevents out-of-range access with index checks.

#### 4. **Mark Task as Completed / Uncompleted**
- Functions:
  - `markCompleted(uint256 index)`
  - `markUncompleted(uint256 index)`  
- Toggles a task’s completion status based on its index.

#### 5. **View Tasks**
- Function: `getTaskByIndex(uint256 index)` → Returns a single task.  
- Function: `getAllTasks()` → Returns all stored tasks.

#### 6. **Count Tasks**
- Function: `getTotalTasks()` → Returns total number of tasks.

#### 7. **Check if Task List is Empty**
- Function: `checkEmptyTasks()` → Returns `true` if there are no tasks.

#### 8. **Remove Completed Tasks**
- Function: `removeCompletedTasks()`  
- Iterates through the task list and removes tasks marked as completed.

---

## 🧩 Data Structures

### Struct
```solidity
struct Task {
    string name;
    string description;
    bool isCompleted;
}
