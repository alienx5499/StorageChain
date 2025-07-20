// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract SimpleStorage {
    uint public myFavouriteNumber;

    struct Person {
        uint favouriteNumber;
        string name;
    }

    Person[] public listOfPeople;

    mapping (string => uint) public nameToFavouriteNumber;

    // Events
    event NumberStored(address indexed sender, uint number);
    event PersonAdded(address indexed sender, string name, uint favouriteNumber);

    function store(uint _favouriteNumber) public virtual {
        myFavouriteNumber = _favouriteNumber;
        emit NumberStored(msg.sender, _favouriteNumber);
    }

    function retrieve() public view returns (uint) {
        return myFavouriteNumber;
    }

    function addPerson(uint _favouriteNumber, string memory _name) public {
        listOfPeople.push(Person(_favouriteNumber, _name));
        nameToFavouriteNumber[_name] = _favouriteNumber;
        emit PersonAdded(msg.sender, _name, _favouriteNumber);
    }

    function getPersonCount() public view returns (uint) {
        return listOfPeople.length;
    }

    function getPerson(uint _index) public view returns (uint favouriteNumber, string memory name) {
        require(_index < listOfPeople.length, "Index out of bounds");
        Person memory person = listOfPeople[_index];
        return (person.favouriteNumber, person.name);
    }

    function getFavouriteNumberByName(string memory _name) public view returns (uint) {
        return nameToFavouriteNumber[_name];
    }
}