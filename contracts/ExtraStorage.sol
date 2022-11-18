// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./SimpleStorage.sol";

contract ExtraStorage is SimpleStorage { // 'is' to inherit functions from SimpleStorage contract
    // + 5
    // override functions from inherited contract
    // "virtual" keyword needed in original contract
    // "override" keyword needed for new contract

    function store(uint256 _favouriteNumber) public override{
        favouriteNumber = _favouriteNumber + 5;
    }
}