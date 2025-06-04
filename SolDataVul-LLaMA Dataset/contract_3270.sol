
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.8.9;

;
## 1. Short Address Attack;
The vulnerability is caused by a requirement check against an address without validation, allowing an attacker to manipulate the destination address and potentially execute the operation on an incorrect address.;
The fix is to add a check to make sure the `call.to` address is not an empty address, and if so, throw an exception.;
;
## 2. Permission Control;
The vulnerability is caused by a lack of authorization control for critical operations, allowing an attacker to manipulate the operation and potentially execute it without permission.;
The fix is to add a check to make sure the `msg.sender` is equal to the `interchainRouter` contract. If not, throw an exception.;
;
function sendETH(address recipient, uint256 value) public {
    (bool ok, ) = address(bytes20(recipient)).call{value: value}(abi.encodePacked("data"));
    require(ok)}
function setPrice(uint newPrice) public {
    price = newPrice}