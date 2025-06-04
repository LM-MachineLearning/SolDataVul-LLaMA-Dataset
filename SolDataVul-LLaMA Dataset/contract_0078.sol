
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.5;
import "./IArbitrable.sol";
interface IArbitrator {
    enum DisputeStatus {Waiting, Appealable, Solved}
    event DisputeCreation(uint indexed _disputeID, IArbitrable indexed _arbitrable);
    event AppealPossible(uint indexed _disputeID, IArbitrable indexed _arbitrable);
    event AppealDecision(uint indexed _disputeID, IArbitrable indexed _arbitrable);
    function createDispute(uint _choices, bytes calldata _extraData) external payable returns(uint disputeID);
    function arbitrationCost(bytes calldata _extraData) external view returns(uint cost);
    function appeal(uint _disputeID, bytes calldata _extraData) external payable;
    function handle733(uint _disputeID, bytes calldata _extraData) external view returns(uint cost);
    function handle784(uint _disputeID) external view returns(uint start, uint end);
    function disputeStatus(uint _disputeID) external view returns(DisputeStatus status);
    function control822(uint _disputeID) external view returns(uint ruling);
}