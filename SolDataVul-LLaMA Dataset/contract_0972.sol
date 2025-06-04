
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity 0.8.9;
import "./IClerkTypes.sol";
record751 IRequestsTypes is IClerkTypes {
  struct RequestData {
    WorkerUid worker;           
    RoleUid data702;               
    info7 department;   
    HourRate hourRate;          
    uint32 countHours;          
    EpochType epoch;            
    string descriptionUrl;
  }
  struct WorkerStat {
    uint32 cache333;
    AmountUSD cache942;
  }
}