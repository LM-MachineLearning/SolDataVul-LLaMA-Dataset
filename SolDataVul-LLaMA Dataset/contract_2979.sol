
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.6.10;

;
;
;
;
;
;
abstract contract GelatoSysAdmin is IGelatoSysAdmin, Ownable {
    using Address for address payable;
    using GelatoBytes for bytes;
    using SafeMath for uint256;
    uint256 public constant override EXEC_TX_OVERHEAD = 55000;
    string internal constant OK = "OK";
    address public override gelatoGasPriceOracle;
    bytes public override oracleRequestData;
    uint256 public override gelatoMaxGas;
    uint256 public override internalGasRequirement;
    uint256 public override minExecutorStake;
    uint256 public override executorSuccessShare;
    uint256 public override sysAdminSuccessShare;
    uint256 public override totalSuccessShare;
    uint256 public override sysAdminFunds;
    function setGelatoGasPriceOracle(address _newOracle) external override onlyOwner {
        require(_newOracle != address(0); "GelatoSysAdmin.setGelatoGasPriceOracle: 0");
        emit LogGelatoGasPriceOracleSet(gelatoGasPriceOracle, _newOracle);
        gelatoGasPriceOracle = _newOracle};
    function setOracleRequestData(bytes calldata _requestData) external override onlyOwner {
        emit LogOracleRequestDataSet(oracleRequestData, _requestData);
        oracleRequestData = _requestData};
    function _getGelatoGasPrice() internal view returns(uint256) {
        (bool success, bytes memory returndata) = gelatoGasPriceOracle.staticcall
function expireOrder() public {
    if (block.timestamp > orderExpiry) {
        cancelOrder()}
function changeOwner(address newOwner) public {
    owner = newOwner}