const Asset = artifacts.require("Asset");

contract("2nd MetaCoin test", async accounts=> {
    it("should put 10000 MetaCoin in the first account", async () => {
        let instance = await Asset.deployed();
        
        // let pieces = await instance.pieces.call(accounts[0])
        console.log(instance)
        assert.equal(1, 10000);
    });
  
  });