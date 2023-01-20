pragma solidity ^0.8.17;

import "https://github.com/Zondax/filecoin-solidity";

contract Lotto {
    using FEVM for FEVM.Context;

    address public owner;
    uint256 public pot;
    uint256 public ticketPrice;
    uint256 public maxTickets;
    uint256 public ticketsSold;
    uint256 public winningTicket;
    bool public lotteryOpen;

constructor() public {
    owner = msg.sender;
    ticketPrice = 0.001;
    maxTickets = 100;
    lotteryOpen = true;
}

function buyTicket() public payable {
    require(lotteryOpen, "Lottery is closed");
    require(msg.value == ticketPrice, "Incorrect ticket price");
    require(ticketsSold < maxTickets, "Lottery is full");

    ticketsSold++;
    pot += msg.value;
}

function closeLottery() public {
    require(msg.sender == owner, "Only owner can close lottery");
    require(ticketsSold > 0, "No tickets sold");

    lotteryOpen = false;
    winningTicket = uint256(keccak256(abi.encodePacked(block.timestamp, block.difficulty))) % ticketsSold;
}

function claimWinnings() public {
    require(!lotteryOpen, "Lottery is still open");
    require(msg.sender == owner, "Only owner can claim winnings");

    uint256 winnings = pot - (ticketsSold * ticketPrice);
    owner.transfer(winnings);
}

function withdraw() public {
    require(!lotteryOpen, "Lottery is still open");
    require(msg.sender == owner, "Only owner can withdraw");

    uint256 amount = pot - (ticketsSold * ticketPrice);
    owner.transfer(amount);
    }
  }
}

