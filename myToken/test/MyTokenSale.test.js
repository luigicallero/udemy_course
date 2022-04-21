const TokenSale = artifacts.require("MyTokenSale");
const Token = artifacts.require("MyToken");

const chai = require("./chaiSetup.js");
const BN = web3.utils.BN;
const expect = chai.expect;

require("dotenv").config({path: "../.env"});

contract("Testing Token Sale", async(accounts) => {
  const [deployerAccount, recipient, anotherAccount] = accounts;

  it("Should not have any token in my Deployer Account", async() =>{
    let instance = await Token.deployed();
    let balance = await instance.balanceOf(deployerAccount);
    return expect(balance).to.be.a.bignumber.equal(new BN(0));
  })

  it("all tokens should be at Token Sale Contract by default", async() => {
    let instance = await Token.deployed();
    let tokenSalebalance = await instance.balanceOf(TokenSale.address);
    let totalSupply = await instance.totalSupply();
    return expect(tokenSalebalance).to.be.a.bignumber.equal(totalSupply);
  })

  it("should be possible to buy tokens from Token Sale Contract", async() => {
    let tokenInstance = await Token.deployed();
    let tokenSaleInstance = await TokenSale.deployed();
    let balanceBefore = await tokenInstance.balanceOf(deployerAccount);
    await expect(tokenSaleInstance.sendTransaction({from: deployerAccount, value:web3.utils.toWei('1','wei')})).to.be.fulfilled; // buying 1 token equal 1 wei
    await expect(tokenInstance.balanceOf(deployerAccount)).to.eventually.be.a.bignumber.equal(balanceBefore + new BN(1));
  })
})