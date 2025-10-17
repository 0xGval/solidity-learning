# 🏗️ Day 4 – Contract Factory
---

## 🧠 Concepts Learned

- **Composable smart contracts:**  
  Contracts can create and interact with other contracts directly on-chain.  
  They do this permissionlessly – any contract can deploy or call another contract if it knows:
  1. The **address** (where it lives), and  
  2. The **ABI** (what functions it exposes).

- **Factory pattern:**  
  A *factory* contract is a contract that **deploys new contracts** of another type and keeps track of them.  
  This is one of the most common patterns in DeFi (used in Uniswap, NFT launchers, vault systems, etc.).

- **Using `import`:**  
  You can bring code from another file into the current one:
  ```solidity
  import "./SimpleStorage.sol";
  ```
  or selectively:
  ```solidity
  import {SimpleStorage, SimpleStorage2} from "./SimpleStorage.sol";
  ```

---

## 🔑 Key Code Snippets

### Deploying a new contract
```solidity
SimpleStorage public simpleStorage;

function createStorageContract() public {
    simpleStorage = new SimpleStorage();
}
```
`new` deploys a fresh contract of type `SimpleStorage`.  
The variable `simpleStorage` stores its address so we can interact with it later.

---

### Deploying many contracts
```solidity
SimpleStorage[] public simpleStorageArray;

function createStorageInArray() public {
    simpleStorageArray.push(new SimpleStorage());
}
```
Each time this function runs, it deploys a new `SimpleStorage` and adds it to the array.

---

### Interacting with a specific deployed contract
```solidity
function sfStore(uint256 _index, uint256 _newNumber) public {
    /*
    To interact with another contract we need:
    1. Its address  → stored in simpleStorageArray[_index]
    2. Its ABI      → imported from SimpleStorage
    */
    SimpleStorage mySimpleStorage = simpleStorageArray[_index];
    mySimpleStorage.store(_newNumber);
}
```
- Retrieves the chosen `SimpleStorage` contract from the array.  
- Calls its `store()` function to update the stored number.

---

### Reading from a deployed contract
```solidity
function sfRetrieve(uint256 _index) public view returns (uint256) {
    return simpleStorageArray[_index].retrieve();
}
```
- Reads data directly from the selected contract.  
- Because it’s `view`, no gas is spent if called off-chain.

---

## 📝 Takeaways

- A **factory contract** can deploy and manage multiple other contracts of the same type.  
- The keyword `new` creates a new on-chain contract instance.  
- Arrays (or mappings) can store references to those contracts’ addresses.  
- Once you have an address and the ABI, you can call any public function of that contract.  
- This is the foundation for scalable DeFi systems like liquidity-pair factories, multi-vault managers, and NFT collection launchers.

---

## 🧩 Next Step Preview

Tomorrow (Day 5): learn how to **pass constructor arguments** when deploying contracts from a factory, and how to emit **events** to track deployments on-chain.
