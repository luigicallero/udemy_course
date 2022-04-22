//SPDX-License-Identifier: MIT
pragma solidity >=0.6.1;

import "@openzeppelin/contracts/access/Ownable.sol";

contract KycContract is Ownable {
  mapping(address => bool) allowed;
  function kycCompleted ( address _addressToKyc ) public onlyOwner{
    allowed[_addressToKyc] = true;
  }
  function kycRejected ( address _addressToKyc ) public onlyOwner{
    allowed[_addressToKyc] = false;
  }
   function kycReview ( address _addressToKyc ) public view returns(bool) {
    return allowed[_addressToKyc];
  }
}
