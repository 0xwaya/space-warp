// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract lottoCoin is IERC20, Ownable {

    uint256 private constant MAX_UINT256 = 2**256 - 1;

    mapping(address => uint256) balances;
    mapping(address => mapping(address => uint256)) allowed;

    string public name;
    uint8 public decimals;
    string public symbol;
    uint256 public totalSupply;

    constructor() {
        balances[msg.sender] = 10000;
        totalSupply = 10000;
        name = "LottoCoin";
        decimals = 0;
        symbol = "LC";
    }

    function transfer(address _to, uint256 _value) public override returns (bool success) {
        require(balances[msg.sender] >= _value);

        balances[msg.sender] -= _value;
        balances[_to] += _value;

        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) public override returns (bool success) {
        uint256 allowance_ = allowed[_from][msg.sender];
        require(balances[_from] >= _value && allowance_ >= _value);

        balances[_to] += _value;
        balances[_from] -= _value;
        if (allowance_ >= _value) {
            allowed[_from][msg.sender] -= _value;
        }

        emit Transfer(_from, _to, _value);
        return true;
    }

    function increaseTotalSupply() external onlyOwner returns (bool success) {
        totalSupply += 1000;
        balances[owner()] += 1000;
        
        return true;
    }

    function balanceOf(address _owner) public view override returns (uint256 balance) {
        return balances[_owner];
    }

    function approve(address _spender, uint256 _value) public override returns (bool success) {
        allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    function allowance(address _owner, address _spender) public view override returns (uint256 remaining) {
        return allowed[_owner][_spender];
    }

}