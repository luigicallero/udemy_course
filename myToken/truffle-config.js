const HDWalletProvider = require('@truffle/hdwallet-provider');
const path = require("path");
const AccountIndex = 0;

require("dotenv").config({path: "./.env"});

module.exports = {
  // See <http://truffleframework.com/docs/advanced/configuration>
  // to customize your Truffle configuration!
  contracts_build_directory: path.join(__dirname, "client/src/contracts"),
  networks: {
    develop: {
      host: "127.0.0.1",
      port: 8545,
      network_id: "*", // match any network
      websockets: true
    },
    ganache: {
      provider: function() {
        return new HDWalletProvider(process.env.MNEMONIC, "http://127.0.0.1:8545/", AccountIndex);
      },
      network_id: '1651490686169',
    },
    truffle: {
      // must be a thunk, otherwise truffle commands may hang in CI
      provider: () =>
        new HDWalletProvider({
          mnemonic: {
            phrase: process.env.MNEMONIC
          },
          providerOrUrl: "http://127.0.0.1:8545",
        }),
      network_id: '5777',
    },
    matic: {
      provider: () => new HDWalletProvider(process.env.MNEMONIC, `http://127.0.0.1:8545`),
      network_id: "*"
    },
  },
  compilers: {
    solc: {
      version: "^0.6.0"
    }
  }
};
