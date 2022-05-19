
const EscrowContract = artifacts.require("Escrow");

describe("Escrow contract", function () {
    let accounts;
  
    before(async function () {
      accounts = await web3.eth.getAccounts();
    });
  
    describe("Deployment", function () {
      it("Deploying the Escrow contract", async function () {
          const Escrow = await EscrowContract.new();
  
          await Escrow.deposit(accounts[1], accounts[2], { value: 1e+18, from: accounts[0] });
          assert.equal((await web3.eth.getBalance(Escrow.address)), 1e+18, "amount did not match");
  
          await Escrow.approve(0, { from: accounts[2] });
          assert.equal((await web3.eth.getBalance(Escrow.address)), 0, "didn't transfer ether");
        });
    });
});