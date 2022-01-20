//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract EventExample {

    uint public tokenPrice = 1 ether;
    mapping(address => uint) tokenBalance;

    event TokenSent( address _from, address _to, uint _amount );

    constructor () {
        tokenBalance[msg.sender] = 100;
    }

    function sendToken(uint _amount, address _receiver ) public returns(bool) {
        require(tokenBalance[msg.sender] >= _amount, "Not enough tokens");
        tokenBalance[msg.sender] -= _amount;
        tokenBalance[_receiver] += _amount;
        emit TokenSent( msg.sender, _receiver, _amount );
        return true;
    }

}