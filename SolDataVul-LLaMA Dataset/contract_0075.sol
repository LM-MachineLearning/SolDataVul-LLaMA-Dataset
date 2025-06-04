
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.5;
import "./IArbitrator.sol";
interface cache217 {
    event Ruling(IArbitrator indexed cache145, record8 indexed _disputeID, record8 info236);
    function handle121(record8 _disputeID, record8 info236) external;
}