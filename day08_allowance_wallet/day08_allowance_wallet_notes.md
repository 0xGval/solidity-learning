# 💰 Day 8 – Allowance Wallet
---

## 🧠 Concepts Learned

- **Allowance system:**  
  built a wallet that lets the **owner** assign how much ETH each user can withdraw.  
  users can only withdraw up to their allowance — no more.  

- **Mappings & ownership logic:**  
  - used `mapping(address => uint256)` to track allowances per user.  
  - `onlyOwner` modifier restricts certain functions (like setting or revoking allowances).  
  - owner is stored as `immutable` for gas efficiency.  

- **Dynamic user tracking:**  
  each time an allowance is assigned for a new user, their address is added to an array.  
  this makes it possible to track all users and calculate total assigned funds.  

- **Excess balance withdrawal:**  
  the owner can withdraw any ETH not reserved by user allowances  
  (the “excess” balance left inside the contract).  

- **Deposit & Withdraw flow:**  
  - `deposit()` is public & payable → anyone can fund the wallet.  
  - `withdraw(amount)` lets users withdraw within their limit.  
  - all checks ensure there’s no overdraft or 0-value transactions.  

- **Revert safety:**  
  `receive()` and `fallback()` reject direct ETH transfers to make sure all deposits go through the proper `deposit()` function.  

---

## 🔑 Key Code Snippets

### Setting a user allowance
```solidity
function setAllowance(address _user, uint256 amount) public onlyOwner {
    require(amount <= address(this).balance, "Not enough balance");
    if (allowances[_user] == 0) users.push(_user);
    allowances[_user] = amount;
}
```
- ensures the contract has enough balance before assigning funds.  
- new users are added to the array only once.  

---

### Withdrawing funds
```solidity
function withdraw(uint256 amount) public {
    require(amount > 0, "You can't withdraw 0");
    require(allowances[msg.sender] >= amount, "Not enough allowance!");
    require(amount <= address(this).balance, "Contract does not have enough balance");

    allowances[msg.sender] -= amount;
    (bool callSuccess, ) = payable(msg.sender).call{value: amount}("");
    require(callSuccess, "Call failed!");
}
```
- checks allowance, balance, and ensures call success.  
- safe ETH transfer pattern using low-level `call`.  

---

### Owner withdrawing excess funds
```solidity
function withdrawExcess() public onlyOwner {
    uint256 totalAllowances;
    for (uint256 i = 0; i < users.length; i++) {
        totalAllowances += allowances[users[i]];
    }
    uint256 excess = address(this).balance - totalAllowances;
    payable(i_owner).transfer(excess);
}
```
- loops through all users to calculate total reserved funds.  
- allows owner to withdraw the leftover balance.  

---

## 📝 Takeaways

- **Mappings** are perfect for tracking relationships like user → balance or user → allowance.  
- **Modifiers** simplify access control and improve readability.  
- **require()** checks are essential to prevent misuse and protect funds.  
- Using **call** for ETH transfers is safer than `transfer()` or `send()`.  
- Keeping **receive()** and **fallback()** restrictive improves contract safety.  

---

## 🧩 Next Step Preview

Tomorrow (Day 9): practice **events and logging**, so contracts can emit information about deposits, withdrawals, and allowance changes —  
crucial for transparency and DApp frontends.
