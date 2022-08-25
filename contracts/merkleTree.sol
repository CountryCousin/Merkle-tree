// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";

contract MerkleTreeExample {


    // Calculated from `merkleTree.ts`
    bytes32 public rootHash =
        0xdf73116724cbd034759c0d3af1cb6e91abfc75d4f2ef4a023c6b38048708377c;

    mapping(address => bool) public hasClaimed;

    

    function whitelistMint(bytes32[] calldata _merkleProof) public {
        require(!hasClaimed[msg.sender], "Address already claimed");
        bytes32 childLeaf = keccak256(abi.encodePacked(msg.sender));
        require(
            MerkleProof.verify(_merkleProof, rootHash, childLeaf),
            "Invalid Merkle Proof."
        );
        hasClaimed[msg.sender] = true;
    }
}
