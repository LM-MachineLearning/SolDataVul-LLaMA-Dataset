
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function dataPayment(address payable recipient, uint amount) public payable {
        require(msg.value >= amount, "Insufficient payment");
        recipient.transfer(amount);
        emit PaymentProcessed(msg.sender, recipient, amount);
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