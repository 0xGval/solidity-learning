# ⏳ Day 7 – TimeLockedVault (Recap Project)

---

## 🧠 Goal
Build a contract where users can **deposit ETH** that becomes **locked for a certain period of time**.  
Users can only withdraw their funds **after the unlock time** has passed.  

This project reinforces:
- mappings & structs
- modifiers
- payable / msg.sender / msg.value
- receive() / fallback()
- require statements
- immutable owner variable
- block.timestamp logic

---

## 🧱 Contract Requirements

### 🔹 State Variables
- `i_owner` → immutable, set once in constructor (`msg.sender` on deploy)
- `mapping(address => Vault)` → maps each user to their vault info
- `struct Vault { uint256 amount; uint256 unlockTime; }` → stores each user's deposit and unlock time
- (Optional) a `users` array to keep track of all depositors

---

### 🔹 Constructor
- Sets `i_owner` to the deployer's address (`msg.sender`).

---

### 🔹 Modifiers
- `onlyOwner` → restricts certain functions to the contract owner  
  ```solidity
  require(msg.sender == i_owner, "Only owner can call this function");
  ```

---

### 🔹 Functions

#### 1️⃣ deposit(uint256 _lockDurationInSeconds)
- `payable` (user sends ETH along with this call)
- `require(msg.value > 0)` → no zero deposits
- `require(vault[msg.sender].amount == 0)` → user can only have one active vault
- store:
  - `amount = msg.value`
  - `unlockTime = block.timestamp + _lockDurationInSeconds`

#### 2️⃣ withdraw()
- `require(block.timestamp >= vault[msg.sender].unlockTime)` → ensure lock expired
- `require(vault[msg.sender].amount > 0)` → ensure funds exist
- transfer ETH to the user (`call` method)
- reset their vault (set amount = 0, unlockTime = 0)

#### 3️⃣ getUserVault(address _user) → view
- returns the user's deposit amount and unlock time

#### 4️⃣ getContractBalance() → view onlyOwner
- returns the total ETH stored in the contract

---

### 🔹 Special Functions
- `receive()` external payable → should call `revert("Use deposit()")`
- `fallback()` external payable → should call `revert("Invalid call")`

---

## ⚙️ Behavior Summary
- User deposits ETH with a chosen lock time.
- ETH stays locked until unlock time passes.
- User can withdraw after that period.
- Owner can view contract balance but not withdraw others’ funds.

---

## ✅ Example Flow
1. User A calls `deposit(60)` and sends 1 ETH. (Locked for 60 seconds)  
2. Before 60 seconds → `withdraw()` fails.  
3. After 60 seconds → `withdraw()` succeeds and sends 1 ETH back.  

---

## 🧩 Extra (Optional)
If you finish early, try adding:
- a way for users to check how much time is left before they can withdraw (`getTimeRemaining()`)
- or a simple `getUserCount()` if you keep an array of depositors.

---

**Everything here is 100% doable with what you’ve already learned.**
