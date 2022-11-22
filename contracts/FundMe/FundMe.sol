// Get funds from users
// Withdraw funds
// Set a minimum funding value in USD

// Transactions - Value Transfer
// Nonce: tx count for the account
// Gas price: price per unit of gas (in wei)
// Gas Limit: max gas that this tx can users
// To: address the tx is sent to
// Value: amount of wei to send
// Data: what to sned to the To address
// v, r, s: components of tx signature


// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "./PriceConverter.sol";

contract FundMe {
    using PriceConverter for uint256;

    uint256 public minimumUsd = 50 * 1e18;

    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;

    function fund() public payable {
        // Want to be able to set a minimum fund amount in USD
        // 1. How do we send ETH to this contract?

        // require(boolean, revert message)
        // Reverting undoes any previous action, send remaining gas back
        require(msg.value.getConversionRate() >= minimumUsd, "Didn't send enough!"); // 1e18 wei = 1ETH
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = msg.value;
    }

    // function withdraw() {}
}