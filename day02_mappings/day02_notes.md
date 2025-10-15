# 🧱 Day 2 – Memory, Calldata & Storage
---

## 🧠 Concepts Learned

- **EVM data locations:**  
  Solidity variables can live in different areas of the Ethereum Virtual Machine.  
  - **Storage** – permanent, lives on-chain, expensive to write.  
  - **Memory** – temporary, cleared after function execution, editable.  
  - **Calldata** – temporary, read-only, used for external function inputs.  
- **Default behavior:**  
  - Variables declared *outside* functions → `storage`.  
  - Variables declared *inside* functions → `memory` (by default for value types).  
  - For dynamic types like `string` or `bytes`, the data location must be specified.  
- **Mutability difference:**  
  - `memory` data can be changed inside the function.  
  - `calldata` is immutable (read-only) but cheaper since no copy is made.  
- **Storage costs:**  
  - Writing to `storage` costs gas and persists on the blockchain.  
  - Reading from `view` functions is free when called off-chain.  
- **Structs and arrays review:**  
  Still using the `Person` struct and dynamic array to see how data moves between memory and storage.  

---

## 🔑 Key Code Snippets

### Using `memory`
```solidity
function addPerson(uint256 _favNumber, string memory _name) public {
    listOfPeople.push(Person(_favNumber, _name));
}
```
The string `_name` is copied into temporary memory.  
It can be modified inside the function and is then written to `storage` when pushed into `listOfPeople`.

---

### Using `calldata`
```solidity
function addPersonWithCalldata(uint256 _favNumber, string calldata _name) public {
    listOfPeople.push(Person(_favNumber, _name));
}
```
`_name` is read directly from the transaction input without copying into memory.  
It’s immutable (read-only) but saves gas when passing large strings or arrays.

---

## 📝 Takeaways

- `storage` = permanent on-chain data → expensive to write.  
- `memory` = temporary workspace inside a function → editable and reset after execution.  
- `calldata` = temporary input data → read-only and cheap to use for function parameters.  
- Functions can access and move data between these locations depending on keywords used.  
- Understanding where data lives is essential for gas optimization and security.  

---

## 🧩 Next Step Preview

Tomorrow (Day 3): learn **mappings** — Solidity’s key-value storage structure.  
You’ll extend the `Person` example to map a person’s name to their favorite number.
