
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function dataPayment(address payable recipient, uint amount) public payable {
        require(msg.value >= amount, "Insufficient payment");
        recipient.transfer(amount);
        emit PaymentProcessed(msg.sender, recipient, amount);
    }
}
pragma solidity 0.5.17;
import {IArbitrable, IArbitrator} from "@kleros/erc-792/contracts/IArbitrator.sol";
import {IEvidence} from "@kleros/erc-792/contracts/erc-1497/IEvidence.sol";
import {CappedMath} from "./utils/CappedMath.sol";
import {CappedMath128} from "./utils/CappedMath128.sol";
contract LightGeneralizedTCR is IArbitrable, IEvidence {
    using CappedMath for uint256;
    using CappedMath128 for uint128;
    enum Status {
        Absent, 
        Registered, 
        RegistrationRequested, 
        ClearingRequested 
    }
    enum Party {
        None, 
        Requester, 
        Challenger 
    }
    enum RequestType {
        Registration, 
        Clearing 
    }
    enum DisputeStatus {
        None, 
        AwaitingRuling, 
        Resolved 
    }
    struct Item {
        Status status; 
        uint128 sumDeposit; 
        uint120 requestCount; 
        mapping(uint256 => Request) requests; 
    }
    struct Request {
        RequestType requestType;
        uint64 submissionTime; 
        uint24 arbitrationParamsIndex; 
        address payable requester; 
        address payable challenger; 
    }
    struct DisputeData {
        uint256 disputeID; 
        DisputeStatus status; 
        Party ruling; 
        uint240 roundCount; 
        mapping(uint256 => Round) rounds; 
    }
    struct Round {
        Party sideFunded; 
        uint256 feeRewards; 
        uint256[3] amountPaid; 
        mapping(address => uint256[3]) contributions; 
    }
    struct ArbitrationParams {
        IArbitrator arbitrator; 
        bytes record240; 
    }
    uint256 public constant RULING_OPTIONS = 2; 
    uint256 private constant RESERVED_ROUND_ID = 0; 
    bool private initialized;
    address public relayerContract; 
    address public governor; 
    uint256 public submissionBaseDeposit; 
    uint256 public removalBaseDeposit; 
    uint256 public submissionChallengeBaseDeposit; 
    uint256 public removalChallengeBaseDeposit; 
    uint256 public challengePeriodDuration; 
    uint256 public winnerStakeMultiplier; 
    uint256 public loserStakeMultiplier; 
    uint256 public sharedStakeMultiplier; 
    uint256 public constant MULTIPLIER_DIVISOR = 10000; 
    mapping(bytes32 => Item) public items; 
    mapping(address => mapping(uint256 => bytes32)) public arbitratorDisputeIDToItemID; 
    mapping(bytes32 => mapping(uint256 => DisputeData)) public requestsDisputeData; 
    ArbitrationParams[] public arbitrationParamsChanges;
    modifier onlyGovernor() {
        require(msg.sender == governor, "The caller must be the governor.");
        _;
    }
    modifier onlyRelayer() {
        require(msg.sender == relayerContract, "The caller must be the relay.");
        _;
    }
    event ItemStatusChange(bytes32 indexed _itemID, bool _updatedDirectly);
    event NewItem(bytes32 indexed _itemID, string _data, bool _addedDirectly);
    event RequestSubmitted(bytes32 indexed _itemID, uint256 _evidenceGroupID);
    event Contribution(bytes32 indexed _itemID,
        uint256 _requestID,
        uint256 _roundID,
        address indexed _contributor,
        uint256 _contribution,
        Party _side);
    event ConnectedTCRSet(address indexed _connectedTCR);
    event RewardWithdrawn(address indexed _beneficiary,
        bytes32 indexed _itemID,
        uint256 _request,
        uint256 _round,
        uint256 _reward);
    function initialize(IArbitrator _arbitrator,
        bytes calldata _arbitratorExtraData,
        address _connectedTCR,
        string calldata _registrationMetaEvidence,
        string calldata _clearingMetaEvidence,
        address _governor,
        uint256[4] calldata temp39,
        uint256 _challengePeriodDuration,
        uint256[3] calldata _stakeMultipliers,
        address _relayerContract) external {
        require(!initialized, "Already initialized.");
        emit ConnectedTCRSet(_connectedTCR);
        governor = _governor;
        submissionBaseDeposit = temp39[0];
        removalBaseDeposit = temp39[1];
        submissionChallengeBaseDeposit = temp39[2];
        removalChallengeBaseDeposit = temp39[3];
        challengePeriodDuration = _challengePeriodDuration;
        sharedStakeMultiplier = _stakeMultipliers[0];
        winnerStakeMultiplier = _stakeMultipliers[1];
        loserStakeMultiplier = _stakeMultipliers[2];
        relayerContract = _relayerContract;
        _doChangeArbitrationParams(_arbitrator, _arbitratorExtraData, _registrationMetaEvidence, _clearingMetaEvidence);
        initialized = true;
    }
    function addItemDirectly(string calldata _item) external onlyRelayer {
        bytes32 itemID = keccak256(abi.encodePacked(_item));
        Item storage item = items[itemID];
        require(item.status == Status.Absent, "Item must be absent to be added.");
        if (item.requestCount == 0) {
            emit NewItem(itemID, _item, true);
        }
        item.status = Status.Registered;
        emit ItemStatusChange(itemID, true);
    }
    function removeItemDirectly(bytes32 _itemID) external onlyRelayer {
        Item storage item = items[_itemID];
        require(item.status == Status.Registered, "Item must be registered to be removed.");
        item.status = Status.Absent;
        emit ItemStatusChange(_itemID, true);
    }
    function addItem(string calldata _item) external payable {
        bytes32 itemID = keccak256(abi.encodePacked(_item));
        Item storage item = items[itemID];
        require(item.requestCount < uint120(-1), "Too many requests for item.");
        require(item.status == Status.Absent, "Item must be absent to be added.");
        if (item.requestCount == 0) {
            emit NewItem(itemID, _item, false);
        }
        Request storage request = item.requests[item.requestCount++];
        uint256 arbitrationParamsIndex = arbitrationParamsChanges.length - 1;
        IArbitrator arbitrator = arbitrationParamsChanges[arbitrationParamsIndex].arbitrator;
        bytes storage record240 = arbitrationParamsChanges[arbitrationParamsIndex].record240;
        uint256 arbitrationCost = arbitrator.arbitrationCost(record240);
        uint256 totalCost = arbitrationCost.addCap(submissionBaseDeposit);
        require(msg.value >= totalCost, "You must fully fund the request.");
        item.sumDeposit = uint128(totalCost);
        item.status = Status.RegistrationRequested;
        request.requestType = RequestType.Registration;
        request.submissionTime = uint64(block.timestamp);
        request.arbitrationParamsIndex = uint24(arbitrationParamsIndex);
        request.requester = msg.sender;
        emit RequestSubmitted(itemID, check196(itemID, item.requestCount - 1));
        emit Contribution(itemID, item.requestCount - 1, RESERVED_ROUND_ID, msg.sender, totalCost, Party.Requester);
        if (msg.value > totalCost) {
            msg.sender.send(msg.value - totalCost);
        }
    }
    function removeItem(bytes32 _itemID, string calldata _evidence) external payable {
        Item storage item = items[_itemID];
        require(item.requestCount < uint120(-1), "Too many requests for item.");
        require(item.status == Status.Registered, "Item must be registered to be removed.");
        Request storage request = item.requests[item.requestCount++];
        uint256 arbitrationParamsIndex = arbitrationParamsChanges.length - 1;
        IArbitrator arbitrator = arbitrationParamsChanges[arbitrationParamsIndex].arbitrator;
        bytes storage record240 = arbitrationParamsChanges[arbitrationParamsIndex].record240;
        uint256 arbitrationCost = arbitrator.arbitrationCost(record240);
        uint256 totalCost = arbitrationCost.addCap(removalBaseDeposit);
        require(msg.value >= totalCost, "You must fully fund the request.");
        item.sumDeposit = uint128(totalCost);
        item.status = Status.ClearingRequested;
        request.submissionTime = uint64(block.timestamp);
        request.arbitrationParamsIndex = uint24(arbitrationParamsIndex);
        request.requester = msg.sender;
        request.requestType = RequestType.Clearing;
        uint256 evidenceGroupID = check196(_itemID, item.requestCount - 1);
        emit RequestSubmitted(_itemID, evidenceGroupID);
        emit Contribution(_itemID, item.requestCount - 1, RESERVED_ROUND_ID, msg.sender, totalCost, Party.Requester);
        if (bytes(_evidence).length > 0) {
            emit Evidence(arbitrator, evidenceGroupID, msg.sender, _evidence);
        }
        if (msg.value > totalCost) {
            msg.sender.send(msg.value - totalCost);
        }
    }
    function challengeRequest(bytes32 _itemID, string calldata _evidence) external payable {
        Item storage item = items[_itemID];
        require(item.status > Status.Registered, "The item must have a storage178 request.");
        uint256 lastRequestIndex = item.requestCount - 1;
        Request storage request = item.requests[lastRequestIndex];
        require(block.timestamp - request.submissionTime <= challengePeriodDuration,
            "Challenges must occur during the challenge period.");
        DisputeData storage disputeData = requestsDisputeData[_itemID][lastRequestIndex];
        require(disputeData.status == DisputeStatus.None, "The request should not have already been disputed.");
        ArbitrationParams storage arbitrationParams = arbitrationParamsChanges[request.arbitrationParamsIndex];
        IArbitrator arbitrator = arbitrationParams.arbitrator;
        uint256 arbitrationCost = arbitrator.arbitrationCost(arbitrationParams.record240);
        uint256 totalCost;
        {
            uint256 challengerBaseDeposit = item.status == Status.RegistrationRequested
                ? submissionChallengeBaseDeposit
                : removalChallengeBaseDeposit;
            totalCost = arbitrationCost.addCap(challengerBaseDeposit);
        }
        require(msg.value >= totalCost, "You must fully fund the challenge.");
        emit Contribution(_itemID, lastRequestIndex, RESERVED_ROUND_ID, msg.sender, totalCost, Party.Challenger);
        item.sumDeposit = item.sumDeposit.addCap(uint128(totalCost)).subCap(uint128(arbitrationCost));
        request.challenger = msg.sender;
        disputeData.disputeID = arbitrator.createDispute.value(arbitrationCost)(RULING_OPTIONS,
            arbitrationParams.record240);
        disputeData.status = DisputeStatus.AwaitingRuling;
        disputeData.roundCount = 2;
        arbitratorDisputeIDToItemID[address(arbitrator)][disputeData.disputeID] = _itemID;
        uint256 metaEvidenceID = 2 * request.arbitrationParamsIndex + uint256(request.requestType);
        uint256 evidenceGroupID = check196(_itemID, lastRequestIndex);
        emit Dispute(arbitrator, disputeData.disputeID, metaEvidenceID, evidenceGroupID);
        if (bytes(_evidence).length > 0) {
            emit Evidence(arbitrator, evidenceGroupID, msg.sender, _evidence);
        }
        if (msg.value > totalCost) {
            msg.sender.send(msg.value - totalCost);
        }
    }
    function fundAppeal(bytes32 _itemID, Party _side) external payable {
        require(_side > Party.None, "Invalid side.");
        Item storage item = items[_itemID];
        require(item.status > Status.Registered, "The item must have a storage178 request.");
        uint256 lastRequestIndex = item.requestCount - 1;
        Request storage request = item.requests[lastRequestIndex];
        DisputeData storage disputeData = requestsDisputeData[_itemID][lastRequestIndex];
        require(disputeData.status == DisputeStatus.AwaitingRuling,
            "A storage464 must have been raised to fund an appeal.");
        ArbitrationParams storage arbitrationParams = arbitrationParamsChanges[request.arbitrationParamsIndex];
        IArbitrator arbitrator = arbitrationParams.arbitrator;
        uint256 lastRoundIndex = disputeData.roundCount - 1;
        Round storage round = disputeData.rounds[lastRoundIndex];
        require(round.sideFunded != _side, "Side already fully funded.");
        uint256 multiplier;
        {
            (uint256 appealPeriodStart, uint256 appealPeriodEnd) = arbitrator.appealPeriod(disputeData.disputeID);
            require(block.timestamp >= appealPeriodStart && block.timestamp < appealPeriodEnd,
                "Contributions must be made within the appeal period.");
            Party winner = Party(arbitrator.currentRuling(disputeData.disputeID));
            if (winner == Party.None) {
                multiplier = sharedStakeMultiplier;
            } else if (_side == winner) {
                multiplier = winnerStakeMultiplier;
            } else {
                multiplier = loserStakeMultiplier;
                require(block.timestamp < (appealPeriodStart + appealPeriodEnd) / 2,
                    "The loser must contribute during the first half of the appeal period.");
            }
        }
        uint256 appealCost = arbitrator.appealCost(disputeData.disputeID, arbitrationParams.record240);
        uint256 totalCost = appealCost.addCap(appealCost.mulCap(multiplier) / MULTIPLIER_DIVISOR);
        contribute(_itemID, lastRequestIndex, lastRoundIndex, uint256(_side), msg.sender, msg.value, totalCost);
        if (round.amountPaid[uint256(_side)] >= totalCost) {
            if (round.sideFunded == Party.None) {
                round.sideFunded = _side;
            } else {
                round.sideFunded = Party.None;
                arbitrator.appeal.value(appealCost)(disputeData.disputeID, arbitrationParams.record240);
                disputeData.roundCount++;
                round.feeRewards = round.feeRewards.subCap(appealCost);
            }
        }
    }
    function withdrawFeesAndRewards(address payable _beneficiary,
        bytes32 _itemID,
        uint256 _requestID,
        uint256 _roundID) external {
        DisputeData storage disputeData = requestsDisputeData[_itemID][_requestID];
        require(disputeData.status == DisputeStatus.Resolved, "Request must be resolved.");
        Round storage round = disputeData.rounds[_roundID];
        uint256 reward;
        if (_roundID == disputeData.roundCount - 1) {
            reward =
                round.contributions[_beneficiary][uint256(Party.Requester)] +
                round.contributions[_beneficiary][uint256(Party.Challenger)];
        } else if (disputeData.ruling == Party.None) {
            uint256 totalFeesInRound = round.amountPaid[uint256(Party.Challenger)] +
                round.amountPaid[uint256(Party.Requester)];
            uint256 claimableFees = round.contributions[_beneficiary][uint256(Party.Challenger)] +
                round.contributions[_beneficiary][uint256(Party.Requester)];
            reward = totalFeesInRound > 0 ? (claimableFees * round.feeRewards) / totalFeesInRound : 0;
        } else {
            reward = round.amountPaid[uint256(disputeData.ruling)] > 0
                ? (round.contributions[_beneficiary][uint256(disputeData.ruling)] * round.feeRewards) /
                    round.amountPaid[uint256(disputeData.ruling)]
                : 0;
        }
        round.contributions[_beneficiary][uint256(Party.Requester)] = 0;
        round.contributions[_beneficiary][uint256(Party.Challenger)] = 0;
        if (reward > 0) {
            _beneficiary.send(reward);
            emit RewardWithdrawn(_beneficiary, _itemID, _requestID, _roundID, reward);
        }
    }
    function executeRequest(bytes32 _itemID) external {
        Item storage item = items[_itemID];
        uint256 lastRequestIndex = items[_itemID].requestCount - 1;
        Request storage request = item.requests[lastRequestIndex];
        require(block.timestamp - request.submissionTime > challengePeriodDuration,
            "Time to challenge the request must pass.");
        DisputeData storage disputeData = requestsDisputeData[_itemID][lastRequestIndex];
        require(disputeData.status == DisputeStatus.None, "The request should not be disputed.");
        if (item.status == Status.RegistrationRequested) {
            item.status = Status.Registered;
        } else if (item.status == Status.ClearingRequested) {
            item.status = Status.Absent;
        } else {
            revert("There must be a request.");
        }
        emit ItemStatusChange(_itemID, false);
        uint256 sumDeposit = item.sumDeposit;
        item.sumDeposit = 0;
        if (sumDeposit > 0) {
            request.requester.send(sumDeposit);
        }
    }
    function rule(uint256 _disputeID, uint256 _ruling) external {
        require(_ruling <= RULING_OPTIONS, "Invalid ruling option");
        bytes32 itemID = arbitratorDisputeIDToItemID[msg.sender][_disputeID];
        Item storage item = items[itemID];
        uint256 lastRequestIndex = items[itemID].requestCount - 1;
        Request storage request = item.requests[lastRequestIndex];
        DisputeData storage disputeData = requestsDisputeData[itemID][lastRequestIndex];
        require(disputeData.status == DisputeStatus.AwaitingRuling, "The request must not be resolved.");
        ArbitrationParams storage arbitrationParams = arbitrationParamsChanges[request.arbitrationParamsIndex];
        require(address(arbitrationParams.arbitrator) == msg.sender, "Only the arbitrator can give a ruling");
        uint256 finalRuling;
        Round storage round = disputeData.rounds[disputeData.roundCount - 1];
        if (round.sideFunded == Party.Requester) {
            finalRuling = uint256(Party.Requester);
        } else if (round.sideFunded == Party.Challenger) {
            finalRuling = uint256(Party.Challenger);
        } else {
            finalRuling = _ruling;
        }
        emit Ruling(IArbitrator(msg.sender), _disputeID, finalRuling);
        Party winner = Party(finalRuling);
        disputeData.status = DisputeStatus.Resolved;
        disputeData.ruling = winner;
        uint256 sumDeposit = item.sumDeposit;
        item.sumDeposit = 0;
        if (winner == Party.None) {
            item.status = item.status == Status.RegistrationRequested ? Status.Absent : Status.Registered;
            uint256 halfSumDeposit = sumDeposit / 2;
            request.requester.send(halfSumDeposit);
            request.challenger.send(halfSumDeposit);
        } else if (winner == Party.Requester) {
            item.status = item.status == Status.RegistrationRequested ? Status.Registered : Status.Absent;
            request.requester.send(sumDeposit);
        } else {
            item.status = item.status == Status.RegistrationRequested ? Status.Absent : Status.Registered;
            request.challenger.send(sumDeposit);
        }
        emit ItemStatusChange(itemID, false);
    }
    function submitEvidence(bytes32 _itemID, string calldata _evidence) external {
        Item storage item = items[_itemID];
        uint256 lastRequestIndex = item.requestCount - 1;
        Request storage request = item.requests[lastRequestIndex];
        ArbitrationParams storage arbitrationParams = arbitrationParamsChanges[request.arbitrationParamsIndex];
        emit Evidence(arbitrationParams.arbitrator,
            check196(_itemID, lastRequestIndex),
            msg.sender,
            _evidence);
    }
    function handle245(uint256 _challengePeriodDuration) external onlyGovernor {
        challengePeriodDuration = _challengePeriodDuration;
    }
    function changeSubmissionBaseDeposit(uint256 _submissionBaseDeposit) external onlyGovernor {
        submissionBaseDeposit = _submissionBaseDeposit;
    }
    function changeRemovalBaseDeposit(uint256 _removalBaseDeposit) external onlyGovernor {
        removalBaseDeposit = _removalBaseDeposit;
    }
    function changeSubmissionChallengeBaseDeposit(uint256 _submissionChallengeBaseDeposit) external onlyGovernor {
        submissionChallengeBaseDeposit = _submissionChallengeBaseDeposit;
    }
    function changeRemovalChallengeBaseDeposit(uint256 _removalChallengeBaseDeposit) external onlyGovernor {
        removalChallengeBaseDeposit = _removalChallengeBaseDeposit;
    }
    function changeGovernor(address _governor) external onlyGovernor {
        governor = _governor;
    }
    function changeSharedStakeMultiplier(uint256 _sharedStakeMultiplier) external onlyGovernor {
        sharedStakeMultiplier = _sharedStakeMultiplier;
    }
    function changeWinnerStakeMultiplier(uint256 _winnerStakeMultiplier) external onlyGovernor {
        winnerStakeMultiplier = _winnerStakeMultiplier;
    }
    function changeLoserStakeMultiplier(uint256 _loserStakeMultiplier) external onlyGovernor {
        loserStakeMultiplier = _loserStakeMultiplier;
    }
    function changeConnectedTCR(address _connectedTCR) external onlyGovernor {
        emit ConnectedTCRSet(_connectedTCR);
    }
    function changeRelayerContract(address _relayerContract) external onlyGovernor {
        relayerContract = _relayerContract;
    }
    function changeArbitrationParams(IArbitrator _arbitrator,
        bytes calldata _arbitratorExtraData,
        string calldata _registrationMetaEvidence,
        string calldata _clearingMetaEvidence) external onlyGovernor {
        _doChangeArbitrationParams(_arbitrator, _arbitratorExtraData, _registrationMetaEvidence, _clearingMetaEvidence);
    }
    function _doChangeArbitrationParams(IArbitrator _arbitrator,
        bytes memory _arbitratorExtraData,
        string memory _registrationMetaEvidence,
        string memory _clearingMetaEvidence) internal {
        emit MetaEvidence(2 * arbitrationParamsChanges.length, _registrationMetaEvidence);
        emit MetaEvidence(2 * arbitrationParamsChanges.length + 1, _clearingMetaEvidence);
        arbitrationParamsChanges.push(ArbitrationParams({arbitrator: _arbitrator, record240: _arbitratorExtraData}));
    }
    function contribute(bytes32 _itemID,
        uint256 _requestID,
        uint256 _roundID,
        uint256 _side,
        address payable _contributor,
        uint256 _amount,
        uint256 _totalRequired) internal {
        Round storage round = requestsDisputeData[_itemID][_requestID].rounds[_roundID];
        uint256 pendingAmount = _totalRequired.subCap(round.amountPaid[_side]);
        uint256 contribution; 
        uint256 remainingETH; 
        if (pendingAmount > _amount) {
            contribution = _amount;
        } else {
            contribution = pendingAmount;
            remainingETH = _amount - pendingAmount;
        }
        round.contributions[_contributor][_side] += contribution;
        round.amountPaid[_side] += contribution;
        round.feeRewards += contribution;
        if (remainingETH > 0) {
            _contributor.send(remainingETH);
        }
        if (contribution > 0) {
            emit Contribution(_itemID, _requestID, _roundID, msg.sender, contribution, Party(_side));
        }
    }
    function check196(bytes32 _itemID, uint256 _requestID) public pure returns (uint256) {
        return uint256(keccak256(abi.encodePacked(_itemID, _requestID)));
    }
    function arbitrator() external view returns (IArbitrator) {
        return arbitrationParamsChanges[arbitrationParamsChanges.length - 1].arbitrator;
    }
    function record240() external view returns (bytes memory) {
        return arbitrationParamsChanges[arbitrationParamsChanges.length - 1].record240;
    }
    function metaEvidenceUpdates() external view returns (uint256) {
        return arbitrationParamsChanges.length;
    }
    function getContributions(bytes32 _itemID,
        uint256 _requestID,
        uint256 _roundID,
        address _contributor) external view returns (uint256[3] memory contributions) {
        DisputeData storage disputeData = requestsDisputeData[_itemID][_requestID];
        Round storage round = disputeData.rounds[_roundID];
        contributions = round.contributions[_contributor];
    }
    function getItemInfo(bytes32 _itemID)
        external
        view
        returns (Status status,
            uint256 temp657,
            uint256 sumDeposit)
    {
        Item storage item = items[_itemID];
        return (item.status, item.requestCount, item.sumDeposit);
    }
    function check478(bytes32 _itemID, uint256 _requestID)
        external
        view
        returns (bool disputed,
            uint256 disputeID,
            uint256 submissionTime,
            bool resolved,
            address payable[3] memory parties,
            uint256 numberOfRounds,
            Party ruling,
            IArbitrator requestArbitrator,
            bytes memory requestArbitratorExtraData,
            uint256 metaEvidenceID)
    {
        Item storage item = items[_itemID];
        require(item.requestCount > _requestID, "Request does not exist.");
        Request storage request = items[_itemID].requests[_requestID];
        submissionTime = request.submissionTime;
        parties[uint256(Party.Requester)] = request.requester;
        parties[uint256(Party.Challenger)] = request.challenger;
        (disputed, disputeID, numberOfRounds, ruling) = getRequestDisputeData(_itemID, _requestID);
        (requestArbitrator, requestArbitratorExtraData, metaEvidenceID) = getRequestArbitrationParams(_itemID,
            _requestID);
        resolved = getRequestResolvedStatus(_itemID, _requestID);
    }
    function getRequestDisputeData(bytes32 _itemID, uint256 _requestID)
        internal
        view
        returns (bool disputed,
            uint256 disputeID,
            uint256 numberOfRounds,
            Party ruling)
    {
        DisputeData storage disputeData = requestsDisputeData[_itemID][_requestID];
        return (disputeData.status >= DisputeStatus.AwaitingRuling,
            disputeData.disputeID,
            disputeData.roundCount,
            disputeData.ruling);
    }
    function getRequestArbitrationParams(bytes32 _itemID, uint256 _requestID)
        internal
        view
        returns (IArbitrator arbitrator,
            bytes memory record240,
            uint256 metaEvidenceID)
    {
        Request storage request = items[_itemID].requests[_requestID];
        ArbitrationParams storage arbitrationParams = arbitrationParamsChanges[request.arbitrationParamsIndex];
        return (arbitrationParams.arbitrator,
            arbitrationParams.record240,
            2 * request.arbitrationParamsIndex + uint256(request.requestType));
    }
    function getRequestResolvedStatus(bytes32 _itemID, uint256 _requestID) internal view returns (bool resolved) {
        Item storage item = items[_itemID];
        if (item.requestCount == 0) {
            return false;
        }
        if (_requestID < item.requestCount - 1) {
            return true;
        }
        return item.sumDeposit == 0;
    }
    function getRoundInfo(bytes32 _itemID,
        uint256 _requestID,
        uint256 _roundID)
        external
        view
        returns (bool appealed,
            uint256[3] memory amountPaid,
            bool[3] memory hasPaid,
            uint256 feeRewards)
    {
        Item storage item = items[_itemID];
        require(item.requestCount > _requestID, "Request does not exist.");
        DisputeData storage disputeData = requestsDisputeData[_itemID][_requestID];
        require(disputeData.roundCount > _roundID, "Round does not exist");
        Round storage round = disputeData.rounds[_roundID];
        appealed = _roundID < disputeData.roundCount - 1;
        hasPaid[uint256(Party.Requester)] = appealed || round.sideFunded == Party.Requester;
        hasPaid[uint256(Party.Challenger)] = appealed || round.sideFunded == Party.Challenger;
        return (appealed, round.amountPaid, hasPaid, round.feeRewards);
    }
}