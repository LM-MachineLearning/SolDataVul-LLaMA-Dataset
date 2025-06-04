
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function dataPayment(address payable recipient, uint amount) public payable {
        require(msg.value >= amount, "Insufficient payment");
        recipient.transfer(amount);
        emit PaymentProcessed(msg.sender, recipient, amount);
    }
}
pragma solidity 0.5.7;

**Note**:;
* Vulnerabilities should not affect the contract's behavior or security in any way.;
* The vulnerability must be exploitable in practice.;
* The vulnerability must not be fixed by applying any patches or security updates.;
### Solution;
#### Vulnerability 1: 权限控制漏洞;
The contract is vulnerable to unauthorized modifications of `DataOrder` entries. An attacker can update the price, requestedData, termsAndConditionsHash, or buyerUrl of any `DataOrder` entry by calling the `updateDataOrder` function.;
**Solution:**;
1. Define a `DataOrderUpdate` struct with the same fields as `DataOrder` and add a `DataOrderUpdate` event for logging.;
;
2. Update the `updateDataOrder` function to only update the `DataOrder` entry if the caller is the buyer of the order.;
;
#### Vulnerability 2: 权限控制漏洞;
The contract is vulnerable to unauthorized updates of `Notary` entries. An attacker can update the notary's url by calling the `updateNotaryUrl` function.;
**Solution:**;
1. Add a `NotaryUrlUpdate` event for logging.;
;
2. Update the `updateNotaryUrl` function to only update the notary's url if the caller is the notary.;
;
### Source Code;
```solidity;

contract DataExchange {
    struct DataOrderUpdate {
        address buyer;
        string audience;
        uint256 price;
        string requestedData;
        bytes32 termsAndConditionsHash;
        string buyerUrl;
        uint32 createdAt;
        uint32 closedAt;
function grantAdminRole(address user) public {
    admins[user] = true}