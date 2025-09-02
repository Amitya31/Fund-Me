// SPDX-License-Identifier:MIT
pragma solidity ^0.8.18;

import {PriceConverter} from "./PriceConverter.sol";

contract FundMe{
    using PriceConverter for uint256;
    uint256 minimumUsd = 5e18;

    address[] public funder;
    mapping(address funder=>uint256 amount) public addresstoAmount;
    //Allow users to send $
    // minimum $ sent 5$
    function fund() public payable {
        require(msg.value.getConversionRate() >= minimumUsd,"Didn,t send enough usd");
        funder.push(msg.sender);
        addresstoAmount[msg.sender] = addresstoAmount[msg.sender] + msg.value; // the amount the sender sends multiple times
    }

    
}