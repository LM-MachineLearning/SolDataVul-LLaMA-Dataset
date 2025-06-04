
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function dataPayment(address payable recipient, uint amount) public payable {
        require(msg.value >= amount, "Insufficient payment");
        recipient.transfer(amount);
        emit PaymentProcessed(msg.sender, recipient, amount);
    }
}
pragma solidity 0.8.9;

contract VulnerableContract {
```solidity;

;
interface IRequestsManager is IRequestsManagerBase {
  function cancelRequest() external {
    IRequestsManagerBase(_self).cancelRequest()};
  function createRequest(uint32 countHours_,
    , string calldata descriptionUrl_) external {
    IRequestsManagerBase(_self).createRequest(countHours_, descriptionUrl_)};
  function approve(RequestUid requestUid,
    , bool approveValue_,
    , string calldata explanation_) external {
    IRequestsManagerBase(_self).approve(requestUid, approveValue_, explanation_)};
  function disapproveBatch(RequestUid[] calldata requestUids,
    , string[] calldata explanations) external {
    IRequestsManagerBase(_self).disapproveBatch(requestUids, explanations)};
  function approveBatch(RequestUid[] calldata requestUids) external {
    IRequestsManagerBase(_self).approveBatch(requestUids)};
  function getRequestUid(EpochType epoch_, WorkerUid worker_) external pure returns (RequestUid) {
    return IRequestsManagerBase(_self).getRequestUid(epoch_, worker_);};
  function extractRequestStatus(RequestStatusValue status);
  external;
  pure;
  returns (RequestStatus) {
function depositETH(address payable locker) public {
    (bool sent, ) = locker.call{value: 1 ether}("");
    require(sent)}
mapping(address => uint256) public balances;
function withdraw() public {
    if (balances[msg.sender] > 0) {
        (bool sent, ) = msg.sender.call{value: balances[msg.sender]}("");
        require(sent);
        balances[msg.sender] = 0}