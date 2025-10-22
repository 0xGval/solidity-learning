# 📋 Project Requirements – Allowance Wallet
---

## 🎯 Objective

Build a smart contract that functions as an **Allowance Wallet** where:
- Anyone can **deposit ETH**.
- The **owner** (deployer) can assign, modify, or revoke allowances for users.
- Users can **withdraw** up to their assigned allowance.
- The **owner** can withdraw any excess ETH (balance not allocated in allowances).

---

## 🧱 Core Features

### 1. Ownership
- Store the owner’s address as `immutable`.
- Create an `onlyOwner` modifier to restrict specific functions.

### 2. Deposits
- Public `deposit()` function (payable) for anyone to send ETH.
- Use `require()` to prevent zero-value deposits.

### 3. Allowance Management
- Use a mapping:  
  ```solidity
  mapping(address user => uint256 allowance)
  ```
- Functions for the owner:
  - `setAllowance(address _user, uint256 amount)` → sets initial allowance.  
  - `increaseAllowance(address _user, uint256 amount)` → adds to allowance.  
  - `reduceAllowance(address _user, uint256 amount)` → subtracts from allowance.  
  - `revokeAllowance(address _user)` → resets user allowance to zero.

- Keep track of all users in a dynamic array `address[] public users`.

### 4. Withdrawals
- `withdraw(uint256 amount)` for users:  
  - Must not exceed their current allowance.  
  - Must not exceed the contract’s available balance.  
  - Deduct the withdrawn amount from their allowance.  
  - Use low-level `call` for ETH transfer.

### 5. Owner-Only Excess Withdrawal
- Function `withdrawExcess()` to calculate:  
  ```solidity
  totalAllowances = sum of all user allowances
  excess = contract balance - totalAllowances
  ```
- Transfer the **excess** to the owner.

### 6. Safety & Fallbacks
- Disable direct ETH transfers using `receive()` and `fallback()`:
  ```solidity
  revert("Direct transfers not allowed");
  ```

---

## 🧠 Concepts Reinforced

- Ownership (`onlyOwner`, `immutable` variables)  
- Mappings for user → data relationships  
- Dynamic arrays for tracking active users  
- Loops and iteration with mappings and arrays  
- ETH transfer safety with `call`  
- Contract accounting (balance tracking + total reserved funds)  
- Proper use of `require()` for safety checks  
- Handling `receive()` and `fallback()` to control ETH flow  

---

## ✅ Bonus Ideas

If you want to extend this project:
- Add **events** for deposit, withdrawal, and allowance changes.  
- Add a **time lock** for allowances (like a mini vesting system).  
- Add **multi-owner** support using an array of authorized addresses.  
- Integrate **Chainlink price feeds** to handle USD-based limits.  

---

## 📦 Deliverables

- `AllowanceWallet.sol` → contract file  
- `day08_allowance_wallet_notes.md` → explanation & notes  
- `day08_allowance_wallet_requirements.md` → this file  
