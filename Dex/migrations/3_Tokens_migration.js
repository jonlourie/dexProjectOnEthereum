const Link = artifacts.require("Link");
const Wallet = artifacts.require("Wallet");

module.exports = async function (deployer) {
  await deployer.deploy(Link);

        //implement a better migration
  //initialize our instances
    let wallet = await Wallet.deployed();
    let link = await Link.deployed();

    //now we interact with our methods 

    await link.approve(wallet.address, 5000); //call our required approval function for the ERC20 token
    await wallet.addToken(web.utils.fromUtf8("LINK"), link.address); //we add the token then we can interact with the token 
    await wallet.deposit(100, web.utils.fromUtf8("LINK")); //call our deposit function automically deposit 100 link in the wallet - we could use symbol() if we dont know the symbols

 
    //to make our testing easier in truffle we can add all of our functions that we do in the console and automitcally have them execute on the last migration contract 


};
