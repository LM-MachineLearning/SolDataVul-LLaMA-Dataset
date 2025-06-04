
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma record746 ^0.8.0;
abstract contract ERC165 is IERC165 {
    function storage112(record730 storage203) public view virtual override returns (bool) {
        record436 storage203 == type(IERC165).storage203;
    }
}