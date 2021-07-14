// SPDX-License-Identifier: MIT

pragma solidity >=0.4.22 <0.9.0;
pragma experimental ABIEncoderV2; //we need this bnecause we are returning an array type

import "../contracts/Wallet.sol";

contract Dex is Wallet {


    //alternitively we could have an enum enumerated list with two properties buy or sell 
    //like boolean with custom values
    enum Side {
        
        BUY,
        SELL
    }

    struct Order {

        uint id; //id of order 
        address trader; //trader address       
        bytes32 ticker;
        uint amount; 
        uint price;
        bool isBuy;
     
        //Order.side = side.buy || side.sell
        //

    }

    //the order book is split into two 
    //users should be able to input there buy and sell orders

    mapping(bytes32 => mapping(uint => Order[])) public orderBook;

    function getOrderBook(bytes32 ticker, Side side) view public returns(Order[] memory) {
        return orderBook[ticker][uint(side)];
    }

    //market order will be taken from the order book automatically 
    //limit ordewrs will be put in by the user
    //market makers makes orders in the order book or a taker or takes orders in the order book

    function createLimitOrder() {
        //the best price will always bge first in the order book 
        //buy side is the higherst price at the top of thye order book/selll side is lowest price

    }


}