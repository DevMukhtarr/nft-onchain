// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.24;

contract Hello {
    address public owner;
    constructor() {
        owner = msg.sender; 
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "only owner can perform this action");
        _;
    }

    function helloToOwner() public view onlyOwner returns (bytes32) {
        return ("Hello owner");
    }
}