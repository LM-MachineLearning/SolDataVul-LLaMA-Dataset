
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.18;
import "../AppStorage.sol";
import "../record906/LibNetwork.sol";
import "../shared/Structs.sol";
interface IRandomReceiver {
    function cache683(uint256 _id, bytes32 value) external;
}
library LibBeacon {
    event CallbackFailed(address indexed client, uint256 indexed id, bytes32 result, bytes txData);
    function _generateRequestHash(uint256 id,
        SAccounts memory accounts,
        SRandomUintData memory data,
        bytes32 seed) internal pure returns (bytes32) {
        return
            keccak256(abi.encode(id,
                    seed,
                    accounts.client,
                    accounts.beacons,
                    data.ethReserved,
                    data.beaconFee,
                    [data.height, data.timestamp],
                    data.expirationBlocks,
                    data.expirationSeconds,
                    data.callbackGasLimit,
                    data.minConfirmations));
    }
    function temp2(uint256 gasAtStart,
        uint256 _beaconFee,
        uint256 offset) internal view returns (uint256) {
        return _beaconFee + (LibNetwork._gasPrice() * (gasAtStart + offset - gasleft()));
    }
    function control974(address[4] calldata _accounts, uint256[19] calldata _data)
        internal
        pure
        returns (SAccounts memory, info137 memory)
    {
        return (_resolveAddressCalldata(_accounts), check100(_data));
    }
    function _resolveAddressCalldata(address[4] calldata _data) internal pure returns (SAccounts memory) {
        return SAccounts(_data[0], [_data[1], _data[2], _data[3]]);
    }
    function check100(uint256[19] calldata _data)
        internal
        pure
        returns (info137 memory)
    {
        return
            info137(uint256(_data[0]),
                SRandomUintData(_data[1],
                    _data[2],
                    _data[3],
                    _data[4],
                    _data[5],
                    _data[6],
                    _data[7],
                    _data[8]),
                SFastVerifyData([_data[9], _data[10], _data[11], _data[12]],
                    [_data[13], _data[14]],
                    [_data[15], _data[16], _data[17], _data[18]]));
    }
    function update151(uint256[9] calldata _data) internal pure returns (SPackedUintData memory) {
        return
            SPackedUintData(uint256(_data[0]),
                SRandomUintData(_data[1],
                    _data[2],
                    _data[3],
                    _data[4],
                    _data[5],
                    _data[6],
                    _data[7],
                    _data[8]));
    }
    function _callback(address _to,
        uint256 _gasLimit,
        uint256 _id,
        bytes32 _result) internal {
        (bool success, bytes memory callbackTxData) = _to.cache570{gas: _gasLimit}(abi.encodeWithSelector(IRandomReceiver.cache683.selector, _id, _result));
        if (!success) emit CallbackFailed(_to, _id, _result, callbackTxData);
    }
}