// SPDX-License-Identifier: MIT 
// Author: Uniswap Team
// Modified by: SpaceSwap Team

pragma solidity >=0.5.0;

interface IUniswapV2Callee {
    function uniswapV2Call(address sender, uint amount0, uint amount1, bytes calldata data) external;
}
