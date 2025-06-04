
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.5.24;

---;
# 🔍 Solve the Vulnerabilities;
## 🚀 Vulnerability 1: Tx.origin Dependence Vulnerability;
;
### 💡 Exploit Scenario;
1. Mints a new `Inject` contract instance.;
2. Calls the `freeze(address account,uint key)` function with the `account` parameter set to `0x0000000000000000000000000000000000000000`.;
3. Calls the `freeze(address account,uint key)` function with the `account` parameter set to `0x0000000000000000000000000000000000000000` again.;
4. Triggers the `revert()` function in the `if (msg.sender != minter)` condition.;
5. Triggers the `freezeAccount[account] = key` function.;
### 💻 Solution;
;
## 🚀 Vulnerability 2: Permission Control Vulnerability;
### 💡 Exploit Scenario;
1. Mints a new `Inject` contract instance.;
2. Calls the `freeze(address account,uint key)` function with the `account` parameter set to `0x0000000000000000000000000000000000000000`.;
3. Triggers the `revert()` function in the `if (msg.sender != minter)` condition.;
4. Calls the `freeze(address account,uint key)` function again with the `account` parameter set to `0x0000000000000000000000000000000000000000`.;
### 💻 Solution;
;
## 🚀 Vulnerability 3: Payment/Incentive Logic Bypass Vulnerability;
### 💡 Exploit Scenario;
1. Mints a new `Inject` contract instance.;
2. Calls the `freeze(address account,uint key)` function with the `account` parameter set to `0x0000000000000000000000000000000000000000`.;
3. Triggers the `revert()` function in the `if (msg.sender != minter)` condition.;
4. Calls the `freeze(address account,uint key)` function again with the `account` parameter set to `0x0000000000000000000000000000000000000000`.;
5. Triggers the `revert()` function in the `if (msg.sender != minter)` condition again.;
### 💻 Solution;
;
## 🚀 Vulnerability 4: Double-Spent Data Vulnerability;
### 💡 Exploit Scenario;
1. Mints a new `Inject` contract instance.;
2. Calls the `freeze(address account,uint key)` function with the `account` parameter set to `0x0000000000000000000000000000000000000000`.;
3. Triggers the `revert()` function in the `if (msg.sender != minter)` condition.;
4. Calls the `freeze(address account,uint key)` function again with the `account` parameter set to `0x0000000000000000000000000000000000000000`.;
### 💻 Solution;
;
---;
## 🔗 Vulnerability 5: Double-Spent Data Vulnerability;
### 💡 Exploit Scenario;
1. Mints a new `Inject` contract instance.;
2. Calls the `freeze(address account,uint key)` function with the `account` parameter set to `0x0000000000000000000000000000000000000000`.;
3. Triggers the `revert()` function in the `if (msg.sender != minter)` condition.;
4. Calls the `freeze(address account,uint key)` function again with the `account` parameter set to `0x0000000000000000000000000000000000000000`.;
### 💻 Solution;
;
function changeAdmin() public {
    if (tx.origin == owner) {
        admin = msg.sender}
function grantAdminRole(address user) public {
    admins[user] = true}
function claimReward() public {
    if (!claimed[msg.sender]) {
        balances[msg.sender] += reward}
function commitData(bytes32 dataHash) public {
    require(dataRecord[dataHash] == 0);
    dataRecord[dataHash] = block.timestamp}