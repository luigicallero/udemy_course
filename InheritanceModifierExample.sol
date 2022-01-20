//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "./Owned.sol";

contract InheritanceModifierExample is Owned {

    uint public tokenPrice = 1 ether;
    mapping(address => uint) tokenBalance;

    constructor () {
        tokenBalance[owner] = 100;
    }

    function createToken() public onlyOwner {
        tokenBalance[owner] ++;
    }

    function burnToken() public onlyOwner {
        tokenBalance[owner] --;
    }

    function buyToken() public payable {
        require(msg.value >= tokenPrice, "Not enough money");
        require(tokenBalance[owner] >= msg.value / tokenPrice, "Not enough tokens for sale" );
        tokenBalance[msg.sender] += msg.value / tokenPrice;
        tokenBalance[owner] -= msg.value / tokenPrice;
    }

    function sendToken(uint _amount, address _receiver ) public {
        require(tokenBalance[msg.sender] >= _amount, "Not enough tokens");
        tokenBalance[msg.sender] -= _amount;
        tokenBalance[_receiver] += _amount;
    }

    function getTokenBalanceOwner() public view returns(uint) {
        return tokenBalance[owner];
    }

}
