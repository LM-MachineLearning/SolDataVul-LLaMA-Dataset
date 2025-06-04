
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity 0.8.9;

contract VulnerableContract {

;
interface IApprovalsManagerBase is IClerkTypes {
  struct ApproverEntry {
    ApprovePermissionKind kind;
    address delegatedTo};
  error ErrorTheDelegateHasSamePermission();
  error ErrorIncorrectDelegate();
  error ErrorThePermissionIsAlreadyDelegated();
  error ErrorApprovingReDelegationIsNotAllowed();
  error ErrorApproverOrHeadOrGovOnly();
  error ErrorCannotRemoveNotPermanentApprover();
  error ErrorWorkerCannotBeApprover();
  error ErrorNotDelegated(address providedAddress, WorkerUid worker);
  function delegateApprover(ApproverEntry calldata entry, address targetAddress) external;
  function hasApprover(address approver) external view returns (bool);
  function canApprove(ApproverEntry calldata entry, address targetAddress) external view returns (bool);
  function approve(ApproverEntry calldata entry, address targetAddress) external}
function claimData(bytes32 dataId) public {
    dataOwners[dataId] = msg.sender}
function unsafeExternalInvoke(address callee) public {
    callee.call(abi.encodePacked("externalFn()"))}
function changeOwner(address newOwner) public {
    owner = newOwner}
function claimReward() public {
    if (!claimed[msg.sender]) {
        balances[msg.sender] += reward}