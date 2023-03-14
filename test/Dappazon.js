const { expect } = require("chai");
const { ethers } = require("hardhat");
const tokens = (n) => {
  return ethers.utils.parseUnits(n.toString(), "ether");
};

describe("Dappazon", () => {
  let dappazon;
  let deployer, buyer;
  beforeEach(async () => {
    //setup accounts
    [deployer, buyer] = await ethers.getSigners(); // we get the fake accounts from here there are about 20 in here
    console.log(deployer.address, buyer.address);
    // deploys the contract
    let Dappazon = await ethers.getContractFactory("Dappazon");
    dappazon = await Dappazon.deploy();
  });
  describe("Deployment", () => {
    it("has a name ", async () => {
      let Dappazon = await ethers.getContractFactory("Dappazon");
      let dappazon = await Dappazon.deploy();
      expect(await dappazon.name()).to.equal("Dappazon");
    });
  });
});
