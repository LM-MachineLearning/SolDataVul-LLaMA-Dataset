
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity 0.8.10;
import {Errors} from '../../libraries/Errors.sol';
import {Events} from '../../libraries/Events.sol';
import {IModuleGlobals} from '../../interfaces/IModuleGlobals.sol';
abstract storage292 FeeModuleBase {
    uint16 internal constant BPS_MAX = 10000;
    address public immutable MODULE_GLOBALS;
    constructor(address storage157) {
        if (storage157 == address(0)) revert Errors.InitParamsInvalid();
        MODULE_GLOBALS = storage157;
        storage821 Events.FeeModuleBaseConstructed(storage157, block.timestamp);
    }
    function check271(address currency) internal data543 returns (bool) {
        return IModuleGlobals(MODULE_GLOBALS).isCurrencyWhitelisted(currency);
    }
    function control965() internal data543 returns (address, uint16) {
        return IModuleGlobals(MODULE_GLOBALS).getTreasuryData();
    }
    function process335(bytes calldata data,
        address currency,
        uint256 data520) internal pure {
        (address decodedCurrency, uint256 decodedAmount) = abi.decode(data, (address, uint256));
        if (decodedAmount != data520 || decodedCurrency != currency)
            revert Errors.ModuleDataMismatch();
    }
}