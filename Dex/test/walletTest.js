const Dex = artifacts.require("Dex") 
const Link = artifacts.require("Link")
const truffleAssert = require("truffle-asserions");

contract("Dex", accounts => {

        it("should only be possible for owner to add tokens", async () => {

            await deployer.deploy(Link);

            //implement a better migration
            //initialize our instances
            let dex = await Dex.deployed();
            let link = await Link.deployed();
    
            //now we interact with our methods 
    
           // await link.approve(wallet.address, 5000); //call our required approval function for the ERC20 token
           await truffleAssert.passes(

            await dex.addToken(web.utils.fromUtf8("LINK"), link.address, {from: accounts[0]}) //put this at the end to modify we only want the 0 account to be able to access 

           );
            


            //rename wallet migration 
        })


})