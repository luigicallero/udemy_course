//SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

contract MappingsStructExample {
    struct Payment {
        uint amount;
        uint time;
    }

    struct Balance {
        uint totalBalance;
        uint numPayments;
        mapping (uint => Payment) payments;
    }

    mapping(address => Balance) public userDeposited;

    function getContractBalance() public view returns(uint){
        return address(this).balance;
    }

    function receiveMoney() public payable{
        userDeposited[msg.sender].totalBalance+= msg.value;
        Payment memory payment = Payment( msg.value, block.timestamp );
        userDeposited[msg.sender].payments[userDeposited[msg.sender].numPayments] = payment;
        userDeposited[msg.sender].numPayments++;
    }

    function withdrawMoney( address payable _withdrawer, uint _amount ) public {
        require(_amount <= userDeposited[msg.sender].totalBalance, "Not enough money to retire deposits");
        userDeposited[msg.sender].totalBalance -= _amount;
        _withdrawer.transfer(_amount);
    }
}