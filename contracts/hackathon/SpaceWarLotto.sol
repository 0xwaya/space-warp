// SPDX-License-Identifier: MIT



pragma solidity ^0.8.17;

/**
 * Space War Lotto
 *
 * A simple lottery contract on the Filecoin FEVM
 * 
 * @author 0xwaya
 */
contract SpaceWarLotto {
    // Address of the contract creator
    address public creator;
    
    // Counter of total tickets purchased
    uint256 public ticketCount;
    
    // Pool of unclaimed prizes
    uint256 public prizePool;
    
    // Mapping of ticket numbers to addresses
    mapping (uint256 => address) public tickets;
    
    // Constructor
    constructor() public {
        creator = msg.sender;
        ticketCount = 0;
        prizePool = 0;
    }
    
    // Buy a ticket with a certain amount of FIL
    function buyTicket(uint256 _amount) public payable {
        // Check the amount is greater than 0
        require(_amount > 0, "Amount must be greater than 0");
        
        // Check the amount is not greater than the balance
        require(_amount <= msg.value, "Amount exceeds balance");
        
        // Increment the ticket count
        ticketCount++;
        
        // Add the ticket to the mapping
        tickets[ticketCount] = msg.sender;
        
        // Increase the prize pool
        prizePool += _amount;
    }
    
    // Draw a winner
    function drawWinner() public onlyCreator {
        // Check there are tickets in the pool
        require(ticketCount > 0, "No tickets in the pool.");
        
        // Generate a random number
        uint256 randomNumber = uint256(keccak256(abi.encodePacked(block.difficulty, block.timestamp, block.coinbase)));
        
        // Generate a winner address
        address winner = tickets[randomNumber % ticketCount + 1];
        
        // Pay out the winner
        winner.transfer(prizePool);
        
        // Reset the ticket count
        ticketCount = 0;
        
        // Reset the prize pool
        prizePool = 0;
    }
    
    // Ensure only the creator can draw a winner
    modifier onlyCreator() {
        require(msg.sender == creator, "Only the creator can draw a winner.");
        _;
    }
}