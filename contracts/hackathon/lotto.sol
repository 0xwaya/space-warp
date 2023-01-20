// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@zondax/filecoin-solidity/contracts/Filecoin.sol";

contract Lotto {
    address public owner;
    uint256 public pot;
    mapping (address => uint256) public players;
    uint256 public deadline;
    uint256 public winner;
    bool public gameOver;
    Filecoin public filecoin;

    constructor() public {
        owner = msg.sender;
        filecoin = Filecoin(msg.sender);
    }

    function enter() public payable {
        require(msg.value > 0, "Must enter with a positive amount");
        require(now < deadline, "Deadline has passed");
        players[msg.sender] += msg.value;
        pot += msg.value;
    }

    function setDeadline(uint256 _deadline) public {
        require(msg.sender == owner, "Only the owner can set the deadline");
        deadline = _deadline;
    }

    function pickWinner() public {
        require(now > deadline, "Deadline has not passed");
        require(!gameOver, "Game is already over");
        uint256 lucky = uint256(keccak256(abi.encodePacked(block.difficulty, block.timestamp, pot))) % pot;
        uint256 sum = 0;
        for (address player in players) {
            sum += players[player];
            if (sum > lucky) {
                winner = player;
                break;
            }
        }
        gameOver = true;
    }

    function claim() public {
        require(msg.sender == winner, "You are not the winner");
        require(gameOver, "Game is not over yet");
        filecoin.transfer(msg.sender, pot);
        pot = 0;
    }
}