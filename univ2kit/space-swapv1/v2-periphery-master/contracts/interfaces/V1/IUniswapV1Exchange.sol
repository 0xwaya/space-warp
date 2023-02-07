// SPDX-License-Identifier: MIT
// Code generated by the Uniswap V2 Kit
// github.com/Uniswap/uniswap-v2-kit
// modifications made by SpaceSwap @0xwaya

pragma solidity >=0.5.0;

interface IUniswapV1Exchange {
    function balanceOf(address owner) external view returns (uint);
    function transferFrom(address from, address to, uint value) external returns (bool);
    function removeLiquidity(uint, uint, uint, uint) external returns (uint, uint);
    function tokenToEthSwapInput(uint, uint, uint) external returns (uint);
    function ethToTokenSwapInput(uint, uint) external payable returns (uint);
}