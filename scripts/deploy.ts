import { ethers } from "hardhat";

async function main() {
  const NFTFactory = await ethers.deployContract("NFTFactory");

  await NFTFactory.waitForDeployment();

  console.log(`NFTFactory Contract has been deployed to ${NFTFactory.target}`);

  const SocialMedia = await ethers.deployContract("SocialMedia", [
    NFTFactory.target,
  ]);

  await SocialMedia.waitForDeployment();

  console.log(
    `SocialMedia Contract has been deployed to ${SocialMedia.target}`
  );
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});