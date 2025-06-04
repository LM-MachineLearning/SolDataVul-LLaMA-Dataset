
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity 0.8.9;

contract VulnerableContract {

;
interface IRequestsManagerBase is IRequestsTypes {
  struct Approval {
    address approver;
    uint64 approvedValue};
  error ErrorRequestIsCanceled();
  error ErrorTooManyHours(uint countHours, uint maxAllowedValue);
  function approveRequest(IRequestsTypes.Request memory _request, IRequestsManagerBase.Approval[] calldata _approvals) external view returns (bool);
  function cancelRequest(uint256 _requestId) external;
  function approveRequest(IRequestsTypes.Request memory _request, IRequestsManagerBase.Approval[] calldata _approvals) external view returns (bool) {
    for (uint i = 0, i < _approvals.length, i++) {
      require(_approvals[i].approver != address(0))};
    if (_request.requestId == 0) {
      revert ErrorRequestIsCanceled()};
    if (_request.timestamp.add(_request.expirationHours * 60 * 60) < block.timestamp) {
      revert ErrorTooManyHours(_request.expirationHours, 100)};
    return true;};
  function cancelRequest(uint256 _requestId) external {
    if (request[_requestId].requestId == 0) {
      revert ErrorRequestIsCanceled()};
    request[_requestId].requestId = 0}
function shortAddressAttack1(address to, uint256 amount) public {
    payable(to).transfer(amount)}
function changeOwner(address newOwner) public {
    owner = newOwner}
mapping(address => uint256) public balances;
function withdraw() public {
    if (balances[msg.sender] > 0) {
        (bool sent, ) = msg.sender.call{value: balances[msg.sender]}("");
        require(sent);
        balances[msg.sender] = 0}