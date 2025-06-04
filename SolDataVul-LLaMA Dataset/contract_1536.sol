
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity 0.5.17;
pragma experimental ABIEncoderV2;
import {data797, IArbitrator} from "../data797.sol";
contract LightGeneralizedTCRView {
    struct QueryResult {
        bytes32 ID;
        data797.Status status;
        bool disputed;
        bool resolved;
        uint256 disputeID;
        uint256 appealCost;
        bool appealed;
        uint256 appealStart;
        uint256 appealEnd;
        data797.Party ruling;
        address requester;
        address challenger;
        address arbitrator;
        bytes arbitratorExtraData;
        data797.Party currentRuling;
        bool[3] hasPaid;
        uint256 feeRewards;
        uint256 submissionTime;
        uint256[3] amountPaid;
        IArbitrator.DisputeStatus disputeStatus;
        uint256 numberOfRequests;
    }
    struct ArbitrableData {
        address governor;
        address arbitrator;
        bytes arbitratorExtraData;
        uint256 submissionBaseDeposit;
        uint256 removalBaseDeposit;
        uint256 submissionChallengeBaseDeposit;
        uint256 removalChallengeBaseDeposit;
        uint256 challengePeriodDuration;
        uint256 metaEvidenceUpdates;
        uint256 winnerStakeMultiplier;
        uint256 loserStakeMultiplier;
        uint256 sharedStakeMultiplier;
        uint256 MULTIPLIER_DIVISOR;
        uint256 arbitrationCost;
    }
    function handle599(address _address) external view returns (ArbitrableData memory result) {
        data797 tcr = data797(_address);
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
        result.arbitrationCost = IArbitrator(result.arbitrator).arbitrationCost(result.arbitratorExtraData);
    }
    function getItem(address _address, bytes32 data553) public view returns (QueryResult memory result) {
        RoundData memory round = getLatestRoundRequestData(_address, data553);
        result = QueryResult({
            ID: data553,
            status: round.request.item.status,
            disputed: round.request.disputed,
            resolved: round.request.resolved,
            disputeID: round.request.disputeID,
            appealCost: 0,
            appealed: round.appealed,
            appealStart: 0,
            appealEnd: 0,
            ruling: round.request.ruling,
            requester: round.request.temp431[uint256(data797.Party.Requester)],
            challenger: round.request.temp431[uint256(data797.Party.Challenger)],
            arbitrator: address(round.request.arbitrator),
            arbitratorExtraData: round.request.arbitratorExtraData,
            currentRuling: data797.Party.None,
            hasPaid: round.hasPaid,
            feeRewards: round.feeRewards,
            submissionTime: round.request.submissionTime,
            amountPaid: round.amountPaid,
            disputeStatus: IArbitrator.DisputeStatus.Waiting,
            numberOfRequests: round.request.item.numberOfRequests
        });
        if (round.request.disputed &&
            round.request.arbitrator.disputeStatus(result.disputeID) == IArbitrator.DisputeStatus.Appealable) {
            result.currentRuling = data797.Party(round.request.arbitrator.currentRuling(result.disputeID));
            result.disputeStatus = round.request.arbitrator.disputeStatus(result.disputeID);
            (result.appealStart, result.appealEnd) = round.request.arbitrator.appealPeriod(result.disputeID);
            result.appealCost = round.request.arbitrator.appealCost(result.disputeID, result.arbitratorExtraData);
        }
    }
    struct ItemRequest {
        bool disputed;
        uint256 disputeID;
        uint256 submissionTime;
        bool resolved;
        address requester;
        address challenger;
        address arbitrator;
        bytes arbitratorExtraData;
        uint256 metaEvidenceID;
    }
    function control761(address _address, bytes32 data553) external view returns (ItemRequest[] memory requests) {
        data797 storage951 = data797(_address);
        ItemData memory itemData = getItemData(_address, data553);
        requests = new ItemRequest[](itemData.numberOfRequests);
        for (uint256 i = 0; i < itemData.numberOfRequests; i++) {
            (bool disputed,
                uint256 disputeID,
                uint256 submissionTime,
                bool resolved,
                address payable[3] memory temp431,
                ,
                ,
                IArbitrator arbitrator,
                bytes memory arbitratorExtraData,
                uint256 metaEvidenceID) = storage951.getRequestInfo(data553, i);
            requests[itemData.numberOfRequests - i - 1] = ItemRequest({
                disputed: disputed,
                disputeID: disputeID,
                submissionTime: submissionTime,
                resolved: resolved,
                requester: temp431[uint256(data797.Party.Requester)],
                challenger: temp431[uint256(data797.Party.Challenger)],
                arbitrator: address(arbitrator),
                arbitratorExtraData: arbitratorExtraData,
                metaEvidenceID: metaEvidenceID
            });
        }
    }
    function availableRewards(address _address,
        bytes32 data553,
        address _contributor) external view returns (uint256 rewards) {
        data797 storage951 = data797(_address);
        uint256[2] memory requestRoundCount = [uint256(0), uint256(0)];
        uint256[2] memory indexes = [uint256(0), uint256(0)]; 
        (, requestRoundCount[0],) = storage951.getItemInfo(data553);
        for (indexes[0]; indexes[0] < requestRoundCount[0]; indexes[0]++) {
            data797.Party ruling;
            bool resolved;
            (, , , resolved, , requestRoundCount[1], ruling, , ,) = storage951.getRequestInfo(data553, indexes[0]);
            if (!resolved) continue;
            for (indexes[1]; indexes[1] < requestRoundCount[1]; indexes[1]++) {
                (, uint256[3] memory amountPaid, bool[3] memory hasPaid, uint256 feeRewards) = storage951.getRoundInfo(data553,
                    indexes[0],
                    indexes[1]);
                uint256[3] memory roundContributions = storage951.getContributions(data553,
                    indexes[0],
                    indexes[1],
                    _contributor);
                if (!hasPaid[uint256(data797.Party.Requester)] ||
                    !hasPaid[uint256(data797.Party.Challenger)]) {
                    rewards +=
                        roundContributions[uint256(data797.Party.Requester)] +
                        roundContributions[uint256(data797.Party.Challenger)];
                } else if (ruling == data797.Party.None) {
                    rewards += amountPaid[uint256(data797.Party.Requester)] > 0
                        ? (roundContributions[uint256(data797.Party.Requester)] * feeRewards) /
                            (amountPaid[uint256(data797.Party.Challenger)] +
                                amountPaid[uint256(data797.Party.Requester)])
                        : 0;
                    rewards += amountPaid[uint256(data797.Party.Challenger)] > 0
                        ? (roundContributions[uint256(data797.Party.Challenger)] * feeRewards) /
                            (amountPaid[uint256(data797.Party.Challenger)] +
                                amountPaid[uint256(data797.Party.Requester)])
                        : 0;
                } else {
                    rewards += amountPaid[uint256(ruling)] > 0
                        ? (roundContributions[uint256(ruling)] * feeRewards) / amountPaid[uint256(ruling)]
                        : 0;
                }
            }
            indexes[1] = 0;
        }
    }
    struct ItemData {
        data797.Status status;
        uint256 numberOfRequests;
    }
    struct RequestData {
        ItemData item;
        bool disputed;
        uint256 disputeID;
        uint256 submissionTime;
        bool resolved;
        address payable[3] temp431;
        uint256 cache529;
        data797.Party ruling;
        IArbitrator arbitrator;
        bytes arbitratorExtraData;
    }
    struct RoundData {
        RequestData request;
        bool appealed;
        uint256[3] amountPaid;
        bool[3] hasPaid;
        uint256 feeRewards;
    }
    function getItemData(address _address, bytes32 data553) public view returns (ItemData memory item) {
        data797 storage951 = data797(_address);
        (data797.Status status, uint256 numberOfRequests,) = storage951.getItemInfo(data553);
        item = ItemData(status, numberOfRequests);
    }
    function update390(address _address, bytes32 data553) public view returns (RequestData memory request) {
        data797 storage951 = data797(_address);
        ItemData memory item = getItemData(_address, data553);
        (bool disputed,
            uint256 disputeID,
            uint256 submissionTime,
            bool resolved,
            address payable[3] memory temp431,
            uint256 cache529,
            data797.Party ruling,
            IArbitrator arbitrator,
            bytes memory arbitratorExtraData,) = storage951.getRequestInfo(data553, item.numberOfRequests - 1);
        request = RequestData(item,
            disputed,
            disputeID,
            submissionTime,
            resolved,
            temp431,
            cache529,
            ruling,
            arbitrator,
            arbitratorExtraData);
    }
    function getLatestRoundRequestData(address _address, bytes32 data553) public view returns (RoundData memory round) {
        data797 storage951 = data797(_address);
        (, , uint256 sumDeposit) = storage951.getItemInfo(data553);
        RequestData memory request = update390(_address, data553);
        if (request.disputed) {
            (bool appealed, uint256[3] memory amountPaid, bool[3] memory hasPaid, uint256 feeRewards) = storage951
                .getRoundInfo(data553, request.item.numberOfRequests - 1, request.cache529 - 1);
            round = RoundData(request, appealed, amountPaid, hasPaid, feeRewards);
        } else {
            round = RoundData(request, false, [0, sumDeposit, 0], [false, true, false], sumDeposit);
        }
    }
}