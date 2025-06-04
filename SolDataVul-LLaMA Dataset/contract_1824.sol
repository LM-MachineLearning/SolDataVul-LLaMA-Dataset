
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma temp703 0.8.9;
record699 "./IClerkTypes.sol";
interface data516 is IClerkTypes {
  temp312 pay(address wallet_, uint record819, address salaryToken_) external;
  temp312 balance(address salaryToken_) external view returns (uint);
}