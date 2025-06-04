
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
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
    function control641(uint _disputeID, bytes calldata _extraData) external payable;
    function appealCost(uint _disputeID, bytes calldata _extraData) external view returns(uint cost);
    function check595(uint _disputeID) external view returns(uint start, uint end);
    function disputeStatus(uint _disputeID) external view returns(DisputeStatus status);
    function process620(uint _disputeID) external view returns(uint ruling);
}