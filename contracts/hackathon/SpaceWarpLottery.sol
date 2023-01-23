// SPDX-License-Identifier: MIT
/** created for experimental dev in Filecoin FVM  */

pragma solidity ^0.8.17;
import "@chainlink/contracts/src/v0.8/ChainlinkClient.sol";

contract SpaceWarpLottery {
    ChainlinkClient public chainlinkClient;

    uint256 public pot;
    address public winner;
    uint256 private ticketCount;
    mapping(address => uint256) private tickets;

    constructor (ChainlinkClient _chainlinkClient) public {
        chainlinkClient = _chainlinkClient;
    }

    // Generate random numbers using Chainlink VRF
    function drawNumbers() public {
        // Generate random numbers using the Chainlink VRF
        (uint256 _vrfOutcome, uint256 _proof) = chainlinkClient.requestRandomness(0, 0);
        // Set the winner
        winner = _vrfOutcome;
    }

    // Buy a ticket
    function buyTicket(address _buyer) public payable {
        // Check if the ticket is valid
        require(_msg.value == 1 ether);
        // Update the ticket count
        ticketCount++;
        // Add the ticket to the list
        tickets[_buyer] = ticketCount;
        // Add the ticket price to the pot
        pot += _msg.value;
    }

    // Refund tickets if the event is cancelled
    function refundTicket(address _ticketHolder) public {
        // Check if the ticket is valid
        require(tickets[_ticketHolder] != 0);
        // Transfer the ticket price to the holder
        _ticketHolder.transfer(1 ether);
        // Update the pot
        pot -= 1 ether;
    }
    
    // Check if the ticket is a winning ticket or not
    function isWinningTicket(address _ticketHolder) public view returns (bool) {
        // Check if the ticket is valid
        require(tickets[_ticketHolder] != 0);
        // Return true if the ticket is a winner
        return (_ticketHolder == winner);
    }

    // Pay out the corresponding prizes to the winners
    function payPrizes() public {
        // Pay out the pot to the winner
        winner.transfer(pot);
        // Reset the pot
        pot = 0;
    }

    // Check the current balance of tickets sold
    function getTicketCount() public view returns (uint256) {
        return ticketCount;
    }

    // Check the current pot amount
    function getPotAmount() public view returns (uint256) {
        return pot;
    }

    // Check the current winner's address
    function getWinnerAddress() public view returns (address) {
        return winner;
    }
}