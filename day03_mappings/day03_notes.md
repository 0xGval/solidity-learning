# 🧱 Day 3 – Mappings  
---

## 🧠 Concepts Learned

- **Mappings:**  
  A mapping is like a key → value dictionary in Solidity.  
  It allows instant data lookup without looping through arrays.  
  Example:  
  ```solidity
  mapping(string => uint256) public nameToFavNumber;
  ```
  This links each name to a favorite number (`"John" → 7`).

- **Why use mappings:**  
  - Arrays require looping to find specific entries.  
  - Mappings give direct access to data by key, saving gas and time.  
  - Mappings are great for lookups but cannot be iterated or return a full list of keys.

- **Integration with structs and arrays:**  
  You can still keep an array of `Person` structs for indexing or listing,  
  and a mapping for quick key-based access.

- **Auto-generated getters:**  
  Public mappings automatically get a getter function —  
  you can call `nameToFavNumber("John")` directly to get the value.

---

## 🔑 Key Code Snippets

### Creating and Updating a Mapping
```solidity
mapping(string => uint256) public nameToFavNumber;

function addPersonToMapping(string memory _name, uint256 _favNumber) public {
    nameToFavNumber[_name] = _favNumber;
}
```
Stores a person’s name as the key and their favorite number as the value.  
Anyone can call this function to add or update entries.

---

### Combining with Structs
```solidity
struct Person {
    uint256 favNumber;
    string name;
}

Person[] public listOfPeople;

function addPerson(uint256 _favNumber, string memory _name) public {
    listOfPeople.push(Person(_favNumber, _name));
    nameToFavNumber[_name] = _favNumber;
}
```
The array keeps all `Person` objects,  
while the mapping provides quick lookups by name.

---

## 📝 Takeaways

- **Mapping = key → value store** (no loops, direct lookup).  
- **Not iterable** — you can’t list all keys or values directly.  
- **Cheaper than arrays** for lookups, especially as data grows.  
- **Mappings + structs** work great together: array = records, mapping = fast access.  
- Data written to mappings is stored in `storage` (on-chain and permanent).

---

## 🧩 Next Step Preview

Tomorrow (Day 4): learn **visibility, modifiers, and gas optimization**.  
You’ll start combining these concepts to structure more advanced contracts.
