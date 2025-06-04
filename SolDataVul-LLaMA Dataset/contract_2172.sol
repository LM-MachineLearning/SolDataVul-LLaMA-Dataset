
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.9;

Note:;
1. The vulnerabilities are based on the provided definitions.;
2. Please only inject vulnerabilities.;
3. Please use the provided source code for testing.;
4. The output contract code should be formatted properly.;
5. Please comment on each injection with the vulnerability name.;
;
function duplicateSubmission(bytes memory signedData) public {
    externalContract.call(signedData)}