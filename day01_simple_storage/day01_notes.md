# Day 1 – Simple Storage

---

## 🧠 Concepts Learned
- Solidity file structure: SPDX → pragma → contract  
- Basic types: `bool`, `uint` / `int`, `address`, `bytes`, `string`  
- State vs local variables & default values  
- Function visibility: `public`, `private`, `external`, `internal`  
- `view` (reads state) vs non-view (writes) vs `pure` (reads none)  
- Structs and dynamic arrays  
- `memory` keyword for strings in function parameters  

---

## 🔑 Key Snippet

```solidity
function addPerson(uint256 _favNumber, string memory _name) public {
    listOfPeople.push(Person(_favNumber, _name));
}
```

---

## 📝 Takeaways
- Writing to state costs gas; reading (`view`) does not when called externally.  
- Public state variables automatically create getter functions.  
- `bytes32("abc")` right-pads the string to 32 bytes.  
- Functions that modify state (like `store()`) need a transaction.  
- Solidity’s static typing enforces clarity on variable behavior.  
