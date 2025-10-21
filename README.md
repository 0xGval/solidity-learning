# Solidity Learning Repository

This repository documents my progress learning **Solidity** and smart contract development.  
Each folder corresponds to a topic or day of study, containing `.sol` contracts and concise notes.

I’m following the **“Learn Solidity Smart Contract Development | Full 2024 Cyfrin Updraft Course”** by **Patrick Collins**, adapting the lessons and explanations in my own words.  
Some projects (like *MiniBank* and *TimeLockedVault*) are self-made recap exercises to reinforce concepts.

---

## Structure

| Folder | Description |
|---------|--------------|
| [day01_simple_storage](day01_simple_storage/) | Basic Solidity syntax, variables, functions, structs, arrays |
| [day02_data_locations](day02_data_locations/) | Memory vs Calldata vs Storage – how Solidity handles data in the EVM |
| [day03_mappings](day03_mappings/) | Key → Value data structures for efficient lookups and data access |
| [day04_factory](day04_factory/) | Deploying and interacting with multiple contracts using the Factory pattern |
| [day05_fundme_fallbacks](day05_fundme_fallbacks/) | Funding logic, withdraw patterns, ownership, and handling direct ETH transfers |
| [day06_minibank](day06_minibank/) | 🏦 **MiniBank recap project** – deposits, withdrawals, mappings, modifiers, and fallback/receive |
| [day07_timelocked_vault](day07_timelocked_vault/) | ⏳ **TimeLockedVault recap project** – user vaults with time-based locks, struct + mapping patterns, and safe ETH withdrawals |

---

## Tools

- **Solidity** `^0.8.x`
- **Remix IDE** – for compiling and testing contracts quickly
- **Hardhat** – for local development (coming soon)
- **Ethers.js** – for interaction examples (future)
- **OpenZeppelin** – for contract templates and security patterns

---

## Notes

- Each folder contains a `notes.md` summarizing what was learned.  
- Contracts are written for clarity and explanation, not production use.  
- Some lessons are direct from the Cyfrin Updraft course; others are personal recap projects.  
- This repo is primarily for **learning, experimentation, and documenting progress**.

---

## License  

MIT License
