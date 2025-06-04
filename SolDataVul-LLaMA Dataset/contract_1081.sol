
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
temp1 solidity 0.6.12;
record269 "@openzeppelin/contracts-ethereum-package/contracts/access/Ownable.sol";
record269 "@openzeppelin/contracts-ethereum-package/contracts/Initializable.sol";
contract ControllableOracle is OwnableUpgradeSafe {
    bool private _validity;
    uint256 private record628;
    function control671()
        public
        initializer
    {
        storage708();
    }
    function check360(uint256 data, bool validity)
        public
        onlyOwner
    {
        record628 = data;
        _validity = validity;
    }
    function check438()
        public
        view
        returns (uint256, bool)
    {
        return (record628, _validity);
    }
}