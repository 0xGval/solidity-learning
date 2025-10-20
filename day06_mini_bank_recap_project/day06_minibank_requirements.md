# 💸 MiniBank – Project Requirements
---

## 🎯 Goal
Build a simple ETH bank smart contract where:
- Users can deposit and withdraw ETH safely.
- The contract owner can view the total balance.
- Each user’s balance is tracked individually.

---

## 🧱 Requirements

### 1. Contract Setup
- SPDX and pragma (`^0.8.18`)
- Contract name: `MiniBank`
- Create an **immutable** owner variable.
- Implement a modifier `onlyOwner()`.

---

### 2. Core Variables
- Mapping: `address => uint256 balances`
- Dynamic array: `address[] users`

---

### 3. Deposit Function
- `deposit()` is `public payable`.
- Require `msg.value > 0`.
- If first deposit → add address to `users`.
- Add deposited amount to mapping.

---

### 4. Withdraw Function
- `withdraw(uint256 _amount)` is `public`.
- Require balance ≥ requested amount.
- Deduct from mapping.
- Use `call()` to send ETH.
- Revert on failure.

---

### 5. Owner Function
- `getTotalBankBalance()` is `public view onlyOwner`.
- Returns `address(this).balance`.

---

### 6. Fallback & Receive
- Implement both to redirect to `deposit()`.
  ```solidity
  receive() external payable { deposit(); }
  fallback() external payable { deposit(); }
  ```

---

## 🧠 Optional Challenges
- Add `getUserCount()`.
- Add `getUserBalance(address _user)` (though public mapping covers it).
- Add events: `Deposit` and `Withdraw`.

---

## ✅ Success Conditions
- Deposits and withdrawals work properly.
- Balances update correctly.
- Owner-only access enforced.
- Direct ETH transfers handled via fallback/receive.
