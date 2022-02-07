// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "./Allowance.sol";

contract SimpleWallet is Allowance{
    event MoneyReceived(address indexed _fromWho, uint _amount);
    event MoneySent(address indexed _beneficiary, uint _amount);

    function withdrawMoney(address payable _to, uint _amount) public ownerOrAllowed(_amount){
        require(_amount < address(this).balance,"Not enough funds in this Contract");
        emit MoneySent(_to, _amount);
        if( (owner() != msg.sender)) {
            reduceAllowance(msg.sender, _amount);
        }
        _to.transfer(_amount);
    }

    receive() external payable {
        emit MoneyReceived(msg.sender, msg.value);
    }

    function getContractBalance() public view returns(uint){
        return address(this).balance;
    }

    function renounceOwnership() public override pure{
        revert ("Can not renounce Ownership for this Contract");
    }
}