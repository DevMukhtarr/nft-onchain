// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

contract Bank {
    
    mapping ( address => uint256 ) private balances;

    event Deposit(address indexed account, uint256 amount);
    event Withdrawal(address indexed account, uint256 amount);
    event Transfer(address indexed from, address indexed to, uint256 amount);

    modifier accountExists() {
        require(balances[msg.sender] > 0, "Account does not exist.");
        _;
    }

    modifier hasBalance(uint256 amount) {
        require(balances[msg.sender] >= amount, "Insufficient balance.");
        _;
    }

    function createAccount () external payable{
        require(msg.value > 0, "Initial deposit must be greater than zero.");
        require(balances[msg.sender] == 0, "Account already exists.");

        balances[msg.sender] = msg.value;
    }

    function deposit() external payable accountExists{
        require(msg.value > 0, "Amount must be greater than 0");

        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    function transfer (address to, uint256 amount) external payable accountExists hasBalance(amount){
        require(to == msg.sender, "Can't transfer to self");
        
        if(balances[to] == 0 ){
            balances[to] = amount;
        }else{
            balances[to] += amount;
        }

        balances[msg.sender] -= amount;
        emit Transfer(msg.sender, to, amount);
    }

    function withdraw (uint amount) external payable accountExists hasBalance(amount){
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
        emit Withdrawal(msg.sender, amount);
    }

    function checkBalance() public view accountExists returns (uint256){
        return balances[msg.sender];
    }
}