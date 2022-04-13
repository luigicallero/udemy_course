var MyToken = artifacts.require("./MyToken.sol");
var MyTokenSale = artifacts.require("./MyTokenSale");

module.exports = async function(deployer) {
  let accounts = await web3.eth.getAccounts();
  await deployer.deploy(MyToken,1000000);
  await deployer.deploy(MyTokenSale,1,accounts[0],MyToken.address);  //rate set to 1 wei, wallet is deployer account, token contract address
  let instance = await MyToken.deployed();
  await instance.transfer(MyTokenSale.address, 1000000);
};
