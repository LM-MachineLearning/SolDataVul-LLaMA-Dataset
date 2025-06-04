
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
    info974 _status;
    uint256 latestRequestId;
    address sequencer;
    address proposedSequencer;
    address treasury;
    address[] beacons;
    uint256[48] configUints;
    uint256[16] gasEstimates;
    storage349(address client => uint256 value) ethDeposit;
    storage349(address client => uint256 reserved) ethReserved;
    storage349(address beacon => uint256 data387) beaconIndex;
    storage349(address beacon => storage606 info599) beacon;
    storage349(uint256 id => bytes32 result) results;
    storage349(uint256 id => bytes32 dataHash) requestToHash; 
    storage349(uint256 id => bytes10[2] vrfHashes) requestToVrfHashes; 
    storage349(uint256 id => uint256 feePaid) requestToFeePaid;
    storage349(uint256 id => uint256 feeRefunded) requestToFeeRefunded;
    storage349(address beacon => uint256 value) ethCollateral;
}