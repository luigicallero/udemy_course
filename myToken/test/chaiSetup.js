"use strict";
var chai = require("chai");
const BN = web3.utils.BN;
const chaiBN = require("chai-bn")(BN);
chai.use(chaiBN);

var chaiAsPromised = require("chai-as-promised"); // allows for the use of "eventually instead of await"
chai.use(chaiAsPromised);
module.exports = chai;