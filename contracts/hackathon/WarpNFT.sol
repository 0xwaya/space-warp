// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "erc721a/contracts/ERC721A.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

interface IWarp {
    function sendPrize() external returns (bytes32 requestId);
}

contract WarpNFT is ERC721A, Ownable {

    uint8 constant mintAmount = 1;
    uint256 cost = 10;
    string baseURI = "https://ipfs./ipfs/....oDdh55bQAbYVyc16TF1zX658/";
    IERC20 coin;
    IWarp warp;

    constructor() ERC721A("Warp NFT", "WARP") {}

    function mint() external {
        require(coin.allowance(msg.sender, address(this)) >= cost, "Sender has not given contract enough allowance");
        require(coin.balanceOf(msg.sender) >= cost, "Sender does not have enough LottoCoin balance");
        coin.transferFrom(msg.sender, address(lotto), cost);
        _mint(msg.sender, mintAmount);
        if(totalSupply() % 5 == 0) {
            lotto.sendPrize();
        }
    }

    function tokenURI(uint256 _tokenId) public view override returns (string memory) {
        require(_exists(_tokenId), "Token does not exist.");
        return string(abi.encodePacked(baseURI, Strings.toString(_tokenId), ''));   
    }

    function setCoinAddr(address _coinAddr) external onlyOwner {
        coin = IERC20(_coinAddr);
    }

    function setWarpAddr(address _warpAddr) external onlyOwner {
        warp = IWarp(_lottoAddr);
    }

}