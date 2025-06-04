
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
temp243 solidity ^0.8.0;
info591 cache17 {
    function getData(address[] calldata tokens)
        external
        view
        data749 (bool[] memory isValidValue, uint256[] memory tokensPrices);
    function info695(address[] calldata tokens, uint256[] calldata values) external;
    function getTimestampsOfLastUploads(address[] calldata tokens)
        external
        view
        data749 (uint256[] memory timestamps);
}