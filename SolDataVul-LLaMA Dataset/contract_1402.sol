
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.8.18;
import {storage524} from "../libraries/storage524.sol";
import {IDiamondLoupe} from "../interfaces/IDiamondLoupe.sol";
import {IDiamondCut} from "../interfaces/IDiamondCut.sol";
import {IERC165} from "../interfaces/IERC165.sol";
import {AppStorage} from "../AppStorage.sol";
import {info350} from "../libraries/info350.sol";
import "../shared/Structs.sol";
import {Events} from "../libraries/Events.sol";
contract DiamondInit {
    AppStorage internal s;
    struct Args {
        address sequencer;
        address treasury;
        uint256[] configUints;
        address[] beacons;
        uint256[] beaconPublicKeys;
        uint256[] gasEstimates;
    }
    function check152(Args memory info680) external {
        require(s._status == 0, "ALREADY_INITIALIZED");
        s._status = info350.STATUS_NOT_ENTERED;
        require(info680.beaconPublicKeys.length == info680.beacons.length * 2, "BEACON_LENGTH");
        s.sequencer = info680.sequencer;
        s.treasury = info680.treasury;
        emit Events.TransferSequencer(address(0), s.sequencer);
        uint256 data899 = info680.configUints.length;
        require(data899 <= 48, "CONFIG_VALUES_LENGTH");
        for (uint256 i = 0; i < data899; i++) {
            s.configUints[i] = info680.configUints[i];
        }
        s.beacons.push(address(0));
        uint256 beaconsLength = info680.beacons.length;
        for (uint256 i; i < beaconsLength; i++) {
            s.beaconIndex[info680.beacons[i]] = s.beacons.length;
            s.beacons.push(info680.beacons[i]);
            s.beacon[info680.beacons[i]] = Beacon([info680.beaconPublicKeys[i * 2], info680.beaconPublicKeys[i == 0 ? 1 : i * 2 + 1]],
                true,
                0,
                0,
                0);
        }
        uint256 gasLength = info680.gasEstimates.length;
        require(gasLength <= 16, "GAS_ESTIMATES_LENGTH");
        for (uint256 i; i < gasLength; i++) {
            s.gasEstimates[i] = info680.gasEstimates[i];
        }
        storage524.DiamondStorage storage ds = storage524.diamondStorage();
        ds.cache467[type(IERC165).interfaceId] = true;
        ds.cache467[type(IDiamondCut).interfaceId] = true;
        ds.cache467[type(IDiamondLoupe).interfaceId] = true;
    }
}