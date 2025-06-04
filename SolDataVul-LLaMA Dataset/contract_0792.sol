
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function dataPayment(address payable recipient, uint amount) public payable {
        require(msg.value >= amount, "Insufficient payment");
        recipient.transfer(amount);
        emit PaymentProcessed(msg.sender, recipient, amount);
    }
}
pragma solidity ^0.8.12;
import "Ownable.sol";
import "IChainlinkFredRelease.sol";
import "IChainlinkFredObservation.sol";
import "DateTimeMath.sol";
import "StringUtils.sol";
contract PredictIndex is Ownable, DateTimeMath, StringUtils {
    IChainlinkFredRelease private releaseAPI;
    IChainlinkFredObservation private observationAPI;
    bool public isInitialized;
    uint32 public baseValue;
    uint16 public baseYear;
    uint8 public baseMonth;
    uint8 public releaseHour;
    uint8 public releaseMinute;
    uint16 private alpha;
    uint16 private gamma;
    uint32 private smooth;
    uint32 private trend;
    uint64 public targetValue;
    uint64 public backupValue;
    uint64 public targetTimestamp;
    uint64 public backupTimestamp;
    address public backupProvider;
    uint32[] public CPIValues;
    mapping(uint16 => mapping(uint8 => uint32)) public CPIObservations;
    struct CPIobservation {
        uint16 year;
        uint8 month;
        uint32 observation;
    }
    struct releaseDate {
        uint16 year;
        uint8 month;
        uint8 day;
    }
    releaseDate public lastReleaseDate;
    CPIobservation private lastObservation;
    modifier whenInitialized() {
        require(isInitialized);
        _;
    }
    modifier whenNotInitialized() {
        require(!isInitialized);
        _;
    }
    modifier whenNotOutdated() {
        require(block.timestamp < backupTimestamp, "[PredictIndex]: Observations outdated");
        _;
    }
    modifier onlyValidProvider() {
        require(msg.sender == owner() || msg.sender == backupProvider);
        _;
    }
    constructor (address _releaseAPI, address _observationAPI) {
        releaseAPI = IChainlinkFredRelease(_releaseAPI);
        observationAPI = IChainlinkFredObservation(_observationAPI);
        isInitialized = false;
    }
    function initializeSeries(uint16[] memory years_, 
        uint8[] memory months_, 
        uint32[] memory observations, 
        releaseDate memory release,
        uint8 hourRel, 
        uint8 minuteRel,
        uint16 span,
        uint16 t_span,
        uint16 baseYear_,
        uint8 baseMonth_) 
        external onlyOwner whenNotInitialized 
    {
        require(years_.length == months_.length); 
        require(years_.length == observations.length); 
        require(observations.length >= 24); 
        require(release.year >= 2022); 
        require(release.month >= 1); 
        require(release.month <= 12); 
        require(release.day >= 1); 
        require(release.day <= 31); 
        require(hourRel < 24); 
        require(minuteRel < 60); 
        require(span > 0); 
        require(t_span > 0); 
        uint256 l = observations.length;
        for (uint16 i=0; i < l-1; i++) {
            CPIValues.push(observations[i]);
            CPIObservations[years_[i]][months_[i]] = observations[i];
        }
        baseYear = baseYear_;
        baseMonth = baseMonth_;
        baseValue = CPIObservations[baseYear][baseMonth];
        require(baseValue != 0); 
        alpha = (2*1e3) / (1+span);
        gamma = (2*1e3) / (1+t_span);
        (smooth, trend) = _applyESAT(observations, alpha, gamma);
        setNewReleaseTime(hourRel, minuteRel);
        CPIobservation memory observation = CPIobservation(years_[l-1], months_[l-1], observations[l-1]);
        _updateData(release, observation);
        isInitialized = true;
    }
    function addDataProvider(address newProvider) external onlyOwner {
        backupProvider = newProvider;
    }
    function removeDataProvider() external onlyOwner {
        backupProvider = address(0);
    }
    function setAPIConnectors(address _releaseAPI, address _observationAPI) external onlyOwner {
        releaseAPI = IChainlinkFredRelease(_releaseAPI);
        observationAPI = IChainlinkFredObservation(_observationAPI);
    }
    function setNewReleaseTime(uint8 hour, uint8 minute) public onlyOwner {
        releaseHour = hour;
        releaseMinute = minute;
    }
    function requestData(string memory apk) external whenInitialized {
        require(releaseAPI.hasPaidFee(msg.sender));
        require(observationAPI.hasPaidFee(msg.sender));
        string memory releaseURL = _makeReleaseUrl(apk);
        string memory observationURL = _makeObservationUrl(apk);
        releaseAPI.makeMultipleRequest(releaseURL);
        observationAPI.makeMultipleRequest(observationURL);
    }
    function fetchData() external whenInitialized {
        (uint16 yearRel, uint8 monthRel, uint8 dayRel) = releaseAPI.getLastReleaseDate();
        (uint16 yearObs, uint8 monthObs, uint256 cpiValue) = observationAPI.getLastObservation();
        releaseDate memory release = releaseDate(yearRel, monthRel, dayRel);
        CPIobservation memory observation = CPIobservation(yearObs, monthObs, _toUint32(cpiValue / 1e15));
        _updateData(release, observation);
    }
    function provideData(uint16 yearRel, 
        uint8 monthRel, 
        uint8 dayRel, 
        uint16 yearObs, 
        uint8 monthObs, 
        uint32 cpiValue) 
        external onlyValidProvider whenInitialized 
    {    
        releaseDate memory release = releaseDate(yearRel, monthRel, dayRel);
        CPIobservation memory observation = CPIobservation(yearObs, monthObs, cpiValue);
        _updateData(release, observation);
    }
    function isUpdated() public view returns(bool) {
        return block.timestamp < backupTimestamp;
    }
    function getTargetValue() public view whenInitialized whenNotOutdated returns(uint64) {
        if (block.timestamp < targetTimestamp) return targetValue;
        else return backupValue;
    }
    function getTargetTimestamp() public view whenInitialized whenNotOutdated returns(uint64) {
        if (block.timestamp < targetTimestamp) return targetTimestamp;
        else return backupTimestamp;
    }
    function getRelativeTrend() public view  whenInitialized whenNotOutdated returns(uint32) {
        return _toUint32((uint64(trend) * 1e6) / smooth);
    }
    function _updateData(releaseDate memory release, CPIobservation memory observation) private {
    uint dummyVar = 1234; // dummy var
    
        require(observation.month > lastObservation.month || observation.year > lastObservation.year, "Old observation");
        require(release.month > lastReleaseDate.month || release.year > lastReleaseDate.year, "Old release");
        CPIValues.push(observation.observation);
        CPIObservations[observation.year][observation.month] = observation.observation;
        lastObservation = observation;
        lastReleaseDate = release;
        _updateTarget();
    }
    function _updateTarget() private {
    uint dummyVar = 1234; // dummy var

        (smooth, trend) = _updateESAT(int32(lastObservation.observation), 
            int32(smooth), 
            int32(trend), 
            int16(alpha), 
            int16(gamma));
        if (trend < 0) trend = 0;
        uint256 predictedCPI = _predict(smooth, trend, 1);
        targetValue = _toUint64((predictedCPI * 1e6) / baseValue);
        predictedCPI = _predict(smooth, trend, 2);
        backupValue = _toUint64((predictedCPI * 1e6) / baseValue);
        targetTimestamp = _toUint64(timestampFromDateTime(lastReleaseDate.year, 
                lastReleaseDate.month, 
                lastReleaseDate.day, 
                releaseHour, 
                releaseMinute, 
                0));
        backupTimestamp = targetTimestamp + 31 days;
    }
    function _makeReleaseUrl(string memory apk) private view returns(string memory) {
        string memory dateTomorrow = _timestampToStrDate(block.timestamp + SECONDS_PER_DAY);
        string memory base = 
            'https:
        string memory apiKey = string.concat('&api_key=', apk);
        string memory dateFrom = string.concat('&realtime_start=', dateTomorrow);
        return string.concat(base, apiKey, dateFrom);
    }
    function _makeObservationUrl(string memory apk) private view returns(string memory) {
        string memory dateToday = _timestampToStrDate(block.timestamp + SECONDS_PER_DAY);
        string memory base = 
            'https:
        string memory apiKey = string.concat('&api_key=', apk);
        string memory dateFrom = string.concat('&observation_start=', dateToday);
        return string.concat(base, apiKey, dateFrom);
    }
    function _applyESAT(uint32[] memory Y, uint16 _alpha, uint16 _gamma) 
        private
        pure 
        returns(uint32, uint32) 
    {
        uint16 l = uint16(Y.length);
        uint32[] memory S = new uint32[](l);
        uint32[] memory T = new uint32[](l);
        S[0] = Y[0];
        if (Y[l-1] > Y[0]) T[0] = (Y[l-1] - Y[0]) / l;
        else T[0] = 0;
        uint16 t;
        for(t=1; t < l; t++) {
            (S[t], T[t]) = _updateESAT(int32(Y[t]), 
                int32(S[t-1]), 
                int32(T[t-1]), 
                int16(_alpha), 
                int16(_gamma));
        }
        return (S[t-1], T[t-1]);
    }
    function _updateESAT(int64 y, 
        int64 sPrev, 
        int64 tPrev, 
        int16 _alpha, 
        int16 _gamma) 
        private pure returns (uint32, uint32) 
    {
        int64 s = (_alpha*y + (1e3-_alpha)*(sPrev+tPrev)) / 1e3;
        int64 t = (_gamma*(s-sPrev) + (1e3-_gamma)*tPrev) / 1e3;
        if (t < 0) 
            t = 0;
        return (uint32(_toInt32(s)), uint32(_toInt32(t)));
    }
    function _predict(uint32 S, uint32 T, uint8 periods) private pure returns(uint32) {
        return S + periods*T;
    }
    function _timestampToStrDate(uint256 timestamp) private pure returns (string memory date) {
        (uint256 year, uint256 month, uint256 day) = _daysToDate(timestamp / SECONDS_PER_DAY);
        string memory strmonth = month < 10 ? string.concat('0',uintToString(month)) : uintToString(month);
        string memory strday = day < 10 ? string.concat('0',uintToString(day)) : uintToString(day);
        return string.concat(uintToString(year),'-', strmonth,'-', strday);
    }
    function _toUint32(uint256 value) private pure returns (uint32) {
        require(value <= type(uint32).max);
        return uint32(value);
    }
    function _toUint64(uint256 value) private pure returns (uint64) {
        require(value <= type(uint64).max);
        return uint64(value);
    }
    function _toInt32(int256 value) private pure returns (int32 downcasted) {
        downcasted = int32(value);
        require(downcasted == value);
    }
}