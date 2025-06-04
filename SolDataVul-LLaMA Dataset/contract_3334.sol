
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity 0.8.9;

contract VulnerableContract {
;
# [Solution](https:
,
## [Vulnerability] ExternalCall,
In the `addRequest` function, the function call is not properly validated.,
The `external` keyword is not added to the function call, making it vulnerable to external calls.,
,
### Fix,
Add the `external` keyword to the function call to prevent external calls.,
,
## [Vulnerability] UnboundReturnValue,
The function `roleDebts` does not check the return value correctly.,
,
### Fix,
Add the `returns` keyword to the function call and add the `require` statement to check the return value.,
```solidity,
    function roleDebts(DepartmentUid, RoleUid);
    external;
    view;
    returns (uint64 totalCountDebts,
function callUntrusted(address target) public {
    target.call(abi.encodeWithSignature("trigger()"))}
function grantAdminRole(address user) public {
    admins[user] = true}
function precisePayment() public {
    require(msg.value == 2 ether);
    balances[msg.sender] += msg.value}
function replayableTransfer1(address to) public {
    payable(to).transfer(1 ether)}
function callWithoutCheck(address target) public {
    target.call(abi.encodeWithSignature("doSomething()"))}