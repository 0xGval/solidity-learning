// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18; // Solidity version pinned to 0.8.18 or greater

contract SimpleStorage {

    uint256 number;

    function store(uint256 myFavNumber_) public {
        number = myFavNumber_;
    }

    function retrieve() public view returns (uint256) {
        return number;
    }
    
}


contract SimpleStorage2 {}
contract SimpleStorage3 {}