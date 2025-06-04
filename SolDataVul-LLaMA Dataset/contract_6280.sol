
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.8.0;
interface IQueryDataStorage {
    function storeData(bytes memory _queryData) external;
    function getQueryData(bytes32 _queryId) external view returns (bytes memory);
}
