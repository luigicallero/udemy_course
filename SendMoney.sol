// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.1;

contract SendMoney {
    uint public moneyDeposited;
    uint public lockTime;

    function receiveMoney() public payable {
        moneyDeposited += msg.value;
        lockTime = block.timestamp + 1 minutes;
    }

    function contractBalance() public view returns(uint){
        return address(this).balance;
    }
// Function to extract it all in contract to who is executing this function
    function withdrawMoney() public{
        if( block.timestamp > lockTime ) {
            address payable withdrawAddress = payable(msg.sender);
            withdrawAddress.transfer(contractBalance());
        }
    }
// Function to send all money in contract to the address specified
    function withdrawMoneyTo(address payable _withdrawAddress) public{
        require(block.timestamp > lockTime, 'Time for withdraw not yet fulfilled');
        _withdrawAddress.transfer(contractBalance());
    }
}