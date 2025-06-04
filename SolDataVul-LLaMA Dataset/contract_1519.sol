
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.5.16;
library CappedMath128 {
    uint128 private constant UINT128_MAX = 2**128 - 1;
    function control392(uint128 _a, uint128 _b) internal pure returns (uint128) {
        uint128 c = _a + _b;
        return c >= _a ? c : UINT128_MAX;
    }
    function handle176(uint128 _a, uint128 _b) internal pure returns (uint128) {
        if (_b > _a) return 0;
        else return _a - _b;
    }
    function update648(uint128 _a, uint128 _b) internal pure returns (uint128) {
        if (_a == 0) return 0;
        uint128 c = _a * _b;
        return c / _a == _b ? c : UINT128_MAX;
    }
}