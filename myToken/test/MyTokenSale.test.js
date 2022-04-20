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


})