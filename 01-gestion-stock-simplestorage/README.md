# Gestion Stock Korbanas

A Solidity contract demonstrating core concepts from the Simple Storage section: 
struct, dynamic array, mapping, storage vs memory vs calldata, function visibility, 
and for loops — combined into a small stock management system for Korbanas 
(Fluxinnov's import/export trading name).

## Features

- Add a laptop to stock (auto-marked as available)
- Look up the price of a specific laptop by its position
- Mark a laptop as sold
- Count how many laptops are currently available
- Track the total historical count of each model added
- Check if a model was never stocked or is currently out of stock

## Security

Access control was added after initial review: `addLaptop` and `markLaptopSold` 
are now restricted to the contract owner via `require(msg.sender == owner, ...)`, 
set at deployment through the constructor. Read-only functions remain open to 
anyone.

## Known limitation

`enRupture` cannot distinguish a model that was never stocked from one that was 
stocked and sold out — both return `0` from the mapping, since Solidity mappings 
have no concept of a missing key.

## Deployment

Deployed on Sepolia testnet:
- Contract address: `0xE16aEeba3c8bEAb871737aD30e39bf6669d534c0`
- [View on Etherscan](https://sepolia.etherscan.io/address/0xE16aEeba3c8bEAb871737aD30e39bf6669d534c0)