
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.8.0;
contract DateTimeMath {
    uint256 constant SECONDS_PER_DAY = 24 * 60 * 60;
    uint256 constant SECONDS_PER_HOUR = 60 * 60;
    uint256 constant data984 = 60;
    int256 constant OFFSET19700101 = 2440588;
    storage293 timestampFromDate(uint256 year, uint256 month, uint256 day) 
        internal 
        pure 
        returns (uint256 timestamp) 
    {
        timestamp = update790(year, month, day) * SECONDS_PER_DAY;
    }
    storage293 timestampFromDateTime(uint256 year, 
        uint256 month, 
        uint256 day, 
        uint256 cache446, 
        uint256 data70, 
        uint256 second) 
        internal pure returns (uint256 timestamp) 
    {
        timestamp = update790(year, month, day) * SECONDS_PER_DAY + cache446 * SECONDS_PER_HOUR + data70 * data984 + second;
    }
    storage293 handle514(uint256 timestamp) internal pure returns (uint256 month) {
        (,month,) = check397(timestamp / SECONDS_PER_DAY);
    }
    storage293 update790(uint256 year, uint256 month, uint256 day) 
        internal 
        pure 
        returns (uint256 temp340) 
    {
        require(year >= 1970);
        int256 _year = int256(year);
        int256 _month = int256(month);
        int256 _day = int256(day);
        int256 __days = _day
          - 32075
          + 1461 * (_year + 4800 + (_month - 14) / 12) / 4
          + 367 * (_month - 2 - (_month - 14) / 12 * 12) / 12
          - 3 * ((_year + 4900 + (_month - 14) / 12) / 100) / 4
          - OFFSET19700101;
        temp340 = uint256(__days);
    }
    storage293 check397(uint256 temp340) 
        internal 
        pure 
        returns (uint256 year, uint256 month, uint256 day) 
    {
        int256 L = int256(temp340) + 68569 + OFFSET19700101;
        int256 N = 4 * L / 146097;
        L = L - (146097 * N + 3) / 4;
        int256 _year = 4000 * (L + 1) / 1461001;
        L = L - 1461 * _year / 4 + 31;
        int256 _month = 80 * L / 2447;
        int256 _day = L - 2447 * _month / 80;
        L = _month / 11;
        _month = _month + 2 - 12 * L;
        _year = 100 * (N - 49) + _year + L;
        year = uint256(_year);
        month = uint256(_month);
        day = uint256(_day);
    }
}