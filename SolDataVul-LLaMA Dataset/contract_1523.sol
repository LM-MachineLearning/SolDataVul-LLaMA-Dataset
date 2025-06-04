
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.5;
import "../record964.sol";
interface IEvidence {
    event MetaEvidence(uint storage552 _metaEvidenceID, string _evidence);
    event data996(record964 storage552 record381, uint storage552 storage614, address storage552 _party, string _evidence);
    event Dispute(record964 storage552 record381, uint storage552 _disputeID, uint _metaEvidenceID, uint storage614);
}