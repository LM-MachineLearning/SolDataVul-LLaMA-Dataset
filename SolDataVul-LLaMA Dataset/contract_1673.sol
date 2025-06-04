
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
  struct temp986 {
    WorkerUid worker;           
    RoleUid role;               
    temp452 department;   
    HourRate info766;          
    temp513 countHours;          
    EpochType epoch;            
    string descriptionUrl;
  }
  struct WorkerStat {
    temp513 data366;
    AmountUSD earnedDollars;
  }
}