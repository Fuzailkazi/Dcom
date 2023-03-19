// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract Dappazon {

    // string public name ; // name of the contract
    address public owner; // owner of the contract 

    struct Item {
        uint256 id;
        string name;
        string category;
        string image;
        uint256 cost;
        uint256 rating;
        uint256 stock;
    }

    struct Order{
        uint256 time;
        Item item;
    }

    mapping (uint256 => Item) public items;
    mapping(address => uint256) public orderCount;
    mapping(address => mapping(uint256=>Order)) public orders;

    event Buy(address buyer, uint256 orderId, uint256 itemId);
    event List(string name, uint256 cost, uint256 quantity);

    modifier onlyOwner(){
        require(msg.sender == owner);
        _;

    }

    constructor(){
       // name = "Dappazon";
        owner = msg.sender; //  person who's currently connecting with the contract.
    }
    // list prodicts 
    function list(uint256 _id,string memory _name, string memory _category, string memory 
    _image, uint256 _cost, uint256 _rating , uint256 _stock) public onlyOwner{
        // code


        // create Item struct
        Item memory item = Item(_id , _name , _category , _image , _cost, _rating, _stock);

        // save Item struct to blockchain
        items[_id] = item;

        // emit the event
        emit List(_name, _cost, _stock);

    }

    // buy products

    function buy(uint256 _id) public payable{
        // fetch item
        Item memory item = items[_id];

        // require enough ehter to buy the product 
        require(msg.value >= item.cost);

        // require the item in stock 
        require(item.stock>0);

        // create an order 
        Order memory order = Order(block.timestamp, item);

        // save order for user
        orderCount[msg.sender]++;
        orders[msg.sender][orderCount[msg.sender]] = order;

        //subtract stock
        items[_id].stock = item.stock - 1;
        // emit the event
    }    



    // withdraw funds
    function withdraw() public onlyOwner{
        (bool success,) = owner.call{value: address(this).balance}("");
        require(success);
    }


}