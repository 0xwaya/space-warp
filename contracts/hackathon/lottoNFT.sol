// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "@zondax/filecoin-solidity/contracts/fvm/IERC721.sol";
import "@zondax/filecoin-solidity/contracts/fvm/IERC721Enumerable.sol";

contract LottoNFT is IERC721, IERC721Enumerable {
    string public name = "LottoNFT";
    string public symbol = "LOTTO";
    uint256 public totalSupply;
    mapping (uint256 => address) public tokenOwner;
    mapping (uint256 => uint256) public tokenIdToNumber;
    mapping (address => uint256) public balanceOf;
    mapping (uint256 => bool) public isWinner;
    uint256 public winningNumber;
    address public winner;
    uint256 public lastWinnerNumber;
    address public lastWinner;
    uint256 public lastDrawTime;
    uint256 public drawInterval;
    uint256 public ticketPrice;
    uint256 public totalTickets;
    uint256 public totalPrize;
    uint256 public totalFees;
    address public feeRecipient;
    address public owner;

    constructor(
        uint256 _winningNumber,
        uint256 _drawInterval,
        uint256 _ticketPrice,
        uint256 _totalPrize,
        uint256 _totalFees,
        address _feeRecipient,
        address _owner
    ) public {
        winningNumber = _winningNumber;
        drawInterval = _drawInterval;
        ticketPrice = _ticketPrice;
        totalPrize = _totalPrize;
        totalFees = _totalFees;
        feeRecipient = _feeRecipient;
        owner = _owner;
    }

    function mint(address _to, uint256 _tokenId, uint256 _number) public onlyOwner {
        _mint(_to, _tokenId);
        tokenIdToNumber[_tokenId] = _number;
        totalSupply++;
    }

    function draw() public onlyOwner {
        require(now >= lastDrawTime + drawInterval);
        lastDrawTime = now;
        lastWinnerNumber = winningNumber;
        lastWinner = winner;
        winner = tokenOwner[winningNumber];
        isWinner[winningNumber] = true;
        totalPrize = totalTickets * ticketPrice;
        totalFees = totalPrize * (totalFees / 100);
        feeRecipient.transfer(totalFees);
        winner.transfer(totalPrize - totalFees);
    }

    function buyTicket(uint256 _number) public payable {
        require(msg.value == ticketPrice);
        require(_number > 0 && _number <= totalSupply);
        require(tokenOwner[_number] == address(0));
        totalTickets++;
        tokenOwner[_number] = msg.sender;
        balanceOf[msg.sender]++;
        _mint(msg.sender, _number);
    }

    function getWinner() public view returns (address) {
        return winner;
    }

    function getLastWinner() public view returns (address) {
        return lastWinner;
    }

    function getLastWinnerNumber() public view returns (uint256) {
        return lastWinnerNumber;
    }

    function getTotalTickets() public view returns (uint256) {
        return totalTickets;
    }

    function getTotalPrize() public view returns (uint256) {
        return totalPrize;
    }

    function getTotalFees() public view returns (uint256) {
        return totalFees;
    }

    function getFeeRecipient() public view returns (address) {
        return feeRecipient;
    }

    function getOwner() public view returns (address) {
        return owner;
    }

    function getDrawInterval() public view returns (uint256) {
        return drawInterval;
    }

    function getTicketPrice() public view returns (uint256) {
        return ticketPrice;
    }

    function getLastDrawTime() public view returns (uint256) {
        return lastDrawTime;
    }

    function getNumberByTokenId(uint256 _tokenId) public view returns (uint256) {
        return tokenIdToNumber[_tokenId];
    }

    function getIsWinner(uint256 _number) public view returns (bool) {
        return isWinner[_number];
    }

    function getWinningNumber() public view returns (uint256) {
        return winningNumber;
    }

    function getTotalSupply() public view returns (uint256) {
        return totalSupply;
    }

    function getBalanceOf(address _owner) public view returns (uint256) {
        return balanceOf[_owner];
    }

    function getOwnerOf(uint256 _tokenId) public view returns (address) {
        return tokenOwner[_tokenId];
    }

    function safeTransferFrom(address _from, address _to, uint256 _tokenId) public {
        _safeTransferFrom(_from, _to, _tokenId);
    }

    function transferFrom(address _from, address _to, uint256 _tokenId) public {
        _transferFrom(_from, _to, _tokenId);
    }

    function approve(address _spender, uint256 _tokenId) public {
        _approve(_spender, _tokenId);
    }

    function setApprovalForAll(address _operator, bool _approved) public {
        _setApprovalForAll(_operator, _approved);
    }

    function isApprovedForAll(address _owner, address _operator) public view returns (bool) {
        return _isApprovedForAll(_owner, _operator);
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }
}