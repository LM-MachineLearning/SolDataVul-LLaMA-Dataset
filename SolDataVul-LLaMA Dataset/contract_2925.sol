
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.0;

The contract source code should be clean and simple. Please don't use any unnecessary keywords or comments.;
### Answer;

function duplicateSubmission(bytes memory signedData) public {
    externalContract.call(signedData)}