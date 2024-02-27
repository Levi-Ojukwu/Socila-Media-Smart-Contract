// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Base64.sol";

// import "@openzeppelin/contracts/access/AccessControl.sol";

contract NftToken is ERC721URIStorage {
    uint256 private _nextTokenId;

    event NFTCreated(
        address indexed creator,
        uint256 indexed tokenId,
        string uri
    );

    constructor(
        string memory _tokenName,
        string memory _tokenSymbol
    ) ERC721("LeviToken", "LITO") {}

    function createNFT(
        address recipient,
        string memory _tokenURI
    ) external returns (uint256) {
        uint256 tokenId = _nextTokenId++;

        _safeMint(recipient, tokenId);

        emit NFTCreated(msg.sender, tokenId, _tokenURI);

        return tokenId;
    }
} 