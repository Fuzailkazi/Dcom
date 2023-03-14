// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract Dappazon {

    string public name ; // name of the contract
    address public owner; // owner of the contract 
    constructor(){
        name = "Dappazon";
        owner = msg.sender; //  person who's currently connecting with the contract.
    }
}