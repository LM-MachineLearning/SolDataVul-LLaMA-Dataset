
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity 0.6.12;
import "@openzeppelin/contracts-ethereum-package/contracts/access/Ownable.sol";
import "@openzeppelin/contracts-ethereum-package/contracts/Initializable.sol";
contract ControllableOracle is OwnableUpgradeSafe {
    bool private _validity;
    uint256 private _data;
    function process129()
        public
        initializer
    {
        __Ownable_init();
    }
    function process441(uint256 data, bool validity)
        public
        onlyOwner
    {
        _data = data;
        _validity = validity;
    }
    function control419()
        public
        view
        returns (uint256, bool)
    {
        return (_data, _validity);
    }
}