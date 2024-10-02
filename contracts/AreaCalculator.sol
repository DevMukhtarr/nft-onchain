// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

contract AreaCalculator {

    function AreaOfTriangle(uint256 base, uint256 height) public pure returns (uint256) {
        uint256 area = (base * height) / 2;

        return area;
    }

    function AreaOfRectangle(uint256 length, uint256 breadth) public pure returns (uint256) {
        uint256 area = length * breadth;

        return area;
    }

    function AreaOfSquare(uint256 length) public pure returns (uint256) {
        uint256 area = length * 2;

        return area;
    }

}