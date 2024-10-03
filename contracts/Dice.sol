// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.24;

contract Dice {
    address public owner;

    constructor() {
        owner=msg.sender;
    }

    function throwDice() public view returns (uint256, uint256) {
        require(msg.sender == owner, "Only owner can perform this action");
        require(msg.sender != address(0), "address 0 detected");
       
        uint256 randomHash = uint256(keccak256(abi.encodePacked(block.timestamp, block.prevrandao, msg.sender)));
        uint256 randomHash2 = uint256(keccak256(abi.encodePacked(block.timestamp*3, block.prevrandao, msg.sender)));

        uint8 diceResult1 = uint8((randomHash % 6) + 1);
        uint8 diceResult2 = uint8((randomHash2 % 6) + 1);

        return(diceResult1, diceResult2);
    }
}