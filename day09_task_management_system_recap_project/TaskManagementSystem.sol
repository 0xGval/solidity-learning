// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract TaskManagementSystem {

    address public immutable i_owner; // The owner of the contract is immutable and is set at deployment

    constructor () {
        i_owner = msg.sender; // The address of the contract deployer is set as the owner
    }

    modifier onlyOwner () { // Modifier to restrict access to only the contract owner
        require(msg.sender == i_owner, "Only owner can call this function"); // Only allow the owner to call this function
        _; 
    }

    // Struct to represent a task
    struct Task {
        string name;        // Name of the task
        string description; // Description of the task
        bool isCompleted;   // Status of the task, whether it's completed or not
    }

    Task[] public listOfTasks; // A public array of tasks

    /* CREATE TASK */
    // Function to create a new task
    function createTask (string memory taskName, string memory taskDescription, bool _isCompleted) public {
        // Ensure that the task name is not empty
        require(bytes(taskName).length > 0, "Task name cannot be empty");
        // Ensure that the task description is not empty
        require(bytes(taskDescription).length > 0, "Task description cannot be empty");
        listOfTasks.push(Task(taskName, taskDescription, _isCompleted)); // Add the new task to the list
    }

    /* UPDATE TASK */
    // Function to update an existing task by index
    function updateTask (uint256 index, string memory taskName, string memory taskDescription, bool _isCompleted) public {
        require(index < listOfTasks.length, "Index out of range"); // Ensure that the index exists
        // Ensure that the task name is not empty
        require(bytes(taskName).length > 0, "Task name cannot be empty");
        // Ensure that the task description is not empty
        require(bytes(taskDescription).length > 0, "Task description cannot be empty");
        listOfTasks[index] = Task(taskName, taskDescription, _isCompleted); // Update the task at the specified index
    }

    /* REMOVE TASK */
    // Function to remove a task by index
    function removeTask (uint256 index) public {
        require(index < listOfTasks.length, "Index out of range"); // Ensure that the index exists
        listOfTasks[index] = listOfTasks[listOfTasks.length - 1]; // Move the last task to the deleted spot
        listOfTasks.pop(); // Remove the last element (decreases array length by 1)
    }

    /* MARK TASK AS COMPLETED */
    // Function to mark a task as completed by index
    function markCompleted (uint256 index) public {
        require(index < listOfTasks.length, "Index out of range"); // Ensure that the index exists
        listOfTasks[index].isCompleted = true; // Set the task's completion status to true
    }

    /* MARK TASK AS UNCOMPLETED */
    // Function to mark a task as uncompleted by index
    function markUncompleted (uint256 index) public {
        require(index < listOfTasks.length, "Index out of range"); // Ensure that the index exists
        listOfTasks[index].isCompleted = false; // Set the task's completion status to false
    }

    /* GET TASK BY INDEX */
    // Function to get a task at a specific index
    function getTaskByIndex (uint256 index) public view returns (Task memory){
        require(index < listOfTasks.length, "Index out of range"); // Ensure that the index exists
        return listOfTasks[index]; // Return the task at the specified index
    }

    /* GET TOTAL TASK COUNT */
    // Function to get the total number of tasks
    function getTotalTasks () public view returns (uint256) {
        return listOfTasks.length; // Return the length of the listOfTasks array (number of tasks)
    }

    /* REMOVE COMPLETED TASKS */
    // Function to remove all completed tasks
    function removeCompletedTasks() public {
        uint256 tasksToRemove;

        // Loop through all tasks and count the completed ones
        for(uint256 index = 0; index < listOfTasks.length; index++) {
            if (listOfTasks[index].isCompleted) { // If the task at the index is marked as completed
                tasksToRemove++; // Increase the counter for tasks to remove
            }
        }

        // Remove completed tasks after counting
        for (uint256 i = 0; i < tasksToRemove; i++) {
            // Perform swap-and-pop operation: Move the last task to the deleted spot
            listOfTasks[i] = listOfTasks[listOfTasks.length - 1];
            listOfTasks.pop(); // Remove the last task (reduces array length by 1)
        }
    }

    /* CHECK IF TASKS ARRAY IS EMPTY */
    // Function to check if the task list is empty
    function checkEmptyTasks () public view returns(bool){
        return listOfTasks.length == 0; // Return true if there are no tasks in the list
    }

    /* GET ALL TASKS */
    // Function to get all tasks in the list
    function getAllTasks() public view returns (Task[] memory) {
        return listOfTasks; // Return the entire list of tasks
    }

}
