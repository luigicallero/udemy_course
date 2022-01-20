//SPDX-License-Identifier: MITs
pragma solidity ^0.8.1;

contract FunctionExample {
    mapping(address => uint) balance;
    address payable public owner;

    constructor() {
        owner = payable(msg.sender);
    }

    function deleteContract () public {
        require(owner == msg.sender, "You are not the owner");
        selfdestruct(owner);
    }

    function receiveMoney() public payable {
        balance[msg.sender] += msg.value;
    }

    function withdrawMoney(address payable _destination, uint _amount) public {
        require( balance[msg.sender] >= _amount, "Not enough money in your deposit" );
        balance[msg.sender] -= _amount;
        _destination.transfer(_amount);
    }

    function contractBalance() public view returns(uint) {
        return address(this).balance;
    }

    receive () external payable {
        receiveMoney();
    }

    function getOwner () public view returns(address) {
        return owner;
    }

    function convertToEther (uint _wei) public pure returns(uint) {
        return _wei / 1 ether;
    }
}