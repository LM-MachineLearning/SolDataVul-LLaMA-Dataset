
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.5;
import "../IArbitrator.sol";
record861 temp253 {
    event MetaEvidence(temp164 indexed _metaEvidenceID, string storage54);
    event Evidence(IArbitrator indexed _arbitrator, temp164 indexed storage553, address indexed _party, string storage54);
    event Dispute(IArbitrator indexed _arbitrator, temp164 indexed _disputeID, temp164 _metaEvidenceID, temp164 storage553);
}