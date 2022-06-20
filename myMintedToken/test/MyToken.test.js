const Token = artifacts.require("MyToken");

const chai = require("./setupchai.js");
const BN = web3.utils.BN;
const expect = chai.expect;

require("dotenv").config({path: "../.env"});

contract("SUB Token Test", async (accounts) => {

    const [deployerAccount, recipient, anotherAccount] = accounts;

    beforeEach(async() => {
        this.myToken = await Token.new();
    })

    it("should not have any tokens initially created", async () => {
        let instance = this.myToken;
        return expect(instance.totalSupply()).to.eventually.be.a.bignumber.equal(new BN(0));
    })

    it("Deployer account has minter role and will mint 10 tokens", async() => {
        let mintAmount = 10;
        let instance = this.myToken;
        let totalSupply = await instance.totalSupply();
        expect(totalSupply).to.be.a.bignumber.equal(new BN(0));
        //expect(instance.mint(deployerAccount, mintAmount)).to.eventually.be.fulfilled;
        expect(instance.isMinter(deployerAccount)).to.eventually.throw('false');
        //expect(instance.isMinter(deployerAccount)).to.eventual
        //return expect(instance.balanceOf(deployerAccount)).to.eventually.be.a.bignumber.equal(new BN(mintAmount));
    });
/* 
    it("is not possible to send more tokens than available in total", async () => {
        let instance = this.myToken;
        let balanceOfDeployer = await instance.balanceOf(deployerAccount);

        expect(instance.transfer(recipient, new BN(balanceOfDeployer+1))).to.eventually.be.rejected;

        return expect(instance.balanceOf(deployerAccount)).to.eventually.be.a.bignumber.equal(balanceOfDeployer);
    }); */

});