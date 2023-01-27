// SPDX-License-Identifier: MIT

/**
 * @title SpaceCoin
 * @dev SpaceCoin is a token used in the Space Warp hackathon
 */

pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract SpaceCoin is ERC20{ 
    address public owner;
    mapping (address => uint256) public balanceOf;
    mapping (address => mapping (address => uint256)) public allowance;
 
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Minted(address indexed _from, address indexed _to, uint256 _value);

        constructor() public {
        owner = msg.sender;
        name = "SpaceCoin";
        symbol = "SPACE";
        decimals = 18;
        totalSupply = 100000 * (10 ** uint256(decimals));
    }
        modifier transfer(address _to, uint256 _value) {
        require(balanceOf[msg.sender] >= _value);
        _;
    }
    function mint(address _to, uint256 _value) public {
        require(_value > 0, "Mint amount must be greater than 0");
        balances[_to] += _value;
        totalSupply += _value;
        emit Transfer(address(0), _to, _value);
        emit Minted(msg.sender, _to, _value);
    }
  
      /** * @dev Function to transfer tokens from one address to another
          * @param _to The address to transfer tokens to
          * @param _value The amount of tokens to transfer */

    function transfer(address _to, uint256 _value) public returns (bool) {
        require(balanceOf[msg.sender] >= _value, "Insufficient balance");
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }


    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        require(balanceOf[_from] >= _value);
        require(allowance[_from][msg.sender] >= _value);
        balanceOf[_from] = balanceOf[_from].sub(_value);
        balanceOf[_to] = balanceOf[_to].add(_value);
        allowance[_from][msg.sender] = allowance[_from][msg.sender].sub(_value);
        emit Transfer(_from, _to, _value);
        return true;
    }

    function approve(address _spender, uint256 _value) public returns (bool success) {
        allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    function totalSupply() public view returns (uint256) {
        return totalSupply;
    }

    function allowance(address _owner, address _spender) public view returns (uint256 remaining) {
        return allowance[_owner][_spender];
    }

}