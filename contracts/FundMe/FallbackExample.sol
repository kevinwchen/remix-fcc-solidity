// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract FallbackExample {
    uint256 public result;
    receive() external payable { // function keyword not needed
        // receive gets called anytime we send a transaction to contract,
        // there are no specified functions in the contract, and the
        // calldata is blank
        result = 1;
    }

    fallback() external payable {
        // fallback gets called if there is no relevant function call
        // based on the calldata given
        result = 2;
    }
}