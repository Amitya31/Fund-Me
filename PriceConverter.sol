// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol"; //importing from npm  

library PriceConverter {
    function getPrice() public view returns(uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (,int256 answer,,,) = priceFeed.latestRoundData(); // its like destructuring in javascript
        // returns price of Eth in terms of USd
        return uint256(answer * 1e10); // as msg.value is of 10^18 while answer is of only 10^8 eth
    }
    function getConversionRate(uint256 ethAmount) external view returns(uint256) {
        uint256 ethPrice = getPrice(); // current eth Price means USD
        uint256 ethAmountToUsd = (ethPrice * ethAmount) / 1e18; //current ethPrice * input eth Amount
        return ethAmountToUsd;
    }
}