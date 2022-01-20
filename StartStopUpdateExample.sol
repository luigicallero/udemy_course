// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.1;

contract StartStopUpdateExample {

    address public owner;
    bool public paused;

    constructor(){
        owner = msg.sender; 
    }

    function receiveMoney() public payable {

    }

    function pauseContract(bool _paused) public {
        require(msg.sender == owner, "You are NOT the owner"); 
        paused = _paused;
    }

    function withdraw(address payable _withdrawAddress) public {
        require( msg.sender == owner, "You are NOT the owner" );
        require(!paused, "Contract is paused");
        _withdrawAddress.transfer(address(this).balance);
    }

    // when a contract is selfdestroyed you need to indicate where are all funds sent to
    function destroyThisSmartContract(address payable _fundsReceiver) public {
        require(msg.sender == owner, "Not the owner");
        selfdestruct( _fundsReceiver );
    }
    
}
