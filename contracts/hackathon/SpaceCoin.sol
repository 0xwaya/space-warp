// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol"
import "contracts/lib/openzeppelin-contracts/contracts/utils/math/SafeMath.sol"

contract SpaceCoin is ERC20Interface { 
    address public owner;
    string public constant name = "Space Coin";
    string public constant symbol = "SPACE";
    uint8 public constant decimals = 18;
    uint256 public totalSupply = 100000;

    mapping (address => uint) public balanceOf;
    mapping (address => uint256) public balances;
    mapping (address => mapping (address => uint256)) public allowance;
 
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Minted(address indexed _from, address indexed _to, uint256 _value);

    constructor() public {
        owner = msg.sender;
        name = "LottoCoin";
        symbol = "SPACE";
        decimals = 18;
        totalSupply = 100000 * (10 ** uint256(decimals));
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

    function balanceOf(address _owner) public view returns (uint256) {
        return balances[_owner];
    }

    function mint(address _to, uint256 _value) public onlyOwner {
        require(_value > 0, "Mint amount must be greater than 0");
        balances[_to] += _value;
        totalSupply += _value;
        emit Transfer(address(0), _to, _value);
        emit Minted(msg.sender, _to, _value);
    }
  
    function transfer(address _to, uint256 _value) public returns (bool) {
        require(balances[msg.sender] >= _value && _value > 0 && allowed[msg.sender], "Transfer failed");
        balances[msg.sender] -= _value;
        balances[_to] += _value;
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

    modifier transfer(address _to, uint256 _value) {
        require(balanceOf[msg.sender] >= _value);
        _;
    }
}