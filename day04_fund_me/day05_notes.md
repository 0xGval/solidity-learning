# 💧 Day 5 – Funding, Withdrawals & Fallbacks
---

## 🧠 Concepts Learned

- **Constants and Immutables:**  
  - `constant` values are fixed at compile time (gas-efficient).  
  - `immutable` variables can be set only once inside the constructor.  
  Both are cheaper to read than normal storage variables.

- **Constructor:**  
  Runs only once when the contract is deployed.  
  Here we use it to set `i_owner` = the address that deployed the contract.

- **Modifiers (`onlyOwner`):**  
  A reusable way to restrict access to functions.  
  Instead of repeating the same `require`, we define it once and attach it to functions.

- **State tracking:**  
  - `funders` (array) stores all addresses that contributed.  
  - `mapping(address => uint256)` tracks how much each address funded.

- **Funding logic:**  
  - `fund()` is `public payable` → anyone can send ETH.  
  - `msg.value` gives the amount of wei sent with the transaction.  
  - `require()` enforces the minimum amount (1 ETH).  
  - Each funder’s address and contribution are recorded.

- **Withdraw logic:**  
  - Restricted with `onlyOwner`.  
  - Loops through all funders to reset their mapping entries.  
  - Resets the array and transfers the entire contract balance.  
  - Shows the three ETH-transfer methods:
    1. `transfer` (2300 gas, reverts on failure)  
    2. `send` (2300 gas, returns bool)  
    3. `call` – preferred (forwards all gas, returns bool + data)

- **Custom errors:**  
  More gas-efficient than long revert strings (e.g. `error SendFailed();`).

- **receive() and fallback():**  
  Handle ETH sent directly to the contract:  
  - `receive()` → runs when ETH is sent **with no data**  
  - `fallback()` → runs when ETH (or data) is sent but no matching function exists  
  Both redirect to `fund()` so every incoming payment is processed the same way.

---

## 🔑 Key Snippets

### Enforcing ownership
```solidity
modifier onlyOwner() {
    require(msg.sender == i_owner, "Sender is not owner");
    _;
}
```

### Recording funding
```solidity
function fund() public payable {
    require(msg.value >= MINIMUM_FUNDING, "Minimum contribution is 1 ETH!");
    funders.push(msg.sender);
    addressToAmountFunded[msg.sender] += msg.value;
}
```

### Resetting state and withdrawing
```solidity
function withdraw() public onlyOwner {
    for (uint256 i = 0; i < funders.length; i++) {
        address funder = funders[i];
        addressToAmountFunded[funder] = 0;
    }
    funders = new address[](0);
    (bool success, ) = payable(msg.sender).call{value: address(this).balance}("");
    require(success, "Call failed!");
}
```

### Handling direct ETH transfers
```solidity
receive() external payable {
    fund();
}

fallback() external payable {
    fund();
}
```

---

## 📝 Takeaways

- `constant` and `immutable` save gas and make code cleaner.  
- Use `onlyOwner` modifiers to protect critical functions.  
- Always reset mappings and arrays before withdrawals to avoid stale data.  
- Prefer `call` for ETH transfers (modern best practice).  
- `receive()` and `fallback()` guarantee that no ETH sent to the contract is lost.  
- Understanding revert behavior and gas forwarding is key for safe fund management.

---

## 🧩 Next Step Preview

Tomorrow (Day 6):  
Learn to write cleaner reusable logic with **libraries**, and explore how to handle ETH flow and conversions.
