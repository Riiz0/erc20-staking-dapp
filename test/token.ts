import { expect } from "chai";
import { ethers } from "hardhat";

describe("StakedToken", function () {
  it("should have the correct name and symbol", async function () {
    const StakedTokenFactory = await ethers.getContractFactory("StakedToken");
    const stakedToken = await StakedTokenFactory.deploy();
    await stakedToken.deployed();

    expect(await stakedToken.name()).to.equal("StakedToken");
    expect(await stakedToken.symbol()).to.equal("SKTK");
  });

  it("should allow the owner to mint tokens", async function () {
    const StakedTokenFactory = await ethers.getContractFactory("StakedToken");
    const stakedToken = await StakedTokenFactory.deploy();
    await stakedToken.deployed();

    const owner = await stakedToken.owner();

    await stakedToken.mint(owner, 100);
    const balance = await stakedToken.balanceOf(owner);
    expect(balance).to.equal(100);
  });

  it("should allow anyone to burn tokens", async function () {
    const StakedTokenFactory = await ethers.getContractFactory("StakedToken");
    const stakedToken = await StakedTokenFactory.deploy();
    await stakedToken.deployed();

    const owner = await stakedToken.owner();
    const burner = await ethers.getSigner("0x0000000000000000000000000000000000000000");

    await stakedToken.mint(owner, 100);

    await stakedToken.connect(burner).burn(owner, 50);

    const balance = await stakedToken.balanceOf(owner);

    expect(balance).to.equal(50);
  });
});
