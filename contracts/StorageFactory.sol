// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {SimpleStorage} from "./SimpleStorage.sol";

contract StorageFactory {
    SimpleStorage[] public listOfSimpleStorageContracts;

    // Events
    event SimpleStorageCreated(address indexed creator, address contractAddress, uint index);
    event StorageUpdated(address indexed updater, uint index, uint newValue);

    function createSimpleStorageContract() public returns (address) {
        SimpleStorage newSimpleStorage = new SimpleStorage();
        listOfSimpleStorageContracts.push(newSimpleStorage);
        emit SimpleStorageCreated(msg.sender, address(newSimpleStorage), listOfSimpleStorageContracts.length - 1);
        return address(newSimpleStorage);
    }

    function storageFactoryStore(uint _simpleStorageIndex, uint _newSimpleStorageNumber) public {
        require(_simpleStorageIndex < listOfSimpleStorageContracts.length, "Index out of bounds");
        SimpleStorage mySimpleStorage = listOfSimpleStorageContracts[_simpleStorageIndex];
        mySimpleStorage.store(_newSimpleStorageNumber);
        emit StorageUpdated(msg.sender, _simpleStorageIndex, _newSimpleStorageNumber);
    }

    function storageFactoryGet(uint _simpleStorageIndex) public view returns (uint) {
        require(_simpleStorageIndex < listOfSimpleStorageContracts.length, "Index out of bounds");
        SimpleStorage mySimpleStorage = listOfSimpleStorageContracts[_simpleStorageIndex];
        return mySimpleStorage.retrieve();
    }

    function getContractCount() public view returns (uint) {
        return listOfSimpleStorageContracts.length;
    }

    function getContractAddress(uint _index) public view returns (address) {
        require(_index < listOfSimpleStorageContracts.length, "Index out of bounds");
        return address(listOfSimpleStorageContracts[_index]);
    }

    function getAllContracts() public view returns (address[] memory) {
        address[] memory contracts = new address[](listOfSimpleStorageContracts.length);
        for (uint i = 0; i < listOfSimpleStorageContracts.length; i++) {
            contracts[i] = address(listOfSimpleStorageContracts[i]);
        }
        return contracts;
    }
}