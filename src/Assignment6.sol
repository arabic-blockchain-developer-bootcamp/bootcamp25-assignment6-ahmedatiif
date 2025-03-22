// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Assignment6 {
    // 1. Declare an event called `FundsDeposited` with parameters: `sender` and `amount`
    event FundsDeposited(address indexed sender, uint amount);

    // 2. Declare an event called `FundsWithdrawn` with parameters: `receiver` and `amount`
    event FundsWithdrawn(address indexed receiver, uint amount);

    // 3. Create a public mapping called `balances` to track users' balances
    mapping(address => uint) public balances;

    // Modifier to check if sender has enough balance
    modifier hasEnoughBalance(uint amount) {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        _;
    }

    // Function to deposit Ether
    function deposit() external payable {
        require(msg.value > 0, "Deposit amount must be greater than zero");

        // Increment user balance in balances mapping
        balances[msg.sender] += msg.value;

        // Emit the `FundsDeposited` event
        emit FundsDeposited(msg.sender, msg.value);
    }

    // Function to withdraw Ether
    function withdraw(uint amount) external hasEnoughBalance(amount) {
        // Decrement user balance from balances mapping
        balances[msg.sender] -= amount;

        // Send tokens to the caller
        payable(msg.sender).transfer(amount);

        // Emit the `FundsWithdrawn` event
        emit FundsWithdrawn(msg.sender, amount);
    }

    // Function to check the contract balance
    function getContractBalance() public view returns (uint) {
        return address(this).balance;
    }
}
