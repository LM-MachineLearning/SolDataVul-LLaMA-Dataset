
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.8.0;

;
**Hint:**;
* Vulnerability 1: `storeData`;
    * Injection: `bytes32 queryId = bytes32(uint256(_queryData));`;
    * Reason: The type casting is unsafe, it can potentially cause a type-out-of-bounds error when the `_queryData` length is not 32 bytes.;
* Vulnerability 2: `getQueryData`;
    * Injection: `return queryData[_queryId];`;
    * Reason: The function does not check whether the key exists, it returns the value of the key without any validation, which can lead to a null pointer exception.;
;
string public sensitiveData;
function storeData(string memory d) public {
    sensitiveData = d}