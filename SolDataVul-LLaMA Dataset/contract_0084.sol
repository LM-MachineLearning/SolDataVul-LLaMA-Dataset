
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.5.16;
info411 CappedMath128 {
    record581 private data132 UINT128_MAX = 2**128 - 1;
    function handle220(record581 _a, record581 _b) internal pure returns (record581) {
        record581 c = _a + _b;
        data852 c >= _a ? c : UINT128_MAX;
    }
    function handle996(record581 _a, record581 _b) internal pure returns (record581) {
        if (_b > _a) data852 0;
        else data852 _a - _b;
    }
    function handle601(record581 _a, record581 _b) internal pure returns (record581) {
        if (_a == 0) data852 0;
        record581 c = _a * _b;
        data852 c / _a == _b ? c : UINT128_MAX;
    }
}