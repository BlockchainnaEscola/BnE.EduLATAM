// SPDX-License-Identifier: AGPL-3.0-only
// Compatible with OpenZeppelin Contracts ^5.0.0

/*                                                                                                                                                                                                     
𝕭𝖑𝖔𝖈𝖐𝖈𝖍𝖆𝖎𝖓 𝖓𝖆 𝕰𝖘𝖈𝖔𝖑𝖆                                                                                                        
.--.           .---.        .-.
.---|--|   .-.    | A |  .---. |~|    .--.
.--|===|BLOCKCHAIN|---|_|--.__| S |--|:::| |~|-==-|==|---.
|%%|NFT|WEB3      |===| |~~|%%| C |--|   |_|~|CATS|  |___|-.
|  |   |TOKEN     |===| |==|  | I |  |:::|=| |    |GB|---|=|
|  |   |SMART     |   |_|__|  | I |__|   | | |    |  |___| |
|~~|===|CONTRACT  |===|~|~~|%%|~~~|--|:::|=|~|----|==|---|=|
𝓦𝓞𝓛𝓕 ^--^---'--^---^-^--^--^---'--^---^-^-^-==-^--^---^-'
//ᏟᏒᎥᏢᏆᎾᎪᏆᎥᏉᎾs, ᏆᎾᏦᎬᏁᎥᏃᎪᎾ", ᎳᎬb3,smᎪᏒᏆ ᏟᎾᏁᏆᏒᎪᏟᏆs
*/

pragma solidity 0.8.18;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {ERC721Burnable} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import {ERC721URIStorage} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract CertificateNFTEduLATAM is ERC721, ERC721URIStorage, Ownable, ERC721Burnable {
    address public operator;

    event TransferOperator(address indexed oldOperator, address indexed newOperator);

    modifier onlyOperator() {
        require(msg.sender == operator, "Operator UNAUTHORIZED");
        _;
    }

    constructor(string memory name, string memory symbol, address initialOperator) ERC721(name, symbol) {
        require(initialOperator != address(0), "operator can't the zero address");
        operator = initialOperator;
    }

    function safeMint(address to, uint256 tokenId, string memory uri) external onlyOperator {
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
    }

    // The following functions are overrides required by Solidity.

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId) public view override(ERC721, ERC721URIStorage) returns (string memory) {
        return super.tokenURI(tokenId);
    }

    function setTokenURI(uint256 tokenId, string memory uri) external onlyOwner {
        _setTokenURI(tokenId, uri);
    }

    function supportsInterface(bytes4 interfaceId) public view override(ERC721, ERC721URIStorage) returns (bool) {
        return super.supportsInterface(interfaceId);
    }

    function getOperator() external view returns (address) {
        return operator;
    }

    function transferOperator(address newOperator) external onlyOwner {
        require(newOperator != address(0), "operator can't the zero address");
        emit TransferOperator(operator, newOperator);
        operator = newOperator;
    }
}
