var MyToken = artifacts.require("./MyToken.sol");
var MyTokenSale = artifacts.require("./MyTokenSale");
require("dotenv").config({path: "../.env"});

module.exports = async function(deployer) {
  let accounts = await web3.eth.getAccounts();
  await deployer.deploy(MyToken, process.env.INITIAL_TOKENS);
  await deployer.deploy(MyTokenSale,1,accounts[0],MyToken.address);  //rate set to 1 wei, wallet is deployer account, token contract address
  let instance = await MyToken.deployed();
  await instance.transfer(MyTokenSale.address, process.env.INITIAL_TOKENS);
};
