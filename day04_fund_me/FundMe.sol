// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

/*
This contract:
1. Sets a minimum funding value (in USD with Chainlink later)
2. Lets users deposit funds — fund()
3. Lets the contract owner withdraw all funds — withdraw()
*/

contract FundMe {


    // Constant = cannot be changed, cheaper gas usage. Assigned outside other functions.
    uint256 public constant MINIMUM_FUNDING = 1e18; // 1 ETH in Wei
    
    // Immutable = can only be assigned once (in constructor)
    address public immutable i_owner;

    // The constructor is a special function with no function keyword. It is executed only once, when the contract is deployed
    constructor () {
        i_owner = msg.sender; // We set the contract owner i_owner = msg.sender of the tx that deployed the contract (deployer)
    }

    // Modifiers let us reuse conditions in multiple functions
    modifier onlyOwner () {
        require(i_owner == msg.sender, "Sender is not owner");
        _; // This is a special underscore that means "execute the rest of the function"
    }
    

    address[] public funders; // array of addresses (everyone who funded)

    mapping(address funder => uint256 amountFunded) public addressToAmountFunded; // address → amount funded in Wei


    // The fund() function:
    // - is payable (accepts ETH)
    // - anyone can call it (public)
    // - must send at least MINIMUM_FUNDING (1 ETH)
    function fund() public payable {
            /*
            msg.value is a globally available variable that stores
            the amount of wei sent with the transaction.

            require() checks a condition; if it's not met, it REVERTS the transaction.
            Revert = undo all state changes and refund unused gas.

            Example:
            If there was a line like myValue = myValue + 1 before the require(),
            and the require fails, that change would be undone.

            Here, we enforce that the user must send at least 1 ETH.
            If not, the transaction fails with the provided error message.
            */

            require(msg.value > MINIMUM_FUNDING, "Minimum contribution is 1 ETH!"); // 1e18 wei = 1 ETH
            funders.push(msg.sender); // We add the address of funder to the funders array
            addressToAmountFunded[msg.sender] = msg.value; // We map funders's adresses to funders' amount of ETH contributed

        }

    // The withdraw() function:
    // Only the owner can call it.
    // Steps:
    // 1. Reset each funder’s mapping (set amount to 0)
    // 2. Reset the funders array
    // 3. Transfer all ETH in the contract to msg.sender if msg.sender = i_owner
    function withdraw () public onlyOwner {

        // require (msg.sender == owner, "Only the owner can withdraw!"); // we check if the caller is the owner but using modifier onlyOwner is better!

        // we use a for loop to reset the mapping for every funder
        // [1, 2, 3, 4] elements → indexes [0, 1, 2, 3]
        // structure: starting index; condition; increment
        for (uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++ ){   
            address funder = funders[funderIndex]; // we start with index 0, and we use it to get the funder at index 0 in the funders array
            addressToAmountFunded[funder] = 0; // we take the address we and we use it to reset the mapping for that address
            // me make this loop (funderIndex++) until we process all funders - funderIndex < funders.length

            // once all mappings are cleared, reset the funders array
            // we assign a new empty array to 'funders'
            funders = new address [](0); 

            // final step: send the entire contract balance to the owner
            // there are 3 ways to do this — only use one at a time:

            // transfer - 2300 gas, if fail it throws error
            payable(msg.sender).transfer(address(this).balance); // address(this).balance is the balance of the contract, payable is used to typecast address as payable address
            
            // send - 2300 gas, if fail returns a boolean
            bool sendSuccess = payable(msg.sender).send(address(this).balance); // we can use a boolean to check if the transfer was successful
            require(sendSuccess, "Send failed!"); // if it fails we throw an error - NECESSARY to rever if it fails

            // call - all gas, if fail returns a boolean
            // calls can contain data to call other functions but here we are using just to send ETH using value so we see ("")
            //(bool callSuccess, bytes dataReturned) but since we arent calling a function we can use (bool callSuccess, )
            (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}(""); // we can use a boolean to check if the transfer was successful
            require(callSuccess, "Call failed!"); // if it fails we throw an error
        } 
        }

    /*
    Gas optimization tip:
    Instead of using require("error"), you can define custom errors outside the contract:
    error SendFailed();
    ...
    if (!sendSuccess) revert SendFailed();
    */

    /*
    What if someone sends ETH directly to this contract
    instead of calling fund()?

    Solidity provides 2 special functions for that:
    1. receive() → runs when ETH is sent with no data
    2. fallback() → runs when ETH (or data) is sent but no function matches

    In both cases below, we just call fund() to keep logic consistent.

    More details in Fallback&Receive.sol!
    */
        
    receive() external payable {
        fund(); // called when msg.data is empty
    }

    fallback() external payable {
        fund(); // called when msg.data is not empty or function doesn't exist
    }


    }