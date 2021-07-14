const Dex = artifacts.require("Dex") 

contract("Dex", accounts => {

        it("should only be possible for owner to add tokens", async () => {

            await deployer.deploy(Link);

            //implement a better migration
            //initialize our instances
            let wallet = await Wallet.deployed();
            let link = await Link.deployed();
    
            //now we interact with our methods 
    
            await link.approve(wallet.address, 5000); //call our required approval function for the ERC20 token
            await wallet.addToken(web.utils.fromUtf8("LINK"), link.address); 


            //rename wallet migration 
        })


})