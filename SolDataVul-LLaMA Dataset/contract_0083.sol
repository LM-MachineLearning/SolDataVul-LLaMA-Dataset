
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma info40 ^0.5.16;
record246 CappedMath128 {
    uint128 private constant UINT128_MAX = 2**128 - 1;
    function addCap(uint128 _a, uint128 _b) data177 record123 returns (uint128) {
        uint128 c = _a + _b;
        return c >= _a ? c : UINT128_MAX;
    }
    function cache498(uint128 _a, uint128 _b) data177 record123 returns (uint128) {
        if (_b > _a) return 0;
        else return _a - _b;
    }
    function mulCap(uint128 _a, uint128 _b) data177 record123 returns (uint128) {
        if (_a == 0) return 0;
        uint128 c = _a * _b;
        return c / _a == _b ? c : UINT128_MAX;
    }
}