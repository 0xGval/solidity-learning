# 🔒 Day 7 – TimeLockedVault (Recap Project)
---

## 🧠 Concepts Learned

- **Structs** can hold multiple related variables (like `amount` and `unlockTime` in a single record).  
- **Mappings** are used to link each user’s address to their individual vault.  
- **Modifiers** like `onlyOwner` let you restrict access and reuse logic cleanly.  
- **Immutable & constant variables** are cheaper and safer once assigned (gas optimization).  
- **Timestamps (`block.timestamp`)** can be used to enforce time-based logic.  
- **`receive()` and `fallback()`** allow controlling how the contract reacts to direct ETH transfers or invalid calls.  
- **`call` method** is used to safely send ETH and check if the transaction succeeded.  
- **State cleanup:** resetting mappings after withdrawals prevents re-entrancy and double-withdrawals.  

---

## 🔑 Key Code Snippets

### Deposit funds with time lock
```solidity
function deposit (uint256 _lockDurationInSeconds) public payable {
    require(msg.value > 0, "You can't deposit 0 ETH");
    require(AddressToVault[msg.sender].amount == 0, "You already have a vault");

    Users.push(msg.sender);

    AddressToVault[msg.sender] = Vault({
        amount: msg.value,
        unlockTime: block.timestamp + _lockDurationInSeconds
    });
}
```
➡️ Creates a vault for the sender that stores how much ETH was sent and when it can be withdrawn.

---

### Withdraw after unlock time
```solidity
function withdraw () public {
    require(block.timestamp > AddressToVault[msg.sender].unlockTime, "You can't withdraw yet");
    require(AddressToVault[msg.sender].amount > 0, "You don't have a vault");

    (bool success, ) = payable(msg.sender).call{value: AddressToVault[msg.sender].amount}("");
    require(success, "Failed to send ETH");

    AddressToVault[msg.sender] = Vault(0, 0);
}
```
➡️ Withdraws ETH only after the lock expires and resets the vault to avoid reusing it.

---

### Get user data and contract balance
```solidity
function getUserVault(address _user) public view returns (Vault memory) {
    return AddressToVault[_user];
}

function getContractBalance() public view onlyOwner returns (uint256) {
    return address(this).balance;
}
```
➡️ Owner can view total balance, and any user can check their own vault info.

---

### Prevent direct transfers
```solidity
receive() external payable {
    revert("You can't send ETH directly to this contract. Use the deposit function");
}

fallback() external payable {
    revert("Invalid call");
}
```
➡️ Forces users to interact only through `deposit()` — improves clarity and prevents mistakes.

---

## 📝 Takeaways

- `block.timestamp` lets contracts track time in seconds.  
- You can store complex data for each address using structs and mappings.  
- Using `immutable` and `constant` saves gas and protects values from changes.  
- Always reset state after sending ETH — never leave funds “marked” as stored.  
- Writing clear error messages in `require` helps debugging and user understanding.  
- Fallback and receive functions ensure ETH isn’t sent incorrectly.  

---

## 🧩 Notes

This project was **not part of the Cyfrin course**, but an **independent recap build**.  
It combines everything learned so far — storage, mappings, modifiers, payable functions, and timestamps —  
into a small real-world system: a **time-locked ETH vault**.

---

**Next:** we’ll start exploring **Solidity libraries** before moving to **Foundry development**.
