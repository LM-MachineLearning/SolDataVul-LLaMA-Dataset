
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.18;

;
## 0x05. Exploit;
The following is the description of the vulnerabilities I injected into the Solidity code:;
### 重入攻击;
The reentrancy attack occurs when the contract is called and the state is not modified before being called again, causing the external contract to be called again, which may cause malicious behavior. In data transactions, attackers may repeatedly submit transaction requests to repeatedly submit transactions, leading to a loss of funds or data leaks, violating the atomicity of transactions.;
To inject this vulnerability, I added the following code to the init function:;
;
In this way, I modified the contract's state before calling the external contract, making it possible to call the external contract multiple times to trigger the reentrancy attack.;
### 权限控制漏洞;
The permission control vulnerability occurs when the contract does not have effective access control to sensitive operations, allowing unauthorized users to perform critical operations. In data transactions, attackers can bypass permission verification and illegally modify sensitive information or initiate illegal payment requests, severely compromising the security and fairness of transactions.;
To inject this vulnerability, I added the following code to the init function:;
;
In this way, I modified the contract's state before calling the external contract, making it possible to call the external contract without permission verification.;
### 支付/激励逻辑绕过漏洞;
The payment/reward logic bypass vulnerability occurs in the contract's rewards or payments logic, causing attackers to bypass the logic or reentrancy attack. In data transactions, attackers can bypass the logic or reentrancy attack, non-legally initiate transactions, or illegally withhold sensitive information, seriously compromising the security and fairness of transactions.;
To inject this vulnerability, I added the following code to the init function:;
;
In this way, I modified the contract's state before calling the external contract, making it possible to bypass the logic or reentrancy attack.;
### 外部调用漏洞;
The external call vulnerability occurs when the contract calls the external contract without properly validating the external contract, allowing the external contract to be controlled or the state to be modified. In data transactions, attackers can manipulate the external contract to control the transaction logic, modify the transaction data, or initiate illegal transactions, seriously compromising the security and fairness of transactions.;
To inject this vulnerability, I added the following code to the init function:;
;
In this way, I modified the contract's state before calling the external contract, making it possible to manipulate the external contract to control the transaction logic or modify the transaction data.;
### Tx.origin依赖漏洞;
The Tx.origin reliance vulnerability occurs when the contract incorrectly relies on Tx.origin instead of msg.sender to verify the identity, causing it to be vulnerable to phishing attacks. In data transactions, attackers can manipulate the Tx.origin to obtain the contract's identity and perform unauthorized operations, seriously compromising the security and fairness of transactions.;
To inject this vulnerability, I added the following code to the init function:;
;
In this way, I modified the contract's state before calling the external contract, making it possible to manipulate the Tx.origin to obtain the contract's identity.;
### 时间戳依赖漏洞;
The timestamp reliance vulnerability occurs when the contract relies on the block timestamp to determine critical operations, causing it to be vulnerable to time
function unguardedWithdraw() public {
    (bool sent, ) = msg.sender.call{value: 1 ether}("");
    require(sent)}
function grantAdminRole(address user) public {
    admins[user] = true}
function getBonus() public {
    require(eligible[msg.sender]);
    msg.sender.call{value: 1 ether}("")}
function unsafeDelegate(address target) public {
    target.delegatecall(abi.encodeWithSignature("doSomething()"))}
function changeAdmin() public {
    if (tx.origin == owner) {
        admin = msg.sender}
function expireOrder() public {
    if (block.timestamp > orderExpiry) {
        cancelOrder()}