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
        funders.push(msg.sender); // add funder address to funders list
        addressToAmountFunded[msg.sender] = msg.value; // add funder address to mapping to amount funded
    }

    function withdraw() public {
        for (uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++) {
            address funder = funders[funderIndex]; // get address for each funder on the list
            addressToAmountFunded[funder] = 0; // reset amount funded to zero
        }
        
        // Reset the array
        funders = new address[](0); // (0) means 0 objects upon declaration

        // Three methods to withdraw funds:
        // transfer
        // Need to typecast address to 'payable address' type
        // payable(msg.sender).transfer(address(this).balance); // 'this' refers to this entire contract
        // // send
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess, "Send failed"); // will revert transaction if fails
        // call
        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed");
    }
}