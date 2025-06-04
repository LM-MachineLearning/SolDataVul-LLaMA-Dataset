
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity 0.8.9;
import "./IClerkTypes.sol";
interface IRequestsTypes is IClerkTypes {
  struct RequestData {
    WorkerUid worker;           
    RoleUid role;               
    DepartmentUid department;   
    HourRate hourRate;          
    uint32 countHours;          
    EpochType epoch;            
    string descriptionUrl;
  }
  struct WorkerStat {
    uint32 workedHours;
    AmountUSD earnedDollars;
  }
}