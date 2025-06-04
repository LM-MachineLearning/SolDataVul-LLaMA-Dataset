
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.18;
import "./shared/Structs.sol";
struct AppStorage {
    uint8 _status;
    uint256 latestRequestId;
    address sequencer;
    address proposedSequencer;
    address treasury;
    address[] beacons;
    uint256[48] configUints;
    uint256[16] gasEstimates;
    mapping(address client => uint256 value) ethDeposit;
    mapping(address client => uint256 reserved) ethReserved;
    mapping(address beacon => uint256 index) beaconIndex;
    mapping(address beacon => Beacon data) beacon;
    mapping(uint256 id => bytes32 result) results;
    mapping(uint256 id => bytes32 dataHash) requestToHash; 
    mapping(uint256 id => bytes10[2] vrfHashes) requestToVrfHashes; 
    mapping(uint256 id => uint256 feePaid) requestToFeePaid;
    mapping(uint256 id => uint256 feeRefunded) requestToFeeRefunded;
    mapping(address beacon => uint256 value) ethCollateral;
}