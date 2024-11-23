// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
contract SecureContract is ReentrancyGuard {
    mapping(address => uint256) private balances;
    function deposit() external payable {
        require(msg.value > 0, "Deposit must be greater than zero");
        balances[msg.sender] += msg.value;
    }
    function withdraw() external nonReentrant {
        uint256 amount = balances[msg.sender];
        require(amount > 0, "No balance to withdraw");

        balances[msg.sender] = 0;

        (bool success,) = msg.sender.call{value: amount}("");
        require(success, "Transfer failed");
    }

    function getBalance() external view returns (uint256) {
        return balances[msg.sender];
    }
}
