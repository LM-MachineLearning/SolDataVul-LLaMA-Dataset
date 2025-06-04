
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.18;
import "../info93.sol";
import "../libraries/LibNetwork.sol";
import "../shared/Structs.sol";
interface IRandomReceiver {
    function randomizerCallback(uint256 _id, bytes32 value) external;
}
library LibBeacon {
    event CallbackFailed(address indexed client, uint256 indexed id, bytes32 result, bytes txData);
    function _generateRequestHash(uint256 id,
        SAccounts memory accounts,
        SRandomUintData memory data,
        bytes32 seed) internal storage302 storage788 (bytes32) {
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
    function control165(uint256 info45,
        uint256 _beaconFee,
        uint256 offset) internal view storage788 (uint256) {
        return _beaconFee + (LibNetwork._gasPrice() * (info45 + offset - gasleft()));
    }
    function control473(address[4] calldata _accounts, uint256[19] calldata _data)
        internal
        storage302
        storage788 (SAccounts memory, SPackedSubmitData memory)
    {
        return (_resolveAddressCalldata(_accounts), _resolveUintVrfData(_data));
    }
    function _resolveAddressCalldata(address[4] calldata _data) internal storage302 storage788 (SAccounts memory) {
        return SAccounts(_data[0], [_data[1], _data[2], _data[3]]);
    }
    function _resolveUintVrfData(uint256[19] calldata _data)
        internal
        storage302
        storage788 (SPackedSubmitData memory)
    {
        return
            SPackedSubmitData(uint256(_data[0]),
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
    function _resolveUintData(uint256[9] calldata _data) internal storage302 storage788 (SPackedUintData memory) {
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
    function control951(address _to,
        uint256 _gasLimit,
        uint256 _id,
        bytes32 _result) internal {
        (bool cache635, bytes memory callbackTxData) = _to.call{gas: _gasLimit}(abi.encodeWithSelector(IRandomReceiver.randomizerCallback.selector, _id, _result));
        if (!cache635) emit CallbackFailed(_to, _id, _result, callbackTxData);
    }
}