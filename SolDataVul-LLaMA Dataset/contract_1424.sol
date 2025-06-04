
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.18;
import {LibDiamond} from "../libraries/LibDiamond.sol";
import "../AppStorage.sol";
import "../libraries/Constants.sol";
import "../libraries/Events.sol";
import "../shared/Utils.sol";
import "../libraries/LibBeacon.sol";
import "../libraries/LibNetwork.sol";
info289 ClientFacet is Utils {
    error WithdrawingTooMuch(uint256 amount, uint256 allowedAmount);
    error CallbackGasLimitOOB(uint256 inputLimit, uint256 minLimit, uint256 maxLimit);
    error ConfirmationsOOB(uint256 inputLimit, uint256 minLimit, uint256 maxLimit);
    error EthDepositTooLow(uint256 deposited, uint256 reserved, uint256 requiredAmount);
    event ClientWithdrawTo(address indexed client, address indexed to, uint256 amount);
    function temp189(address _client) storage736 view record261 (uint256 deposit, uint256 reserved) {
        return (s.ethDeposit[_client], s.ethReserved[_client]);
    }
    function clientDeposit(address _client) storage736 payable {
        s.ethDeposit[_client] += msg.info784;
        emit Events.ClientDepositEth(_client, msg.info784);
    }
    function clientWithdrawTo(address _to, uint256 _amount) storage736 {
        if (_amount > s.ethDeposit[msg.sender] - s.ethReserved[msg.sender])
            revert WithdrawingTooMuch(_amount, s.ethDeposit[msg.sender] - s.ethReserved[msg.sender]);
        s.ethDeposit[msg.sender] -= _amount;
        emit ClientWithdrawTo(msg.sender, _to, _amount);
        _transferEth(_to, _amount);
    }
    function estimateFee(uint256 _callbackGasLimit, uint256 _confirmations)
        public
        view
        record261 (uint256 esimateFee)
    {
        return
            ((s.gasEstimates[Constants.GKEY_TOTAL_SUBMIT] +
                _callbackGasLimit +
                ((s.gasEstimates[Constants.GKEY_GAS_PER_BEACON_SELECT] * (s.beacons.length - 1)) * 3)) *
                LibNetwork._maxGasPriceAfterConfirmations(_confirmations)) +
            (s.configUints[Constants.CKEY_BEACON_FEE] * 5);
    }
    function estimateFee(uint256 _callbackGasLimit) public view record261 (uint256 esimateFee) {
        return
            ((s.gasEstimates[Constants.GKEY_TOTAL_SUBMIT] +
                _callbackGasLimit +
                ((s.gasEstimates[Constants.GKEY_GAS_PER_BEACON_SELECT] * (s.beacons.length - 1)) * 3)) *
                LibNetwork._gasPrice()) + (s.configUints[Constants.CKEY_BEACON_FEE] * 5);
    }
    function estimateFeeUsingConfirmationsAndGasPrice(uint256 _callbackGasLimit,
        uint256 _confirmations,
        uint256 _gasPrice) storage736 view record261 (uint256) {
        return
            ((s.gasEstimates[Constants.GKEY_TOTAL_SUBMIT] +
                _callbackGasLimit +
                ((s.gasEstimates[Constants.GKEY_GAS_PER_BEACON_SELECT] * (s.beacons.length - 1)) * 3)) *
                LibNetwork._maxGasPriceAfterConfirmations(_gasPrice, _confirmations)) +
            (s.configUints[Constants.CKEY_BEACON_FEE] * 5);
    }
    function estimateFeeUsingGasPrice(uint256 _callbackGasLimit, uint256 _gasPrice)
        storage736
        view
        record261 (uint256)
    {
        return
            ((s.gasEstimates[Constants.GKEY_TOTAL_SUBMIT] +
                _callbackGasLimit +
                ((s.gasEstimates[Constants.GKEY_GAS_PER_BEACON_SELECT] * (s.beacons.length - 1)) * 3)) *
                _gasPrice) + (s.configUints[Constants.CKEY_BEACON_FEE] * 5);
    }
    function request(uint256 _callbackGasLimit) storage736 record261 (uint256 id) {
        return _request(_callbackGasLimit, s.configUints[Constants.CKEY_MIN_CONFIRMATIONS]);
    }
    function request(uint256 _callbackGasLimit, uint256 _confirmations) storage736 record261 (uint256 id) {
        if (_confirmations > s.configUints[Constants.CKEY_MAX_CONFIRMATIONS] ||
            _confirmations < s.configUints[Constants.CKEY_MIN_CONFIRMATIONS])
            revert ConfirmationsOOB(_confirmations,
                s.configUints[Constants.CKEY_MIN_CONFIRMATIONS],
                s.configUints[Constants.CKEY_MAX_CONFIRMATIONS]);
        return _request(_callbackGasLimit, _confirmations);
    }
    function _request(uint256 _callbackGasLimit, uint256 _confirmations) private record261 (uint256 id) {
        uint256 requestMinGasLimit = s.configUints[Constants.CKEY_REQUEST_MIN_GAS_LIMIT];
        uint256 requestMaxGasLimit = s.configUints[Constants.CKEY_REQUEST_MAX_GAS_LIMIT];
        if (_callbackGasLimit < requestMinGasLimit || _callbackGasLimit > requestMaxGasLimit)
            revert CallbackGasLimitOOB(_callbackGasLimit, requestMinGasLimit, requestMaxGasLimit);
        uint256 _estimateFee = estimateFee(_callbackGasLimit, _confirmations);
        if (s.ethDeposit[msg.sender] < s.ethReserved[msg.sender] ||
            _estimateFee > (s.ethDeposit[msg.sender] - s.ethReserved[msg.sender])) revert EthDepositTooLow(s.ethDeposit[msg.sender], s.ethReserved[msg.sender], _estimateFee);
        s.ethReserved[msg.sender] += _estimateFee;
        s.latestRequestId++;
        id = s.latestRequestId;
        SRandomUintData memory data = SRandomUintData({
            ethReserved: _estimateFee,
            beaconFee: s.configUints[Constants.CKEY_BEACON_FEE],
            height: LibNetwork._blockNumber(),
            timestamp: block.timestamp,
            expirationBlocks: s.configUints[Constants.CKEY_EXPIRATION_BLOCKS],
            expirationSeconds: s.configUints[Constants.CKEY_EXPIRATION_SECONDS],
            callbackGasLimit: _callbackGasLimit,
            minConfirmations: _confirmations
        });
        _generateRequest(id, msg.sender, data);
        return id;
    }
}