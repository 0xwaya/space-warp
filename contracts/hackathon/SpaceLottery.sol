// SPDX-License-Identifier: MIT
/** created for experimental dev in Filecoin FVM  */

pragma solidity ^0.8.17;

import "@chainlink/contracts/src/v0.6/ChainlinkClient.sol";
import "@chainlink/contracts/src/v0.6/interfaces/ChainlinkRequestInterface.sol";
import "@chainlink/contracts/src/v0.6/interfaces/ChainlinkVRFInterface.sol";

contract SpaceLottery {
    mapping(address => uint) public balance;
    address public owner;

    // Lottery functionality
    address public lotteryManager;
    uint public lotteryFee;
    mapping(address => bool) public lotteryPlayers;
    address[] public lotteryEntries;
    uint public lotteryEndTime;
    address public lotteryWinner;

    // Chainlink VRF functionality
    ChainlinkClient public chainlinkClient;
    bytes32 public seed;
    bytes32 public requestId;

    constructor() public {
        owner = msg.sender;
        lotteryManager = msg.sender;
        chainlinkClient = new ChainlinkClient(msg.sender);
    }

    function mint(address recipient, uint amount) public {
        require(msg.sender == owner, "Only the owner can mint new coins.");
        require(amount > 0, "Cannot mint 0 or negative coins.");
        balance[recipient] += amount;
    }

    function send(address recipient, uint amount) public {
        require(balance[msg.sender] >= amount, "Sender has insufficient balance.");
        require(amount > 0, "Cannot send 0 or negative coins.");
        balance[msg.sender] -= amount;
        balance[recipient] += amount;
    }

    function balanceOf(address account) public view returns (uint) {
        return balance[account];
    }

    function enterLottery(uint _lotteryFee) public {
        require(balance[msg.sender] >= _lotteryFee, "Sender has insufficient balance.");
        require(lotteryEndTime == 0, "Lottery has already ended.");
        lotteryPlayers[msg.sender] = true;
        lotteryEntries.push(msg.sender);
        lotteryFee = _lotteryFee;
        balance[msg.sender] -= _lotteryFee;
    }

    function endLottery() public {
        require(msg.sender == lotteryManager, "Only the lottery manager can end the lottery.");
        require(lotteryEndTime == 0, "Lottery has already ended.");
        lotteryEndTime = now;
        seed = chainlinkClient.getRandomness(block.timestamp, msg.sender);
        requestId = chainlinkClient.getChainlinkCancellationId();
        require(chainlinkClient.oracles(requestId).length > 0, "Chainlink oracle not found");
        chainlinkClient.requestRandomness(requestId, seed, 10000000000000000);
    }

    function __callback(bytes32 _requestId, bytes32 _randomness) public {
        require(_requestId == requestId, "Invalid request ID");
        uint randomIndex = uint(keccak256(abi.en,));
    }
}