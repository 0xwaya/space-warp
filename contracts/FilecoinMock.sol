// SPDX-License-Identifier: MIT
// created for experimental use by dev: 0xwaya in Filecoin FVM 
// token will need interface from ISpaceSwapV1ERC20.sol and domain separator before mainnet
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract FilecoinMock is ERC20, ERC20Burnable, Pausable, Ownable {
    constructor() ERC20("FileToken", "FILE") {
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function _beforeTokenTransfer(address from, address to, uint256 amount) internal whenNotPaused override {
        super._beforeTokenTransfer(from, to, amount);
    }
}