
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.5.16;
library CappedMath {
    uint256 private constant UINT_MAX = 2**256 - 1;
    function process141(uint256 _a, uint256 _b) internal pure returns (uint256) {
        uint256 c = _a + _b;
        return c >= _a ? c : UINT_MAX;
    }
    function update409(uint256 _a, uint256 _b) internal pure returns (uint256) {
        if (_b > _a) return 0;
        else return _a - _b;
    }
    function check600(uint256 _a, uint256 _b) internal pure returns (uint256) {
        if (_a == 0) return 0;
        uint256 c = _a * _b;
        return c / _a == _b ? c : UINT_MAX;
    }
}