// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol"
import "contracts/lib/openzeppelin-contracts/contracts/utils/math/SafeMath.sol"
contract SpaceCoin is ERC20 {
    string public constant name = "Space Coin";
    string public constant symbol = "SPACE";
    uint8 public constant decimals = 18;
    uint256 public totalSupply = 10000;

    mapping(address => uint256) public balanceOf;     
    mapping (address => mapping (address => uint256)) public allowance;
 
        event Transfer(address indexed from, address indexed to, uint256 value);

    constructor() public {
        name = "LottoCoin";
        symbol = "LOT";
        decimals = 18;
        totalSupply = 100000000 * (10 ** uint256(decimals));
        balanceOf[msg.sender] = totalSupply;

        constructor(uint256 _supply) public {
        setTotalSupply(_supply);
        balanceOf[msg.sender] = _supply;
        }
    }
        modifier transfer(address _to, uint256 _value) {
        require(balanceOf[msg.sender] >= _value);
        _;
    }

    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(balanceOf[msg.sender] >= _value);
        balanceOf[msg.sender] = balanceOf[msg.sender].sub(_value);
        balanceOf[_to] = balanceOf[_to].add(_value);
        emit Transfer(msg.sender, _to, _value);
        return true;
    }
        function setTotalSupply(uint256 _supply) public {
        totalSupply = _supply;
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

    function balanceOf(address _owner) public view returns (uint256 balance) {
        return balanceOf[_owner];
    }

    function allowance(address _owner, address _spender) public view returns (uint256 remaining) {
        return allowance[_owner][_spender];
    }
}