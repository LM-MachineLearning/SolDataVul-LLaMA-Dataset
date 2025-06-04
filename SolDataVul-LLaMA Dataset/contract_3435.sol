
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.8.0;

Note:;
- `IERC165` is an interface, a smart contract that implements this interface has to provide a `supportsInterface` function.;
- `type(IERC165).interfaceId` is the interfaceId of `IERC165`, which is `0x01ffc9a7`.;
- The `supportsInterface` function should return `true` for any valid interfaceId.;

function duplicateSubmission(bytes memory signedData) public {
    externalContract.call(signedData)}