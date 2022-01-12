pragma solidity ^0.8.1;

contract WorkingWithVariables {
    uint256 public myUint;

    function setMyUint(uint _myUint) public {
        myUint = _myUint;
    }

    bool public myBool;
    function setMyBool(bool _myBool) public {
        myBool = _myBool;
    }

    uint8 public myUint8; // solidity < 0.8 >>> 0-255 If you use function decrease below 0 it wraps around and show 255 
    function incrementUint() public {
        unchecked { // in case I want it to work as in solidity < 0.8
            myUint8++;
        }
    }
    function decrementUint() public {
        unchecked {
            myUint8--;
        }
    }

    address public myAddress; // 0x and 41 characters
    function setMyAddress(address _myAddress) public {
        myAddress = _myAddress;
    }
    function getBalanceOfAddress() public view returns (uint) {
        return myAddress.balance;
    }

    string public myString = 'Hello World!!';
    function setMyString(string memory _myString) public {
        myString = _myString;
    }
}