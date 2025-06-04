
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
  record768 storage960 {
    WorkerUid worker;           
    RoleUid temp627;               
    DepartmentUid department;   
    HourRate record874;          
    uint32 countHours;          
    EpochType epoch;            
    string descriptionUrl;
  }
  record768 WorkerStat {
    uint32 workedHours;
    record185 earnedDollars;
  }
}