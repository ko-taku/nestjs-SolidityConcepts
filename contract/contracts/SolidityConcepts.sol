// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SolidityConcepts {
    uint256 public constant FIXED_VALUE = 100;
    address public immutable owner;
    uint256 public value = 50;

    constructor() {
        owner = msg.sender;
    }

    function checkValue(uint256 _value) public pure returns (string memory) {
        if (_value > 100) {
            return "Value is greater than 100";
        } else if (_value == 100) {
            return "Value is exactly 100";
        } else {
            return "Value is less than 100";
        }
    }

    function sumUpTo(uint256 _value) public pure returns (uint256) {
        uint256 sum = 0;
        for (uint256 i = 1; i <= _value; i++) {
            sum += i;
        }
        return sum;
    }

    event ValueChanged(uint256 oldValue, uint256 newValue);

    function updateValue(uint256 _value) public {
        uint256 oldValue = value;
        value = _value;
        emit ValueChanged(oldValue, value);
    }
    modifier onlyOwner() {
        require(msg.sender == owner, "Not the contract owner");
        _;
    }

    function ownerFunction() public view onlyOwner returns (string memory) {
        return "Hello, Owner!";
    }

    receive() external payable {}

    function sendEther(address payable _address) public payable {
        require(msg.value > 0, "Must send ether");
        (bool success, ) = _address.call{value: msg.value}("");
        require(success, "Transfer failed");
    }

    function getContractBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function withDraw() public onlyOwner {
        (bool success, ) = msg.sender.call{value: address(this).balance}("");
        require(success, "Transfer failed");
    }
}
