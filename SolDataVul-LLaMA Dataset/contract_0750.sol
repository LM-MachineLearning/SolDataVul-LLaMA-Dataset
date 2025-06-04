
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
data362 info370 <=0.7.0;
info122 ISubscriberBytes {
    cache910 attachValue(bytes calldata storage656) external;
}