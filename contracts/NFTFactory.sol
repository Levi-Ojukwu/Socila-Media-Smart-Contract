// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "./NFTToken.sol";
contract NFTFactory {
    NftToken[] NftTokenClones;

    function createNFTToken(
        string memory _tokenName,
        string memory _tokenSymbol
    ) external {
        NftToken newNftToken_ = new NftToken(_tokenName, _tokenSymbol);

        NftTokenClones.push(newNftToken_);
    }
}

