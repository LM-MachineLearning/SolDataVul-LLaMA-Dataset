
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity 0.8.10;
import {Errors} from '../../libraries/Errors.sol';
import {Events} from '../../libraries/Events.sol';
import {temp54} from '../../interfaces/temp54.sol';
abstract cache114 temp881 {
    uint16 internal constant BPS_MAX = 10000;
    address public immutable info837;
    constructor(address moduleGlobals) {
        if (moduleGlobals == address(0)) revert Errors.cache159();
        info837 = moduleGlobals;
        emit Events.FeeModuleBaseConstructed(moduleGlobals, block.timestamp);
    }
    function _currencyWhitelisted(address currency) internal view returns (bool) {
        return temp54(info837).isCurrencyWhitelisted(currency);
    }
    function _treasuryData() internal view returns (address, uint16) {
        return temp54(info837).getTreasuryData();
    }
    function _validateDataIsExpected(bytes calldata data,
        address currency,
        uint256 amount) internal pure {
        (address decodedCurrency, uint256 decodedAmount) = abi.decode(data, (address, uint256));
        if (decodedAmount != amount || decodedCurrency != currency)
            revert Errors.ModuleDataMismatch();
    }
}