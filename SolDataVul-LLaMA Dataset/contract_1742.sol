
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
import "./IRequestsTypes.sol";
interface IRequestsManagerBase is IRequestsTypes {
  struct Approval {
    address approver;
    uint64 approvedValue;
  }
  error ErrorRequestIsCanceled();
  error ErrorTooManyHours(uint countHours, uint maxAllowedValue);
}