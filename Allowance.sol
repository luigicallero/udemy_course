//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract Allowance is Ownable {
    mapping(address => uint) public allowance;
    event AllowanceChanged (address indexed _toWho, address indexed _fromWhom, uint oldAmount, uint newAmount);

    function addAllowance(address _who, uint _amount) public onlyOwner{
        emit AllowanceChanged(_who, msg.sender, allowance[_who], _amount);
        allowance[_who] = _amount;
    }

    function reduceAllowance(address _who, uint _amount) internal {
        emit AllowanceChanged(_who, msg.sender, allowance[_who], allowance[_who] - _amount);
        allowance[_who] -= _amount;
    }

    modifier ownerOrAllowed(uint _amount) {
        //require(isOwner(),"You are not allowed");
        require( (owner() == msg.sender) || allowance[msg.sender] >= _amount, "You are not allowed!");
        _;
    }
}