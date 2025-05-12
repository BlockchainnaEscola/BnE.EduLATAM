// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import "forge-std/Test.sol";
import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

import "../src/CertificateNFTEduLATAM.sol";

contract CertificateNFTEduLATAMTest is Test {
    CertificateNFTEduLATAM private nft;
    address private owner = address(1);
    address private user = address(2);
    address private receiver = address(0xBEEF);

    function setUp() public {
        vm.prank(owner); // Simula que "owner" está chamando o construtor
        nft = new CertificateNFTEduLATAM("EduNFT", "EDU", owner);
    }

    function testMint() public {
        vm.prank(owner);
        nft.safeMint(user, 1, "ipfs://tokenURI");

        assertEq(nft.ownerOf(1), user);
        assertEq(nft.tokenURI(1), "ipfs://tokenURI");
    }

    function testBurn() public {
        vm.prank(owner);
        nft.safeMint(user, 3, "ipfs://tokenURI3");

        vm.prank(user);
        nft.burn(3);
        vm.expectRevert("ERC721: invalid token ID");
        nft.ownerOf(3);
    }

    function testSetTokenURI() public {
        vm.prank(owner);
        nft.safeMint(user, 2, "ipfs://tokenURI2");
        assertEq(nft.ownerOf(2), user);

        vm.prank(owner);
        nft.setTokenURI(2, "ipfs://tokenURI2New");
        assertNotEq(nft.tokenURI(2), "ipfs://tokenURI2");
        console.log(nft.tokenURI(2));
    }

    function testMintExists() public {
        vm.prank(owner);
        nft.safeMint(user, 2, "ipfs://tokenURI2");
        assertEq(nft.ownerOf(2), user);

        vm.prank(owner);
        vm.expectRevert("ERC721: token already minted");
        nft.safeMint(owner, 2, "ipfs://tokenURI2");
    }

    function testTransferNFT() public {
        vm.prank(owner);
        nft.safeMint(user, 1, "ipfs://tokenURI1");

        // Verifica se o dono original tem o NFT
        assertEq(nft.ownerOf(1), user);

        // Transfere o NFT para outro endereço
        vm.prank(user);
        nft.transferFrom(user, receiver, 1);

        // Verifica se o novo dono é o receiver
        assertEq(nft.ownerOf(1), receiver);
    }
}
