// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract NFT_Collection is ERC721Enumerable, ReentrancyGuard {
    uint256 public tokenCounter;
    address public contractOwner;
    mapping (uint256 => string) private _tokenURIs;
    mapping (address => bool) public approved;
    address[] public signers;

    modifier isOwner(address caller) {
        require(caller == contractOwner);
        _;
    }

    modifier isApproved() {
        require(approved[msg.sender] || msg.sender == contractOwner);
        _;
    }

    event Minted(address owner, string uri, uint256 tokenID);
    event Burned(uint256 tokenID);

    constructor(string memory name, string memory symbol) ERC721(name, symbol) {
        tokenCounter = 0;
        contractOwner = msg.sender;
    }
//please note that _beforeTokenTransfer accepts now 4 params, the last one is batchSize, if minting 1 nft at a time
//it can be 1
    function mintFor(address recipient, string memory _tokenURI) public nonReentrant isApproved {
        uint256 tokenId = tokenCounter;
         _beforeTokenTransfer(address(0), recipient, tokenId,1);
        _safeMint(recipient, tokenId);
        _setTokenURI(tokenId, _tokenURI);
        tokenCounter++;
        emit Minted(recipient, _tokenURI, tokenId);
    }

    function burnFor(uint256 tokenId) public nonReentrant isApproved {
        _burn(tokenId);
        tokenCounter--;
        emit Burned(tokenId);
    }

    function _setTokenURI(uint256 _tokenId, string memory _tokenURI) internal virtual {
        require(_exists(_tokenId), "ERC721Metadata: URI set of nonexistent token");
        _tokenURIs[_tokenId] = _tokenURI;
    }

    function addSigner(address new_signer) public nonReentrant isApproved {
        require(!isSignerExists(new_signer), "Signer to be added exists");
        signers.push(new_signer);
        approved[new_signer] = true;
    }

    function isSignerExists(address new_signer) internal view returns(bool) {
        uint length_signers = signers.length;
        for (uint i = 0; i < length_signers; i++) {
            if (signers[i] == new_signer) {
                return true;
            }
        }
        return false;
    }

    function delSigner(address ex_approver) public nonReentrant isOwner(msg.sender) {
        require(ex_approver != contractOwner, "Contract owner cannot be removed");
        require(signers.length > 0, "No signer added");
        require(isSignerExists(ex_approver), "Signer to be deleted non-exists");

        uint length_signers = signers.length;
        address[] memory new_array = new address[](length_signers-1);

        for (uint i = 0; i < length_signers; i++) {
            if (signers[i] != ex_approver) {
                new_array[i] = signers[i];
            } else {
                approved[signers[i]] = false;
            }
        }
        signers = new_array;
    }

    function tokenURI(uint256 _tokenId) public view virtual override returns(string memory) {
        require(_exists(_tokenId), "ERC721Metadata: URI set of nonexistent token");
        return _tokenURIs[_tokenId];
    }
}
