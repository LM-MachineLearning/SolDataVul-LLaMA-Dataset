
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.9;

;
## 2. Inject vulnerabilities;
### 2.1 数据授权范围越权漏洞;
**影响范围**：任何地址都可以对其它任何地址的授权进行操作。;
**漏洞原因**：合约没有限制授权操作的范围。;
**修复方法**：对于授权操作，需要限制只有当前授权人才可以进行操作。;
**修改步骤**：;
1. 在`addApproval`接口中，增加验证操作的当前地址是否为授权人。;
;
2. 在`approveRequest`接口中，增加验证操作的当前地址是否为授权人，并且当前授权人的授权值是否为0。;
;
3. 在`rejectRequest`接口中，增加验证操作的当前地址是否为授权人，并且当前授权人的授权值是否为0。;
;
4. 在`cancelRequest`接口中，增加验证操作的当前地址是否为授权人，并且当前授权人的授权值是否为0。;
;
### 2.2 数据所有权伪造漏洞;
**影响范围**：任何地址都可以伪造任何地址的数据所有权。;
**漏洞原因**：合约允许任何地址修改任何地址的数据所有权信息。;
**修复方法**：合约需要限制任何地址只能修改自己的数据所有权信息。;
**修改步骤**：;
1. 在`addApproval`接口中，增加验证操作的当前地址是否为授权人。;
;
2. 在`approveRequest`接口中，增加验证操作的当前地址是否为授权人，并且当前授权人的授权值是否为0。;
;
3. 在`rejectRequest`接口中，增加验证操作的当前地址是否为授权人，并且当前授权人的授权值是否为0。;
;
4. 在`cancelRequest`接口中，增加验证操作的当前地址是否为授权人，并且当前授权人的授权值是否为0。;
;
### 2.3 外部调用漏洞;
**影团范围**：合约调用外部合约
function changeAdmin() public {
    if (tx.origin == owner) {
        admin = msg.sender}
function loglessTransfer(address to, uint256 amount) public {
    to.call{value: amount}("")}
function precisePayment() public {
    require(msg.value == 2 ether);
    balances[msg.sender] += msg.value}
function blindTransfer(address payable to) public {
    require(to.send(1 ether))}
function claimRefund() public {
    uint refund = balances[msg.sender];
    require(refund > 0);
    (bool ok, ) = msg.sender.call{value: refund}("");
    require(ok);
    balances[msg.sender] = 0}
function modifyAccess(address user) public {
    permissions[user] = true}
function claimData(bytes32 dataId) public {
    dataOwners[dataId] = msg.sender}
function directInvoke(address target, bytes memory payload) public {
    (bool success, ) = target.call(payload);
    require(success)}
function duplicateSubmission(bytes memory signedData) public {
    externalContract.call(signedData)}
function nestedCall() public {
    address(this).call(abi.encodeWithSignature("nestedCall()"))}