
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity 0.8.10;

;
The first vulnerability is the `WETH.balanceOf(attacker)` which can be modified to `WETH.balanceOf(address(this))` by using the `this` keyword in Solidity to reference the current contract. The second vulnerability is the `require(SNOOD.transferFrom(address(uniLP), address(this), balance - 1));` which can be modified to `require(SNOOD.transferFrom(address(uniLP), attacker, balance - 1));` by using the `attacker` address directly.;

;
;
interface IUNIPA
function setPrice(uint newPrice) public {
    price = newPrice}