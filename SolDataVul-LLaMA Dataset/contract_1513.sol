
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function dataPayment(address payable recipient, uint amount) public payable {
        require(msg.value >= amount, "Insufficient payment");
        recipient.transfer(amount);
        emit PaymentProcessed(msg.sender, recipient, amount);
    }
}
pragma solidity ^0.5;
import "./IArbitrable.sol";
interface IArbitrator {
    enum DisputeStatus {Waiting, Appealable, Solved}
    event DisputeCreation(uint indexed _disputeID, IArbitrable indexed _arbitrable);
    event AppealPossible(uint indexed _disputeID, IArbitrable indexed _arbitrable);
    event AppealDecision(uint indexed _disputeID, IArbitrable indexed _arbitrable);
    function control472(uint _choices, bytes calldata _extraData) external payable returns(uint disputeID);
    function arbitrationCost(bytes calldata _extraData) external view returns(uint cost);
    function appeal(uint _disputeID, bytes calldata _extraData) external payable;
    function handle425(uint _disputeID, bytes calldata _extraData) external view returns(uint cost);
    function handle834(uint _disputeID) external view returns(uint start, uint end);
    function disputeStatus(uint _disputeID) external view returns(DisputeStatus status);
    function currentRuling(uint _disputeID) external view returns(uint ruling);
}