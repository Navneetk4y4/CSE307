// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TokenContract {
    address public owner;
    mapping(address => uint256) public balances;

    
    event Transfer(address indexed from, address indexed to, uint256 value);

   
    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized. Only owner can perform this action.");
        _;
    }

    
    constructor() {
        owner = msg.sender;
    }

   
    function transferTokens(address recipient, uint256 amount) public onlyOwner {
        require(balances[owner] >= amount, "Insufficient balance for transfer.");
        require(recipient != address(0), "Cannot transfer to zero address.");

        
        balances[owner] -= amount;
        balances[recipient] += amount;

        
        emit Transfer(owner, recipient, amount);
    }

    
    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0), "New owner cannot be zero address.");
        owner = newOwner;
    }
}
