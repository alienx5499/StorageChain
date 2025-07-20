// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {SimpleStorage} from "./SimpleStorage.sol";

contract AddFiveStorage is SimpleStorage {
    // Events
    event NumberStoredWithFive(address indexed sender, uint originalNumber, uint result);

    function store(uint _newNumber) public virtual override {
        uint result = _newNumber + 5;
        myFavouriteNumber = result;
        emit NumberStoredWithFive(msg.sender, _newNumber, result);
    }

    function getOriginalNumber(uint _storedNumber) public pure returns (uint) {
        require(_storedNumber >= 5, "Number must be at least 5");
        return _storedNumber - 5;
    }

    function addFiveAndStore(uint _number) public {
        store(_number);
    }
}