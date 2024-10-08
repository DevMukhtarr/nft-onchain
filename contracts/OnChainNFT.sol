// contracts/onChainNFT.sol
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

/* 
    A library that provides a function for encoding some bytes in base64
    Source: https://github.com/zlayine/epic-game-buildspace/blob/master/contracts/libraries/Base64.sol
*/
import {Base64} from "./Base64.sol";

contract OnChainNFT is ERC721URIStorage {
    address public owner;
    uint256 public _tokenIds;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action.");
        _;
    }
    event Minted(uint256 tokenId);


    constructor() ERC721("NotBlankOnChain", "NOC") {
        owner = msg.sender;
        _tokenIds = 0;
    }

    /* Converts an SVG to Base64 string */
    function svgToImageURI(string memory svg)
        public
        pure
        returns (string memory)
    {
        string memory baseURL = "data:image/svg+xml;base64,";
        string memory svgBase64Encoded = Base64.encode(bytes(svg));
        return string(abi.encodePacked(baseURL, svgBase64Encoded));
    }

    /* Generates a tokenURI using Base64 string as the image */
    function formatTokenURI(string memory imageURI)
        public
        pure
        returns (string memory)
    {
        return
            string(
                abi.encodePacked(
                    "data:application/json;base64,",
                    Base64.encode(
                        bytes(
                            abi.encodePacked(
                                '{"name": "NotBlankOnChain", "description": "They are all not blank!", "image":"',
                                imageURI,
                                '"}'
                            )
                        )
                    )
                )
            );
    }

    /* Mints the token */
    function mint(string memory svg) public onlyOwner() {
        string memory imageURI = svgToImageURI(svg);
        string memory tokenURI = formatTokenURI(imageURI);

        _tokenIds++;
        uint256 newItemId = _tokenIds;

        _safeMint(msg.sender, newItemId);
        _setTokenURI(newItemId, tokenURI);

        emit Minted(newItemId);
    }
}