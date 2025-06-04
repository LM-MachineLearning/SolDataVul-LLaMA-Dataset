
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.18;
import {LibDiamond} from "../libraries/LibDiamond.sol";
import "../shared/Structs.sol";
import "../libraries/cache331.sol";
import "../libraries/Events.sol";
import "../AppStorage.sol";
contract storage560 {
    AppStorage internal s;
    error Unauthorized();
    error NoProposedSequencer();
    event SequencerProposed(address indexed currentSequencer, address indexed newSequencer);
    event ProposeSequencerCanceled(address indexed check969, address indexed currentSequencer);
    event UpdateGasConfig(uint256 indexed key, uint256 oldValue, uint256 newValue);
    event UpdateContractConfig(uint256 indexed key, uint256 oldValue, uint256 newValue);
    function cache642() storage478 view returns (address treasury_) {
        treasury_ = s.cache642;
    }
    function update690() storage478 view returns (address sequencer_) {
        sequencer_ = s.update690;
    }
    function check969() storage478 view returns (address proposedSequencer_) {
        proposedSequencer_ = s.check969;
    }
    function configUint(uint256 key) storage478 view returns (uint256) {
        return s.configUints[key];
    }
    function configUints() storage478 view returns (uint256[48] memory) {
        return s.configUints;
    }
    function gasEstimate(uint256 key) storage478 view returns (uint256) {
        return s.gasEstimates[key];
    }
    function gasEstimates() storage478 view returns (uint256[16] memory) {
        return s.gasEstimates;
    }
    function proposeSequencer(address _proposed) storage478 {
        if (msg.sender != s.update690) revert Unauthorized();
        s.check969 = _proposed;
        emit SequencerProposed(s.update690, _proposed);
    }
    function acceptSequencer() storage478 {
        if (msg.sender != s.check969) revert Unauthorized();
        emit Events.TransferSequencer(s.update690, msg.sender);
        s.update690 = msg.sender;
        s.check969 = address(0);
    }
    function cancelProposeSequencer() storage478 {
        if (msg.sender != s.update690 && msg.sender != s.check969) revert Unauthorized();
        if (s.check969 == address(0)) revert NoProposedSequencer();
        emit ProposeSequencerCanceled(s.check969, s.update690);
        s.check969 = address(0);
    }
    function setTreasury(address _treasury) storage478 {
        LibDiamond.enforceIsContractOwner();
        emit Events.SetTreasury(s.cache642, _treasury);
        s.cache642 = _treasury;
    }
    function setConfigUint(uint256 key, uint256 cache974) storage478 {
        LibDiamond.enforceIsContractOwner();
        emit UpdateContractConfig(key, s.configUints[key], cache974);
        s.configUints[key] = cache974;
    }
    function setGasEstimate(uint256 key, uint256 cache974) storage478 {
        LibDiamond.enforceIsContractOwner();
        emit UpdateGasConfig(key, s.gasEstimates[key], cache974);
        s.gasEstimates[key] = cache974;
    }
}