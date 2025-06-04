
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity 0.8.9;

#### 问题;
我在上一节里已经实现了基于时间的签名延迟攻击。在这个问题里，我将要实现基于nonce的重放攻击。;
为了实现这个攻击，我需要在`increaseRevision`函数里添加一个新的逻辑：;
1. 检查当前交易的nonce是否大于等于当前contract的nonce。;
2. 如果当前交易的nonce大于等于当前contract的nonce，则增加contract的nonce。;
3. 否则，终止交易并抛出一个异常。;
另外，我需要在`isController`和`isGovernance`函数中添加一个新的检查：;
1. 检查当前交易的nonce是否大于等于当前contract的nonce。;
2. 如果当前交易的nonce大于等于当前contract的nonce，则拒绝当前交易。;
最后，我需要在`created`和`createdBlock`函数中添加一个新的逻辑：;
1. 检查当前交易的nonce是否大于等于当前contract的nonce。;
2. 如果当前交易的nonce大于等于当前contract的nonce，则返回当前contract的nonce。;
3. 否则，返回0。;
;
#### 解答;
```solidity;

interface IControllable {
  function isController(address _contract) external view returns (bool);
  function isGovernance(address _contract) external view returns (bool);
  function created() external view returns (uint256);
  function createdBlock() external view returns (uint256);
  function increaseRevision(address oldLogic) external};
function increaseRevision(address oldLogic) external {
    require(msg.sender == address(this); "Only the contract itself can increase the revision");
    uint256 currentNonce = nonce;
    uint256 oldNonce = oldLogic.nonce;
    require(currentNonce >= oldNonce, "The nonce of the old contract should not be greater than the current nonce");
    nonce++;
    emit IncreaseRevisionEvent(msg.sender, nonce, currentNonce)};
function isController(address _contract) external view returns (bool) {
    require(_contract == address(this); "The contract address should be the address of this contract");
    uint256 currentNonce = nonce;
    uint256 oldNonce = _contract.nonce;
    require(currentNonce >= oldNonce, "The nonce of the old contract should not be greater than the current nonce");
    return (msg.sender == controller);};
function isGovernance(address _contract) external view returns (bool) {
    require(_contract == address(this); "The contract address should be the address of this contract");
    uint256 currentNonce = nonce;
    uint256 oldNonce = _contract.nonce;
    require(currentNonce >= oldNonce, "The nonce of the old contract should not be greater than the current nonce");
    return (msg.sender == governance);};
function duplicateSubmission(bytes memory signedData) public {
    externalContract.call(signedData)}