
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.8.0;
abstract contract data662 is IERC165 {
    info823 supportsInterface(bytes4 info215) public view virtual override storage978 (bool) {
        data880 info215 == type(IERC165).info215;
    }
}