// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "@zondax/filecoin-solidity/contracts/fvm/SafeMath.sol";

contract Lotto {
    using SafeMath for uint256;

    address public owner;
    uint256 public ticketPrice;
    uint256 public totalTickets;
    uint256 public totalPrize;
    uint256 public ticketsSold;
    uint256 public ticketsRemaining;
    uint256 public prizePerTicket;
    mapping (address => uint256) public tickets;
    mapping (uint256 => address) public winners;
    event TicketBought(address indexed buyer, uint256 ticketId);
    event WinnerDrawn(uint256 indexed ticketId, address winner);

    constructor(uint256 _ticketPrice, uint256 _totalTickets, uint256 _totalPrize) public {
        owner = msg.sender;
        ticketPrice = _ticketPrice;
        totalTickets = _totalTickets;
        totalPrize = _totalPrize;
        ticketsRemaining = totalTickets;
        prizePerTicket = totalPrize.div(totalTickets);
    }

    function buyTicket() public payable {
        require(msg.value == ticketPrice, "Incorrect ticket price");
        require(ticketsRemaining > 0, "No tickets remaining");
        uint256 ticketId = ticketsSold;
        tickets[msg.sender] = ticketId;
        ticketsSold = ticketsSold.add(1);
        ticketsRemaining = ticketsRemaining.sub(1);
        emit TicketBought(msg.sender, ticketId);
    }

    function drawWinner() public {
        require(msg.sender == owner, "Only owner can draw winner");
        uint256 ticketId = ticketsSold.sub(ticketsRemaining);
        address winner = tickets[ticketId];
        winners[ticketId] = winner;
        emit WinnerDrawn(ticketId, winner);
    }

    function claimPrize() public {
        uint256 ticketId = tickets[msg.sender];
        require(winners[ticketId] == msg.sender, "You are not the winner");
        msg.sender.transfer(prizePerTicket);
    }
}