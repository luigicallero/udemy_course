pragma solidity ^0.8.0;

import "./ItemManager.sol";

// Contract to manage the pricing and purchase of items
contract Item {
    uint public priceInWei;
    uint public pricePaid;
    uint public index;

    ItemManager parentContract;

    constructor(ItemManager _parentContract, uint _priceInWei, uint _index) {
        priceInWei = _priceInWei;
        parentContract = _parentContract;
        index = _index;
    }

    receive() external payable{
        require(pricePaid == 0, "Item is paid already");
        require(priceInWei == msg.value, "Only full payment allowed");
        pricePaid += msg.value;
        (bool success, ) = address(parentContract).call{value:msg.value}(abi.encodeWithSignature("triggerPayment(uint256)",index));
        require(success, "Transaction was not successful, canceling...");
    }

    fallback() external{}
}
