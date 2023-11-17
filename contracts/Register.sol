
// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.17 and less than 0.9.0
pragma solidity ^0.8.17;



contract Register {

    address owner;

    constructor(){
        owner = msg.sender;
    }

    modifier onlyOwner(){
        require(msg.sender == owner, "NOT OWNER!!");
        _;
    }

    mapping(address => string) registered;
    mapping(string => bool) nameTaken;
    mapping(address => bool) addressTaken;

    function registerName(string memory name, address nameAddress) external onlyOwner{
        require(bytes(name).length > 0, "Name cannot be empty");
        require(nameAddress != address(0), "Zero Address");
        require(nameTaken[name] == false && addressTaken[nameAddress] == false, "Taken!!");
        registered[nameAddress] = name;

        nameTaken[name] = true;
        addressTaken[nameAddress] = true;

    }
    
    function updateName(string memory newName, address nameAddress) external onlyOwner {
        require(bytes(newName).length > 0, "Name cannot be empty");
        require(addressTaken[nameAddress], "Address have no name, Register!!" );
        string memory initialName = registered[nameAddress];
        nameTaken[initialName] = false;
        nameTaken[newName] = true;
        registered[nameAddress] = newName;

    }

    function viewName(address nameAddress) public view onlyOwner returns(string memory){
        require(addressTaken[nameAddress], "Address have no name, Register!!" );
        return registered[nameAddress];
    }
}
