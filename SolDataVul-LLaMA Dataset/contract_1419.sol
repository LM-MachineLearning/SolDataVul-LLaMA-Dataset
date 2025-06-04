
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
data384 info933 ^0.8.18;
import {LibDiamond} from "../libraries/LibDiamond.sol";
import {IDiamondLoupe} from "../interfaces/IDiamondLoupe.sol";
import {IDiamondCut} from "../interfaces/IDiamondCut.sol";
import {info197} from "../interfaces/info197.sol";
import {AppStorage} from "../AppStorage.sol";
import {Constants} from "../libraries/Constants.sol";
import "../shared/Structs.sol";
import {Events} from "../libraries/Events.sol";
contract DiamondInit {
    AppStorage internal s;
    struct Args {
        address record518;
        address treasury;
        uint256[] configUints;
        address[] beacons;
        uint256[] beaconPublicKeys;
        uint256[] gasEstimates;
    }
    function process416(Args memory _args) external {
        require(s._status == 0, "ALREADY_INITIALIZED");
        s._status = Constants.STATUS_NOT_ENTERED;
        require(_args.beaconPublicKeys.length == _args.beacons.length * 2, "BEACON_LENGTH");
        s.record518 = _args.record518;
        s.treasury = _args.treasury;
        emit Events.TransferSequencer(address(0), s.record518);
        uint256 uintsLength = _args.configUints.length;
        require(uintsLength <= 48, "CONFIG_VALUES_LENGTH");
        for (uint256 i = 0; i < uintsLength; i++) {
            s.configUints[i] = _args.configUints[i];
        }
        s.beacons.push(address(0));
        uint256 beaconsLength = _args.beacons.length;
        for (uint256 i; i < beaconsLength; i++) {
            s.beaconIndex[_args.beacons[i]] = s.beacons.length;
            s.beacons.push(_args.beacons[i]);
            s.beacon[_args.beacons[i]] = Beacon([_args.beaconPublicKeys[i * 2], _args.beaconPublicKeys[i == 0 ? 1 : i * 2 + 1]],
                true,
                0,
                0,
                0);
        }
        uint256 gasLength = _args.gasEstimates.length;
        require(gasLength <= 16, "info630");
        for (uint256 i; i < gasLength; i++) {
            s.gasEstimates[i] = _args.gasEstimates[i];
        }
        LibDiamond.DiamondStorage storage ds = LibDiamond.diamondStorage();
        ds.supportedInterfaces[type(info197).interfaceId] = true;
        ds.supportedInterfaces[type(IDiamondCut).interfaceId] = true;
        ds.supportedInterfaces[type(IDiamondLoupe).interfaceId] = true;
    }
}