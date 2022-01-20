//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Mapping {

    mapping (uint => bool) public records;
    mapping (address => bool) public wallets;
    mapping (uint => mapping(uint => bool)) myDoubleMapping;  // since I decided for X reason not to make it public I had to create a getter function

    function setValueTrue(uint _index) public {
        records[_index] = true;
    }

    function addAddressWhiteList() public {
        wallets[msg.sender] = true;
    }

    function getMyDoubleMapping(uint _transaction, uint _userId) public view returns(bool) {
        return myDoubleMapping[_transaction][_userId];
    }

    function setDoubleMappingTrue (uint _transaction, uint _userId ) public {
        myDoubleMapping[_transaction][_userId] = true;
    }

}