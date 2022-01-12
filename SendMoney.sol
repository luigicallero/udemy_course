// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.5.13;

contract SendMoney {
    uint public moneyDeposited;

    function receiveMoney() public payable {
        moneyDeposited += msg.value;
    }

    function contractBalance() public view returns(uint){
        return address(this).balance;
    }
// Function to extract it all in contract to who is executing this function
    function withdrawMoney() public{
        address payable withdrawAddress = msg.sender;
        withdrawAddress.transfer(this.contractBalance());
    }
// Function to send all money in contract to the address specified
    function withdrawMoneyTo(address payable _withdrawAddress) public{
        _withdrawAddress.transfer(this.contractBalance());
    }
}