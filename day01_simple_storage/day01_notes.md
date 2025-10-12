# 🧱 Day 1 – Simple Storage

---

## 🧠 Concepts Learned

- **Solidity file structure:** every contract starts with an SPDX license → a pragma version → then the contract definition.  
- **Basic types:**  
  - `bool` – true/false values  
  - `uint` / `int` – unsigned and signed integers  
  - `address` – stores Ethereum addresses (20 bytes)  
  - `bytes` / `bytes32` – fixed or dynamic byte arrays  
  - `string` – UTF-8 encoded text  
- **State vs. local variables:**  
  - *State* variables are stored permanently on-chain (cost gas to change).  
  - *Local* variables exist temporarily in function memory.  
- **Function visibility:** `public`, `private`, `external`, `internal` — controls where a function or variable can be accessed.  
- **Function types:**  
  - `view` – reads blockchain state, doesn’t modify it.  
  - `pure` – performs logic without even reading state.  
  - *No keyword* – modifies state and costs gas.  
- **Data structures:** arrays, structs, and how to combine them to store complex data.  
- **Memory keyword:** required for strings and other reference types passed to functions (e.g., `string memory _name`).  

---

## 🔑 Key Code Snippet

```solidity
function addPerson(uint256 _favNumber, string memory _name) public {
    listOfPeople.push(Person(_favNumber, _name));
}
```

➡️ Creates a new `Person` struct and adds it to the `listOfPeople` array.  
Because `listOfPeople` is `public`, Solidity automatically generates a getter, so you can retrieve any entry by its index.

---

## 📝 Takeaways

- Writing to the blockchain (changing state) **costs gas**; reading (`view`) does **not** when called externally.  
- Public state variables automatically have **getter functions** created by the compiler.  
- `bytes32("abc")` stores the 3-byte string `"abc"` padded to 32 bytes.  
- Functions that modify state, like `store()`, require a **transaction** and can be called by anyone if marked `public`.  
- Solidity’s **static typing** enforces explicit variable types, improving safety and readability.  
- Smart contracts are deterministic — every operation’s cost and effect can be predicted exactly.  

---

## 🧩 Next Step Preview

Tomorrow (Day 2): learn **Data Locations** — Where data are stored: Storage, Memory and Calldata.

