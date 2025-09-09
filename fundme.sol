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

    function withdraw() public {
        for(/*starting index, ending index, step index */ uint256 funderIndex = 0; funderIndex < funder.length; funderIndex++){
            address funders = funder[funderIndex];
            addresstoAmount[funders] = 0;
        }
        funder = new address[](0); //resetting the array with type address to 0
        //sending an Eth from a contract
        //There are three ways to actually send eth from a contract

        //transfer
        //send
        //call

        //msg.sender = type address
        //payable(msg.sender) = type payable address
        //in solidity to send the native blockvhain token such as ethereum it can be only done by payable
        // lets start with the transfer so to transfer the funds whoever is calling the widthdraw function
        payable(msg.sender).transfer(address(this).balance); //this keyword refers to this wholw contract 
        //address(this).balance //with this we get native currency of this address using this
        // as we know that when you transfer fund from one account to another it cost gas fees which is around 2100 hence "transfer" is capped at 2300 means if more than this gas is used it will give an error
        // as we know that when you transfer fund from one account to another it cost gas fees which is around 2100 hence "send" is capped at 2300 means if more than this gas is used it will give boolean as return means if txn completed than 

        //send
        bool sendSuccess = payable(msg.sender).send(address(this).balance);
        require(sendSuccess,"Error in sending the transaction");

        // difference in send and transfer 
        // when send the transaction does not automatically reverts when fail,we need to customize or add the require function
        // when transfer the transaction automatically reverts when fail 
        

    }
    
}