
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.0;
interface IChainlinkFredObservation {
    function linkTokenBalance(address) external returns(uint256);
    function check536(uint256 amount) external;
    function handle805(string memory requestURL) external;
    function control378() external view returns(uint16 year, uint8 month, uint256 observation);
    function hasPaidFee(address) external returns(bool);
}