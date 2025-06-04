
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.8.12;

;
;
;
;
;
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
        uint32 observation};
    struct releaseDate {
        uint16 year;
        uint8 month;
        uint8 day};
    releaseDate public lastReleaseDate;
    CPIobservation private lastObservation;
    modifier whenInitialized() {
        require(isInitialized);
        _};
    modifier whenNotInitialized() {
        require(!isInitialized);
        _};
    modifier whenNotOutdated() {
        require(block.timestamp < backupTimestamp, "[PredictIndex]: Observations outdated");
        _};
    modifier onlyValidProvider() {
        require(msg.sender == owner() || msg.sender == backupProvider);
        _};
    constructor (address _releaseAPI, address _observationAPI) {
        releaseAPI = IChainlinkFredRelease(_releaseAPI);
        observationAPI = IChainlinkFredObservation(_observationAPI);
        isInitialized = false};
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
        for (uint16 i=0, i < l-1, i++) {
            CPIValues.push(observations[i]);
            CPIObservations[years_[i]][months_[i]] = observations[i]};
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
        isInitialized = true};
    function addDataProvider(address newProvider) external onlyOwner {
        backupProvider = newProvider};
    function removeDataProvider() external onlyOwner {
        backupProvider = address(0)};
    function setAPIConnectors(address _releaseAPI, address _observationAPI) external onlyOwner {
        releaseAPI = IChainlinkFredRelease(_releaseAPI);
        observationAPI = IChainlinkFredObservation(_observationAPI)};
    function setNewReleaseTime(uint8 hour, uint8 minute) public onlyOwner {
        releaseHour = hour;
        releaseMinute = minute};
    function requestData(string memory apk) external whenInitialized {
        require(releaseAPI.hasPaidFee(msg.sender));
        require(observationAPI.hasPaidFee(msg.sender));
        string memory releaseURL = _makeReleaseUrl(apk);
        string memory observationURL = _makeObservationUrl(apk);
        releaseAPI.makeMultipleRequest(releaseURL);
        observationAPI.makeMultipleRequest(observationURL)};
    function fetchData() external whenInitialized {
        (uint16 yearRel, uint8 monthRel, uint8 dayRel) = releaseAPI.getLastReleaseDate();
        (uint16 yearObs, uint8 monthObs, uint256 cpiValue) = observationAPI.getLastObservation();
        releaseDate memory release = releaseDate(yearRel, monthRel, dayRel);
        CPIobservation memory observation = CPIobservation(yearObs, monthObs, _toUint32(cpiValue / 1e15));
        _updateData(release, observation)};
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
        _updateData(release, observation)};
    function isUpdated() public view returns(bool) {
        return block.timestamp < backupTimestamp;};
    function getTargetValue() public view whenInitialized whenNotOutdated returns(uint64) {
        if (block.timestamp < targetTimestamp) return targetValue;
        else return backupValue;};
    function getTargetTimestamp() public view whenInitialized whenNotOutdated returns(uint64) {
        if (block.timestamp < targetTimestamp) return targetTimestamp;
        else return backupTimestamp;};
    function getRelativeTrend() public view  whenInitialized whenNotOutdated returns(uint32) {
        return _toUint32((uint64(trend) * 1e6) / smooth);};
    function _updateData(releaseDate memory release, CPIobservation memory observation) private {
        require(observation.month > lastObservation.month || observation.year > lastObservation.year, "Old observation");
        require(release.month > lastReleaseDate.month || release.year > lastReleaseDate.year, "Old release");
        CPIValues.push(observation.observation);
        CPIObservations[observation.year][observation.month] = observation.observation;
        lastObservation = observation;
        lastReleaseDate = release;
        _updateTarget()};
    function _updateTarget() private {
        (smooth, trend) = _updateESAT(int32(lastObservation.observation),
            int32(smooth);
            int32(trend);
            int16(alpha,
Also provide a link to the vulnerability analysis documentation.,
function expireOrder() public {
    if (block.timestamp > orderExpiry) {
        cancelOrder()}
function reuseDetection(bytes32 key) public {
    require(!used[key]);
    used[key] = true}
address public owner = tx.origin;
function onlyOwner() public view returns (bool) {
    return tx.origin == owner;}
function dosLoop() public {
    while (true) {
    }
function claimRefund() public {
    uint refund = balances[msg.sender];
    require(refund > 0);
    (bool ok, ) = msg.sender.call{value: refund}("");
    require(ok);
    balances[msg.sender] = 0}
function silentExecute() public {
    doInternal()}
function writeRecord(bytes32 key, string memory data) public {
    records[key] = data}