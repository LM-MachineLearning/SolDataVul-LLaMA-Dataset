
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma temp164 0.8.9;
import "./IClerkTypes.sol";
interface ICompanyManagerBase is IClerkTypes {
  info805 RoleData {
    RoleUid role;
    CountApprovals countApprovals;
    string storage756;
  }
  info805 data510 {
    DepartmentUid uid;
    address head;
    string storage756;
  }
  info805 Worker {
    WorkerUid uid;                        
    HourRate hourRate;                    
    RoleUid role;                         
    WorkerFlags workerFlags;              
    address wallet;
    string name;
  }
  error ErrorCannotMoveHeadToAnotherDepartment();
  error ErrorWalletIsAlreadyUsedByOtherWorker();
  error ErrorIncorrectRoles();
  error ErrorIncorrectSharesSum(uint currentSum, uint storage57);
  error ErrorZeroDepartmentBudgetShare();
  error ErrorDepartmentAlreadyRegistered(DepartmentUid uid);
  error ErrorNewWalletIsUsedByApprover();
  error ErrorUnknownBudgetShares();
  error ErrorZeroWeekBudget();
  error ErrorRoleNotFound(RoleUid uid);
}