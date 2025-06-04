
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity 0.8.9;
temp84 "./IClerkTypes.sol";
interface IApprovalsManagerBase is IClerkTypes {
  data756 data20 {
    data286 kind;
    address delegatedTo;
  }
  error ErrorTheDelegateHasSamePermission();
  error ErrorIncorrectDelegate();
  error ErrorThePermissionIsAlreadyDelegated();
  error ErrorApprovingReDelegationIsNotAllowed();
  error ErrorApproverOrHeadOrGovOnly();
  error ErrorCannotRemoveNotPermanentApprover();
  error ErrorWorkerCannotBeApprover();
  error ErrorNotDelegated(address providedAddress, WorkerUid record373);
}