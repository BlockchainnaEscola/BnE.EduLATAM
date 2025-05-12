# 📜 CertificateNFTEduLATAM - Smart Contract Documentation

> **Project:** BnE.EduLATAM

> **Motto:** *Edu.LATAM: Web3 for the Future*

> **Purpose:** NFT-based certification for Latin American education on-chain.

## 📑 Table of Contents

* [Introduction](#introduction)
* [Installation & Dependencies](#installation--dependencies)
* [Overview](#overview)
* [Main Functions](#main-functions)
* [Events](#events)
* [Modifiers](#modifiers)
* [Security Considerations](#security-considerations)
* [Interface Support](#interface-support)
* [License](#license)

---

## 🚀 Introduction

`CertificateNFTEduLATAM` is a Solidity smart contract designed to issue NFT-based educational certificates under the **BnE.EduLATAM** initiative. It utilizes the ERC-721 standard and enables an authorized operator to mint, assign metadata, and manage certificates securely.

This contract reflects the vision of *“Edu.LATAM: Web3 for the Future”* — bringing transparency, ownership, and verifiability to education in Latin America using blockchain.

---

## ⚙️ Installation & Dependencies

Ensure your environment uses **OpenZeppelin Contracts v5.0.0 or higher**.

Install using npm:

```bash
npm install @openzeppelin/contracts
```

---

## 🧩 Overview

* **Token Standard**: ERC-721 (NFT)
* **Features**:

  * **Burnable** NFTs
  * **URI Storage** per token
  * **Role-based access** via `Ownable` and `Operator`
* **Main Use Case**: Issuing personalized on-chain certificates such as:

  * `"Certificate: BnE.EduLATAM"`
  * `"Edu.LATAM: Web3 for the Future"`

---

## 🔧 Main Functions

### `constructor(string name, string symbol, address initialOperator)`

Initializes the contract with a token name and symbol. Assigns the first operator (who has minting rights).

---

### `safeMint(address to, uint256 tokenId, string memory uri)`

**Access**: `onlyOperator`
Mints a new NFT to `to` with a `tokenId` and metadata URI.

Used to issue certificates to students or participants.

---

### `setTokenURI(uint256 tokenId, string memory uri)`

**Access**: `onlyOwner`
Updates the metadata URI of an existing NFT.

Useful for correcting or updating certificate details.

---

### `getOperator() → address`

Returns the current operator address.

---

### `transferOperator(address newOperator)`

**Access**: `onlyOwner`
Transfers the operator role to a new address. Prevents setting to `address(0)`.

---

### `_burn(uint256 tokenId)`

Overrides base implementation to allow complete deletion of token and metadata.

---

### `tokenURI(uint256 tokenId) → string`

Returns the metadata URI for a given token.

---

### `supportsInterface(bytes4 interfaceId) → bool`

Returns whether the contract supports a specific interface (ERC721 & extensions).

---

## 📣 Events

### `TransferOperator(address indexed oldOperator, address indexed newOperator)`

Emitted when the operator role is transferred.

---

## 🔐 Modifiers

### `onlyOperator`

Restricts access to functions (like `safeMint`) to the current operator.

---

## 🔒 Security Considerations

* Only the `operator` can mint certificates — this role should be secured.
* Only the `owner` can:

  * Transfer operator rights
  * Update token URIs
* The contract prevents zero-address assignments for critical roles.
* Tokens can be irreversibly burned by any holder.

---

## 🧬 Interface Support

Fully compliant with:

* `ERC721`
* `ERC721URIStorage`
* `ERC721Burnable`
* `Ownable`

---

## 📄 License

This contract is licensed under the **AGPL-3.0-only** license.
See: [GNU Affero General Public License](https://www.gnu.org/licenses/agpl-3.0.html)

