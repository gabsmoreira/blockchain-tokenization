const Asset = artifacts.require("Asset");

module.exports = function(deployer, network, accounts) {
  deployer.deploy(Asset, 100, 100, accounts[0]);
};
