// SPDX-License-Identifier:MIT

pragma solidity ^0.8.18;

contract FundMe{
    //Allow users to send $
    // minimum $ sent 5$
    function fund() public payable {
        require(msg.value >= minimumUsd,"Didn,t send enough usd");
    }
}