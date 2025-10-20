# 🏦 Day 6 – MiniBank (Recap Project)
---

## 📚 Context
This project is **outside the Cyfrin Updraft course** — a recap project I built from scratch  
to reinforce everything I’ve learned so far in Solidity.

It combines concepts from:
- `FundMe` (payable functions, ownership, withdraw pattern)
- `Mappings` and `Arrays` (data storage and iteration)
- `Fallback` and `Receive` (handling direct ETH transfers)
- Modifiers and state variables (`immutable`, `constant`)

---

## 🧠 Concepts Reviewed

- **Ownership and access control:**  
  Used an `immutable` owner variable and an `onlyOwner` modifier to restrict sensitive functions.

- **Mappings and dynamic arrays:**  
  Combined to track each depositor’s balance and keep a record of all unique users.

- **Payable functions:**  
  Both `deposit()` and `withdraw()` are connected to real ETH transfers.

- **receive() and fallback():**  
  Handle ETH sent directly to the contract (with or without data) by redirecting to `deposit()`.

- **Contract balance visibility:**  
  The owner can check total holdings using `getTotalBankBalance()`.

---

## 🔑 Key Code Snippets

### Deposit ETH
```solidity
function deposit() public payable {
    require(msg.value > 0, "You can't deposit 0 ETH");

    if (balances[msg.sender] == 0) {
        balances[msg.sender] = msg.value;
        users.push(msg.sender);
    } else {
        balances[msg.sender] += msg.value;
    }
}
```
➡️ Allows anyone to send ETH and keeps track of their total deposited balance.

---

### Withdraw ETH
```solidity
function withdraw(uint256 amount) public {
    require(amount <= balances[msg.sender], "You can't withdraw more than you have");
    balances[msg.sender] -= amount;
    (bool callSuccess, ) = payable(msg.sender).call{value: amount}("");
    require(callSuccess, "Failed to send ETH");
}
```
➡️ Safely lets users withdraw part or all of their balance using the `call` method.

---

### View Functions
```solidity
function getTotalBankBalance() public view onlyOwner returns (uint256) {
    return address(this).balance;
}
```
➡️ Allows only the owner to check the total ETH stored in the contract.

---

## 📝 Takeaways
- This project helped reinforce all the Solidity fundamentals I’ve studied so far.  
- Writing from scratch without a tutorial showed what I truly understood.  
- Key skill improvement: **mapping + payable logic + withdraw pattern**.  
- This pattern (deposit / withdraw / mapping) is used heavily in DeFi vaults and staking contracts.

---

## 🧩 Next Step Preview
Next, I’ll return to the Cyfrin Updraft course and continue from the Chainlink & price feed section.
