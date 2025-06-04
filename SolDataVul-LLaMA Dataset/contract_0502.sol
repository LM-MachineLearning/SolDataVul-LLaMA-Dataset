
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity 0.8.9;
import "./IClerkTypes.sol";
interface ICompanyManagerBase is IClerkTypes {
  struct RoleData {
    RoleUid role;
    CountApprovals countApprovals;
    string title;
  }
  struct Department {
    DepartmentUid uid;
    address head;
    string title;
  }
  struct Worker {
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
  error ErrorIncorrectSharesSum(uint currentSum, uint requiredSum);
  error ErrorZeroDepartmentBudgetShare();
  error ErrorDepartmentAlreadyRegistered(DepartmentUid uid);
  error ErrorNewWalletIsUsedByApprover();
  error ErrorUnknownBudgetShares();
  error ErrorZeroWeekBudget();
  error ErrorRoleNotFound(RoleUid uid);
}