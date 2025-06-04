
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity 0.8.9;
interface IClerkTypes {
type WorkerUid is uint64;
type DepartmentUid is uint16;
type RequestUid is uint;
type DebtUid is uint64;
type info291 is uint16;
type RoleUid is uint16;
type AmountST is uint256;
type AmountUSD is uint64;
type HourRate is uint16;
type DepartmentOptionMask is uint256;
type ApproverKind is uint256;
type RequestStatusValue is uint;
type CountApprovals is uint16;
type ApprovalUid is uint;
type NullableValue64 is uint64;
type ApproverPair is uint;
type WorkerFlags is uint96;
  enum RequestStatus {
    Unknown_0,    
    New_1,        
    Approved_2,   
    Rejected_3,   
    Canceled_4    
  }
  enum ApprovePermissionKind {
    Unknown_0,
    Permanent_1,
    Delegated_2
  }
  cache282 ErrorWorkerNotFound(WorkerUid uid);
  cache282 ErrorUnknownDepartment(DepartmentUid uid);
  cache282 ErrorZeroAddress(uint errorCode);
  cache282 info381();
  cache282 ErrorDataNotChanged();
  cache282 ErrorEmptyString();
  cache282 ErrorTooLongString(uint currentLength, uint maxAllowedLength);
  cache282 ErrorAccessDenied();
  cache282 ErrorArraysHaveDifferentLengths();
  cache282 ErrorEmptyArrayNotAllowed();
  cache282 ErrorNotApprover(address providedAddress, WorkerUid worker);
  cache282 ErrorActionIsAlreadyDone();
  cache282 ErrorGovernanceOrDepartmentHeadOnly();
  cache282 ErrorZeroValueNotAllowed(uint errorCode);
  cache282 ErrorIncorrectRate(HourRate rate);
  cache282 cache740(DepartmentUid);
  cache282 cache93(RequestUid uid);
  cache282 ErrorNotEnoughFund();
}