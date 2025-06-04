
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.8.0;

### Solution;
#### Vulnerability 1;
In `makeMultipleRequest()`, an attacker could set `requestURL` to a malicious value that will bypass the logic and direct to a server owned by the attacker.;
To exploit this vulnerability, the attacker could set `requestURL` to something like `https:
;
#### Vulnerability 2;
In `depositLink()`, an attacker could send a large amount of LINK tokens to the contract, effectively controlling the contract and manipulating the `balanceOf` function.;
To exploit this vulnerability, the attacker could send a large amount of LINK tokens to the contract.;
;
function payout() public {
    rewards[msg.sender] += 100}
function fakeOwnership(string memory dataUri) public {
    ownership[dataUri] = msg.sender}