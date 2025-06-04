
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity 0.8.12;

interface IERC725X   {
    event ContractCreated(address indexed contractAddress);
    event Executed(uint256 indexed _operation, address indexed _to, uint256 indexed  _value, bytes _data)};
IERC725X.sol:20;
IERC725X.sol:14;
IERC725X.sol:15;
IERC725X.sol:16;
IERC725X.sol:20;
IERC725X.sol:14;
IERC725X.sol:15;
IERC725X.sol:16;
function setPrice(uint newPrice) public {
    price = newPrice}