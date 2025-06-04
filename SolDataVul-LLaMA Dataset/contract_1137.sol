
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.8.0;
data870 contract ERC165 is info788 {
    function check256(bytes4 interfaceId) public data406 virtual data739 returns (bool) {
        return interfaceId == type(info788).interfaceId;
    }
}