var simpleDapp = artifacts.require("./simpleDapp.sol");

module.exports = function(deployer) {
  deployer.deploy(simpleDapp);
};