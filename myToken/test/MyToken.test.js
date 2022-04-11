const Token = artifacts.require("MyToken");

var chai = require("chai");
const BN = web3.utils.BN;
const chaiBN = require("chai-bn")(BN);
chai.use(chaiBN);

var chaiAsPromised = require("chai-as-promised"); // allows for the use of "eventually instead of await"
chai.use(chaiAsPromised);

const expect = chai.expect;

contract("Token Test", async (accounts) => {
  const [deployerAccount, recipient, anotherAccount] = accounts;

  it("all tokens should be in my account", async () => {
    let instance = await Token.deployed();
    let totalSupply = await instance.totalSupply();
    // let balance = await instance.balanceOf(acccounts[0]);
    // assert.equal(balance.valueOf(), totalSupply.valueOf(), "The balance was not the same");
    await expect(instance.balanceOf(deployerAccount)).to.eventually.be.a.bignumber.equal(totalSupply);
  });

  it("is possible to send tokens between accounts", async () => {
    const sendTokens = 1;
    let instance = await Token.deployed();
    let totalSupply = await instance.totalSupply();

    await expect(instance.balanceOf(deployerAccount)).to.eventually.be.a.bignumber.equal(totalSupply);
    await expect(instance.transfer(recipient, sendTokens)).to.eventually.be.fulfilled;
    await expect(instance.balanceOf(deployerAccount)).to.eventually.be.a.bignumber.equal(totalSupply.sub(new BN(sendTokens)));
    await expect(instance.balanceOf(recipient)).to.eventually.be.a.bignumber.equal(new BN(sendTokens))
    
  })

  it("is not possible to send more tokens than available in total", async () => {
    let instance = await Token.deployed();
    let balanceOfDeployer = await instance.balanceOf(deployerAccount);
    await expect(instance.transfer(recipient, balanceOfDeployer+1)).to.eventually.be.rejected;
    await expect(instance.balanceOf(deployerAccount)).to.eventually.be.a.bignumber.equal(balanceOfDeployer); 
  })

  it("is possible to return tokens between accounts", async () => {
    const sendTokens = 1;
    let instance = await Token.deployed();
    let totalSupply = await instance.totalSupply();

    await expect(instance.balanceOf(deployerAccount)).to.eventually.be.a.bignumber.equal(totalSupply.sub(new BN(sendTokens)));
    await expect(instance.transfer(deployerAccount, sendTokens, {from: recipient})).to.eventually.be.fulfilled;
    await expect(instance.balanceOf(deployerAccount)).to.eventually.be.a.bignumber.equal(totalSupply);
    
  })
  
});

