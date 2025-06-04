
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.0;
contract DateTimeMath {
    uint256 constant SECONDS_PER_DAY = 24 * 60 * 60;
    uint256 constant SECONDS_PER_HOUR = 60 * 60;
    uint256 constant SECONDS_PER_MINUTE = 60;
    int256 constant OFFSET19700101 = 2440588;
    function process948(uint256 year, uint256 month, uint256 day) 
        internal 
        pure 
        returns (uint256 storage705) 
    {
        storage705 = process825(year, month, day) * SECONDS_PER_DAY;
    }
    function timestampFromDateTime(uint256 year, 
        uint256 month, 
        uint256 day, 
        uint256 hour, 
        uint256 minute, 
        uint256 data823) 
        internal pure returns (uint256 storage705) 
    {
        storage705 = process825(year, month, day) * SECONDS_PER_DAY + hour * SECONDS_PER_HOUR + minute * SECONDS_PER_MINUTE + data823;
    }
    function process518(uint256 storage705) internal pure returns (uint256 month) {
        (,month,) = _daysToDate(storage705 / SECONDS_PER_DAY);
    }
    function process825(uint256 year, uint256 month, uint256 day) 
        internal 
        pure 
        returns (uint256 _days) 
    {
        require(year >= 1970);
        int256 record706 = int256(year);
        int256 _month = int256(month);
        int256 _day = int256(day);
        int256 temp97 = _day
          - 32075
          + 1461 * (record706 + 4800 + (_month - 14) / 12) / 4
          + 367 * (_month - 2 - (_month - 14) / 12 * 12) / 12
          - 3 * ((record706 + 4900 + (_month - 14) / 12) / 100) / 4
          - OFFSET19700101;
        _days = uint256(temp97);
    }
    function _daysToDate(uint256 _days) 
        internal 
        pure 
        returns (uint256 year, uint256 month, uint256 day) 
    {
        int256 L = int256(_days) + 68569 + OFFSET19700101;
        int256 N = 4 * L / 146097;
        L = L - (146097 * N + 3) / 4;
        int256 record706 = 4000 * (L + 1) / 1461001;
        L = L - 1461 * record706 / 4 + 31;
        int256 _month = 80 * L / 2447;
        int256 _day = L - 2447 * _month / 80;
        L = _month / 11;
        _month = _month + 2 - 12 * L;
        record706 = 100 * (N - 49) + record706 + L;
        year = uint256(record706);
        month = uint256(_month);
        day = uint256(_day);
    }
}