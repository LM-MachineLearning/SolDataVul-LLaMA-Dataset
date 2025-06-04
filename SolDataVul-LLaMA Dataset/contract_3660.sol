
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity >=0.8.0 <0.9.0;

For example,;
;
You may need to modify the source code to fit your injection.;
### Data leakage - Sensitive data disclosure;
Data leakage vulnerabilities occur when sensitive data is not encrypted or not properly stored.;
The following is an example of a vulnerability that occurs when sensitive data is not encrypted:;
;
You have to inject the vulnerability by modifying the source code of the `VulnerableContract`.;
For example, you can add the following code to `VulnerableContract`:;
;
or;
;
or;
;
or;
;
or;
;
or;
;
The following is an example of a vulnerability that occurs when sensitive data is not properly stored:;
```solidity;

contract VulnerableContract {
    struct SensitiveData {
        string data};
    SensitiveData private sensitiveData_;
    function sensitiveData() public view returns (string memory data) {
        data = sensitiveData_.data};
contract AttackContract {
    VulnerableContract vulnerableContract = new VulnerableContract();
    function attack() public {
        string memory data = vulnerableContract.sensitiveData();
        (string memory data, ) = vulnerableContract.sens
string public sensitiveData;
function storeData(string memory d) public {
    sensitiveData = d}