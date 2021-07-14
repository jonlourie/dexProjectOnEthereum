
// SPDX-License-Identifier: MIT

pragma solidity >=0.4.22 <0.9.0;

import "../node_modules/@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "../node_modules/@openzeppelin/contracts/utils/math/SafeMath.sol";
import "../node_modules/@openzeppelin/contracts/access/Ownable.sol";

contract Wallet is Ownable { //put open zepplin contracts in later

    using SafeMath for uint256; //we are using it as applied to uint256

    struct Token {
        bytes32 ticker;
        address tokenAddress;
    }

    modifier tokenExists(bytes32 ticker) {

        require(tokenMapping[ticker].tokenAddress != address(0), "Token Does Not Exist");
        _;
    }

    //we are interacting with ERC20 interface here so we are using lots of external calls to save on gas
    //we save the tokens using a token mapping and saving each mapping in a dynamikc array with the token id's - could we just make an of tyoe tokenmapping
    mapping(bytes32 => Token) public tokenMapping;
    bytes32[] public tokenList; //the tickers stored in here 

    mapping(address => mapping(bytes32 => uint256)) public balances; //mapping for balances of different tokens
    //remember we declare the mapping name it and set its veiwable access   

    //we make the function external because we dont need to use it in here and we can save on gas
    //do more research into the external function still dont get it it saves on on gas and can only be called by tokens outside the contract
    function addToken(bytes32 ticker, address tokenAddress) onlyOwner() external  {
        
        tokenMapping[ticker] = Token(ticker, tokenAddress); //we set the mapping with the the ticker as parameter to point to a new token with the ticker and the address
        tokenList.push(ticker); //then we push the ticker to the list

    }

    function deposit(uint amount, bytes32 ticker) tokenExists(ticker) external {
        //require(tokenMapping[ticker].tokenAddress != address(0), "Token Address Not Found");
        balances[msg.sender][ticker] = balances[msg.sender][ticker].add(amount);
        IERC20(tokenMapping[ticker].tokenAddress).transferFrom(msg.sender, address(this), amount); //here we depositing monmey into the contract - transfering from the call address "us"
        
    }

    function withdraw(uint amount, bytes32 ticker) tokenExists(ticker) external {
        //require(balances[msg.sender][ticker] >= amount, "Balance Too Little ");
        require(tokenMapping[ticker].tokenAddress != address(0), "Token Address Not Found"); //we make sure there is a token there by checking it agianst the zero address
        balances[msg.sender][ticker] = balances[msg.sender][ticker].sub(amount); //we are now withfdrawing into ourr own account that is what msg.sender means
        IERC20(tokenMapping[ticker].tokenAddress).transfer(msg.sender, amount); 
    }

}