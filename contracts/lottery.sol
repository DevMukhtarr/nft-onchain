// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleLottery {
    address public owner;
    uint256 public ticketPrice;
    uint256 public prizePool;
    address[] public participants;
    bool public lotteryOpen;
    address public lastWinner;
    
    event TicketPurchased(address buyer);
    event WinnerSelected(address winner, uint256 prize);
    event LotteryStarted(uint256 ticketPrice);
    event LotteryEnded();
    
    constructor(uint256 _ticketPrice) {
        owner = msg.sender;
        ticketPrice = _ticketPrice;
        lotteryOpen = true;
    }
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }
    
    modifier isOpen() {
        require(lotteryOpen, "Lottery is closed");
        _;
    }
    
    function buyTicket() external payable isOpen {
        require(msg.value == ticketPrice, "Incorrect ticket price");
        participants.push(msg.sender);
        prizePool += msg.value;
        emit TicketPurchased(msg.sender);
    }
    
    function generateRandomNumber() internal view returns (uint256) {
        return uint256(keccak256(abi.encodePacked(
            block.timestamp,
            block.prevrandao,
            participants.length
        ))) % participants.length;
    }
    
    function selectWinner() external onlyOwner isOpen {
        require(participants.length > 0, "No participants");
        
        uint256 randomIndex = generateRandomNumber();
        address winner = participants[randomIndex];
        lastWinner = winner;
        
        uint256 prize = prizePool;
        prizePool = 0;
        lotteryOpen = false;
        
        emit WinnerSelected(winner, prize);
        emit LotteryEnded();
        
        (bool success, ) = winner.call{value: prize}("");
        require(success, "Transfer failed");
    }
    
    function startNewLottery(uint256 _ticketPrice) external onlyOwner {
        require(!lotteryOpen, "Lottery still running");
        require(prizePool == 0, "Prize pool not empty");
        
        ticketPrice = _ticketPrice;
        delete participants;
        lotteryOpen = true;
        
        emit LotteryStarted(_ticketPrice);
    }
    
    function getParticipantCount() external view returns (uint256) {
        return participants.length;
    }
    
    function isParticipant(address user) external view returns (bool) {
        for(uint i = 0; i < participants.length; i++) {
            if(participants[i] == user) return true;
        }
        return false;
    }
}