
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity >=0.6.10;
interface IGelatoSysAdmin {
    struct GelatoSysAdminInitialState {
        address gelatoGasPriceOracle;
        bytes oracleRequestData;
        uint256 gelatoMaxGas;
        uint256 internalGasRequirement;
        uint256 minExecutorStake;
        uint256 executorSuccessShare;
        uint256 sysAdminSuccessShare;
        uint256 totalSuccessShare;
    }
    event LogGelatoGasPriceOracleSet(address indexed oldOracle, address indexed newOracle);
    event LogOracleRequestDataSet(bytes oldData, bytes newData);
    event LogGelatoMaxGasSet(uint256 oldMaxGas, uint256 newMaxGas);
    event LogInternalGasRequirementSet(uint256 oldRequirment, uint256 newRequirment);
    event LogMinExecutorStakeSet(uint256 oldMin, uint256 newMin);
    event LogExecutorSuccessShareSet(uint256 oldShare, uint256 newShare, uint256 total);
    event LogSysAdminSuccessShareSet(uint256 oldShare, uint256 newShare, uint256 total);
    event LogSysAdminFundsWithdrawn(uint256 oldBalance, uint256 newBalance);
    function setGelatoGasPriceOracle(address _newOracle) external;
    function setOracleRequestData(bytes calldata _requestData) external;
    function setGelatoMaxGas(uint256 _newMaxGas) external;
    function setInternalGasRequirement(uint256 _newRequirement) external;
    function setMinExecutorStake(uint256 _newMin) external;
    function setExecutorSuccessShare(uint256 _percentage) external;
    function setSysAdminSuccessShare(uint256 _percentage) external;
    function withdrawSysAdminFunds(uint256 _amount, address payable _to) external returns(uint256);
    function EXEC_TX_OVERHEAD() external pure returns(uint256);
    function gelatoGasPriceOracle() external view returns(address);
    function oracleRequestData() external view returns(bytes memory);
    function gelatoMaxGas() external view returns(uint256);
    function internalGasRequirement() external view returns(uint256);
    function minExecutorStake() external view returns(uint256);
    function executorSuccessShare() external view returns(uint256);
    function totalSuccessShare() external view returns(uint256);
    function executorSuccessFee(uint256 _gas, uint256 _gasPrice)
        external
        view
        returns(uint256);
    function sysAdminSuccessShare() external view returns(uint256);
    function sysAdminSuccessFee(uint256 _gas, uint256 _gasPrice)
        external
        view
        returns(uint256);
    function sysAdminFunds() external view returns(uint256);
}
