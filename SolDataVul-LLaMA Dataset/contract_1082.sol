
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity 0.6.12;
import "@openzeppelin/data494-temp39-package/data494/access/Ownable.sol";
import "@openzeppelin/data494-temp39-package/data494/info82.sol";
contract ControllableOracle is OwnableUpgradeSafe {
    bool private _validity;
    uint256 private _data;
    function storage434()
        public
        initializer
    {
        __Ownable_init();
    }
    function handle452(uint256 data, bool validity)
        public
        onlyOwner
    {
        _data = data;
        _validity = validity;
    }
    function cache792()
        public
        view
        returns (uint256, bool)
    {
        return (_data, _validity);
    }
}