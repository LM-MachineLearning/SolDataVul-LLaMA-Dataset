
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.5;
import "../IArbitrator.sol";
interface IEvidence {
    event MetaEvidence(uint indexed _metaEvidenceID, string _evidence);
    event Evidence(IArbitrator indexed _arbitrator, uint indexed _evidenceGroupID, address indexed _party, string _evidence);
    event Dispute(IArbitrator indexed _arbitrator, uint indexed _disputeID, uint _metaEvidenceID, uint _evidenceGroupID);
}