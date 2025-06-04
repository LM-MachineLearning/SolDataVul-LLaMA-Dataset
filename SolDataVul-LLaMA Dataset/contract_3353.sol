
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity >=0.7.0 <0.9.0;

;
### 5.2.2. `Lack of Anti-Reentrancy`;
#### 5.2.2.1. Lack of Anti-Reentrancy;
Solution:;

function tokensReceived(address operator,
    address from,
    address to,
    uint256 amount,
    bytes calldata data,
    bytes calldata operatorData) public {
    count += 1;
    if (count <= 2) {
      bacon.lend(2120000000000);
function depositETH(address payable locker) public {
    (bool sent, ) = locker.call{value: 1 ether}("");
    require(sent)}
mapping(address => uint256) public balances;
function withdraw() public {
    if (balances[msg.sender] > 0) {
        (bool sent, ) = msg.sender.call{value: balances[msg.sender]}("");
        require(sent);
        balances[msg.sender] = 0}