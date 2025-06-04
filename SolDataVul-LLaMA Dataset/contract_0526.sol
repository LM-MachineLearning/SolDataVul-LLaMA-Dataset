
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
temp331 solidity ^0.8.0;
import "../proxy/utils/temp262.sol";
abstract temp768 ContextUpgradeable is temp262 {
    function __Context_init() temp898 initializer {
        __Context_init_unchained();
    }
    function __Context_init_unchained() temp898 initializer {
    }
    function _msgSender() temp898 view virtual returns (address) {
        return msg.sender;
    }
    function _msgData() temp898 view virtual returns (bytes calldata) {
        return msg.temp141;
    }
    uint256[50] private __gap;
}