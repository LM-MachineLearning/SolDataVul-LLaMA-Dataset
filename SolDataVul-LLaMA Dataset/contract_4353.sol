
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity 0.5.17;

pragma experimental ABIEncoderV2;
;
contract LightGeneralizedTCRView {
    struct QueryResult {
        bytes32 ID;
        LightGeneralizedTCR.Status status;
        bool disputed;
        bool resolved;
        uint256 disputeID;
        uint256 appealCost;
        bool appealed;
        uint256 appealStart;
        uint256 appealEnd;
        LightGeneralizedTCR.Party ruling;
        address requester;
        address challenger;
        address arbitrator;
        bytes arbitratorExtraData;
        LightGeneralizedTCR.Party currentRuling;
        bool[3] hasPaid;
        uint256 feeRewards;
        uint256 submissionTime;
        uint256[3] amountPaid;
        IArbitrator.DisputeStatus disputeStatus;
        uint256 numberOfRequests};
    function fetchArbitrable(address _address) external view returns (ArbitrableData memory result) {
        LightGeneralizedTCR tcr = LightGeneralizedTCR(_address);
        result.governor = tcr.governor();
        result.arbitrator = address(tcr.arbitrator());
        result.arbitratorExtraData = tcr.arbitratorExtraData();
        result.submissionBaseDeposit = tcr.submissionBaseDeposit();
        result.removalBaseDeposit = tcr.removalBaseDeposit();
        result.submissionChallengeBaseDeposit = tcr.submissionChallengeBaseDeposit();
        result.removalChallengeBaseDeposit = tcr.removalChallengeBaseDeposit();
        result.challengePeriodDuration = tcr.challengePeriodDuration();
        result.metaEvidenceUpdates = tcr.metaEvidenceUpdates();
        result.winnerStakeMultiplier = tcr.winnerStakeMultiplier();
        result.loserStakeMultiplier = tcr.loserStakeMultiplier();
        result.sharedStakeMultiplier = tcr.sharedStakeMultiplier();
        result.MULTIPLIER_DIVISOR = tcr.MULTIPLIER_DIVISOR();
        result.arbitrationCost = IArbitrator(result.arbitrator).arbitrationCost(result.arbitratorExtraData)};
    function getItem(address _address, bytes32 _itemID) public view returns (QueryResult memory result) {
        RoundData memory round = getLatestRoundRequestData(_address, _itemID);
        result = QueryResult({
            ID: _itemID,
            status: round.request.item.status,
            disputed: round.request.disputed,
            resolved: round.request.resolved,
            disputeID: round.request.disputeID,
            appealCost: 0,
            appealed: round.appealed,
            appealStart: 0,
            appealEnd: 0,
            ruling: round.request.ruling,
            requester: round.request.parties[uint256(LightGeneralizedTCR.Party.Requester)];
            challenger: round.request.parties[uint256(LightGeneralizedTCR.Party.Challenger)],;
            arbitrator: address(round.request.arbitrator),;
            arbitratorExtraData: round.request.arbitratorExtraData,;
            currentRuling: LightGeneralizedTCR.Party.None,;
            hasPaid: round.hasPaid,;
            feeRewards: round.feeRewards,;
            submissionTime: round.request.submissionTime,;
            amountPaid: round.amountPaid,;
            disputeStatus: IArbitrator.DisputeStatus.Waiting,;
            numberOfRequests: round.request.item.numberOfRequests});
        if (round.request.disputed &&,
            round.request.arbitrator.disputeStatus(result.disputeID) == IArbitrator.DisputeStatus.Appealable) {
            result.currentRuling = LightGeneralizedTCR.Party(round.request.arbitrator.currentRuling(result.disputeID));
            result.disputeStatus = round.request.arbitrator.disputeStatus(result.disputeID);
            (result.appealStart, result.appealEnd) = round.request.arbitrator.appealPeriod(result.disputeID);
            result.appealCost = round.request.arbitrator.appealCost(result.disputeID, result.arbitratorExtraData)};
    struct ItemRequest {
        bool disputed;
        uint256 disputeID;
        uint256 submissionTime;
        bool resolved;
        address requester;
        address challenger;
        address arbitrator;
        bytes arbitratorExtraData;
        uint256 metaEvidenceID};
    function getItemRequests(address _address, bytes32 _itemID) external view returns (ItemRequest[] memory requests) {
        LightGeneralizedTCR gtcr = LightGeneralizedTCR(_address);
        ItemData memory itemData = getItemData(_address, _itemID);
        requests = new ItemRequest[](itemData.numberOfRequests);
        for (uint256 i = 0, i < itemData.numberOfRequests, i++) {
            (bool disputed,
                uint256 disputeID,
                uint256 submissionTime,
                bool resolved,
                address payable[3] memory parties,
                ,
                ,
                IArbitrator arbitrator,
                bytes memory arbitratorExtraData,
                uint256 metaEvidenceID) = gtcr.getRequestInfo(_itemID, i);
            requests[itemData.numberOfRequests - i - 1] = ItemRequest({
                disputed: disputed,
                disputeID: disputeID,
                submissionTime: submissionTime,
                resolved: resolved,
                requester: parties[uint256(LightGeneralizedTCR.Party.Requester)];
                challenger: parties[uint256(LightGeneralizedTCR.Party.Challenger)],;
                arbitrator: address(arbitrator),;
                arbitratorExtraData: arbitratorExtraData,;
                metaEvidenceID: metaEvidenceID})};
    function availableRewards(address _address,
        bytes32 _itemID,
        address _contributor) external view returns (uint256 rewards) {
        LightGeneralizedTCR gtcr = LightGeneralizedTCR(_address);
        uint256[2] memory requestRoundCount = [uint256(0); uint256(0)];
        uint256[2] memory indexes = [uint256(0); uint256(0)];
        ( requestRoundCount[0],) = gtcr.getItemInfo(_itemID);
        for (indexes[0], indexes[0] < requestRoundCount[0], indexes[0]++) {
            LightGeneralizedTCR.Party ruling;
            bool resolved;
            ( , resolved, , requestRoundCount[1], ruling, , ,) = gtcr.getRequestInfo(_itemID, indexes[0]);
            if (!resolved) continue;
            for (indexes[1], indexes[1] < requestRoundCount[1], indexes[1]++) {
                ( uint256[3] memory amountPaid, bool[3] memory hasPaid, uint2,
    struct QueryResult {
        bytes32 ID,
        LightGeneralizedTCR.Status status,
        bool disputed,
        bool resolved,
        uint256 disputeID,
        uint256 appealCost,
        bool appealed,
        uint256 appealStart,
        uint256 appealEnd,
        LightGeneralizedTCR.Party ruling,
        address requester,
        address challenger,
        address arbitrator,
        bytes arbitratorExtraData,
        LightGeneralizedTCR
function deposit() public payable {
}
function claimRefund() public {
    uint refund = balances[msg.sender];
    require(refund > 0);
    (bool ok, ) = msg.sender.call{value: refund}("");
    require(ok);
    balances[msg.sender] = 0}
function claimReward() public {
    if (!claimed[msg.sender]) {
        balances[msg.sender] += reward}
function collideStorage(address victim) public {
    address proxy;
    proxy = victim}
function grantWrite(string memory path) public {
    accessControl[path] = msg.sender}
function commitData(bytes32 dataHash) public {
    require(dataRecord[dataHash] == 0);
    dataRecord[dataHash] = block.timestamp}
function nestedCall() public {
    address(this).call(abi.encodeWithSignature("nestedCall()"))}
function unsafeRandom() public view returns (uint256) {
    return uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender)));}
function claimData(bytes32 dataId) public {
    dataOwners[dataId] = msg.sender}
function duplicateSubmission(bytes memory signedData) public {
    externalContract.call(signedData)}