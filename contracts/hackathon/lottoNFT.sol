// SPDX-License-Identifier: MIT


pragma solidity ^0.8.17;

// Interface for ERC-721 Non Fungible Token
interface IERC721 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address owner) external view returns (uint256);
    function ownerOf(uint256 tokenId) external view returns (address);
    function approve(address to, uint256 tokenId) external;
    function transferFrom(address from, address to, uint256 tokenId) external;
    function safeTransferFrom(address from, address to, uint256 tokenId) external;
    event Transfer(address indexed from, address indexed to, uint256 tokenId);
    event Approval(address indexed owner, address indexed approved, uint256 tokenId);
}

// Filecoin FEVM
contract LottoNFT is IERC721 {
    mapping(uint256 => address) private _ownerOf;
    mapping(address => uint256) private _balanceOf;
    mapping(address => mapping(uint256 => bool)) private _tokensOfOwner;
    uint256 private _totalSupply;
    
    constructor() public {
        _totalSupply = 0;
    }
    
    function totalSupply() external view returns (uint256) {
        return _totalSupply;
    }
    
    function balanceOf(address owner) external view returns (uint256) {
        return _balanceOf[owner];
    }
    
    function ownerOf(uint256 tokenId) external view returns (address) {
        return _ownerOf[tokenId];
    }
    
    function approve(address to, uint256 tokenId) external {
        require(ownerOf(tokenId) == msg.sender, "You are not the owner of this token");
        _tokensOfOwner[msg.sender][tokenId] = true;
        emit Approval(msg.sender, to, tokenId);
    }
    
    function transferFrom(address from, address to, uint256 tokenId) external {
        require(_tokensOfOwner[from][tokenId], "Token not approved");
        _tokensOfOwner[from][tokenId] = false;
        _tokensOfOwner[to][tokenId] = true;
        _ownerOf[tokenId] = to;
        emit Transfer(from, to, tokenId);
    }
    
    function safeTransferFrom(address from, address to, uint256 tokenId) external {
        // Confirm that the recipient is a valid ERC-721 receiver
        require(to.call(bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))), "Recipient is not a valid ERC-721 receiver");
        
        // Transfer the token
        transferFrom(from, to, tokenId);
    }
    
    function mintToken(address to) public returns (uint256) {
        _totalSupply++;
        uint256 newTokenId = _totalSupply;
        _ownerOf[newTokenId] = to;
        _balanceOf[to]++;
        _tokensOfOwner[to][newTokenId] = true;
        emit Transfer(address(0), to, newTokenId);
        return newTokenId;
    }
}