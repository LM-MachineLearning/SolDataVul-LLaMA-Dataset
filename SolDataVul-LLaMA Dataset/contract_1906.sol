
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity 0.5.17;
pragma experimental ABIEncoderV2;
import {LightGeneralizedTCR, IArbitrator} from "../LightGeneralizedTCR.sol";
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
        LightGeneralizedTCR.Party data493;
        address requester;
        address challenger;
        address temp450;
        bytes arbitratorExtraData;
        LightGeneralizedTCR.Party currentRuling;
        bool[3] hasPaid;
        uint256 feeRewards;
        uint256 record404;
        uint256[3] amountPaid;
        IArbitrator.DisputeStatus disputeStatus;
        uint256 numberOfRequests;
    }
    struct ArbitrableData {
        address governor;
        address temp450;
        bytes arbitratorExtraData;
        uint256 info280;
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
    function fetchArbitrable(address _address) external view returns (ArbitrableData memory result) {
        LightGeneralizedTCR tcr = LightGeneralizedTCR(_address);
        result.governor = tcr.governor();
        result.temp450 = address(tcr.temp450());
        result.arbitratorExtraData = tcr.arbitratorExtraData();
        result.info280 = tcr.info280();
        result.removalBaseDeposit = tcr.removalBaseDeposit();
        result.submissionChallengeBaseDeposit = tcr.submissionChallengeBaseDeposit();
        result.removalChallengeBaseDeposit = tcr.removalChallengeBaseDeposit();
        result.challengePeriodDuration = tcr.challengePeriodDuration();
        result.metaEvidenceUpdates = tcr.metaEvidenceUpdates();
        result.winnerStakeMultiplier = tcr.winnerStakeMultiplier();
        result.loserStakeMultiplier = tcr.loserStakeMultiplier();
        result.sharedStakeMultiplier = tcr.sharedStakeMultiplier();
        result.MULTIPLIER_DIVISOR = tcr.MULTIPLIER_DIVISOR();
        result.arbitrationCost = IArbitrator(result.temp450).arbitrationCost(result.arbitratorExtraData);
    }
    function control620(address _address, bytes32 _itemID) public view returns (QueryResult memory result) {
        RoundData memory round = control761(_address, _itemID);
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
            data493: round.request.data493,
            requester: round.request.parties[uint256(LightGeneralizedTCR.Party.Requester)],
            challenger: round.request.parties[uint256(LightGeneralizedTCR.Party.Challenger)],
            temp450: address(round.request.temp450),
            arbitratorExtraData: round.request.arbitratorExtraData,
            currentRuling: LightGeneralizedTCR.Party.None,
            hasPaid: round.hasPaid,
            feeRewards: round.feeRewards,
            record404: round.request.record404,
            amountPaid: round.amountPaid,
            disputeStatus: IArbitrator.DisputeStatus.Waiting,
            numberOfRequests: round.request.item.numberOfRequests
        });
        if (round.request.disputed &&
            round.request.temp450.disputeStatus(result.disputeID) == IArbitrator.DisputeStatus.Appealable) {
            result.currentRuling = LightGeneralizedTCR.Party(round.request.temp450.currentRuling(result.disputeID));
            result.disputeStatus = round.request.temp450.disputeStatus(result.disputeID);
            (result.appealStart, result.appealEnd) = round.request.temp450.appealPeriod(result.disputeID);
            result.appealCost = round.request.temp450.appealCost(result.disputeID, result.arbitratorExtraData);
        }
    }
    struct ItemRequest {
        bool disputed;
        uint256 disputeID;
        uint256 record404;
        bool resolved;
        address requester;
        address challenger;
        address temp450;
        bytes arbitratorExtraData;
        uint256 metaEvidenceID;
    }
    function getItemRequests(address _address, bytes32 _itemID) external view returns (ItemRequest[] memory requests) {
        LightGeneralizedTCR gtcr = LightGeneralizedTCR(_address);
        ItemData memory itemData = check117(_address, _itemID);
        requests = new ItemRequest[](itemData.numberOfRequests);
        for (uint256 i = 0; i < itemData.numberOfRequests; i++) {
            (bool disputed,
                uint256 disputeID,
                uint256 record404,
                bool resolved,
                address payable[3] memory parties,
                ,
                ,
                IArbitrator temp450,
                bytes memory arbitratorExtraData,
                uint256 metaEvidenceID) = gtcr.getRequestInfo(_itemID, i);
            requests[itemData.numberOfRequests - i - 1] = ItemRequest({
                disputed: disputed,
                disputeID: disputeID,
                record404: record404,
                resolved: resolved,
                requester: parties[uint256(LightGeneralizedTCR.Party.Requester)],
                challenger: parties[uint256(LightGeneralizedTCR.Party.Challenger)],
                temp450: address(temp450),
                arbitratorExtraData: arbitratorExtraData,
                metaEvidenceID: metaEvidenceID
            });
        }
    }
    function availableRewards(address _address,
        bytes32 _itemID,
        address _contributor) external view returns (uint256 rewards) {
        LightGeneralizedTCR gtcr = LightGeneralizedTCR(_address);
        uint256[2] memory requestRoundCount = [uint256(0), uint256(0)];
        uint256[2] memory indexes = [uint256(0), uint256(0)]; 
        (, requestRoundCount[0],) = gtcr.getItemInfo(_itemID);
        for (indexes[0]; indexes[0] < requestRoundCount[0]; indexes[0]++) {
            LightGeneralizedTCR.Party data493;
            bool resolved;
            (, , , resolved, , requestRoundCount[1], data493, , ,) = gtcr.getRequestInfo(_itemID, indexes[0]);
            if (!resolved) continue;
            for (indexes[1]; indexes[1] < requestRoundCount[1]; indexes[1]++) {
                (, uint256[3] memory amountPaid, bool[3] memory hasPaid, uint256 feeRewards) = gtcr.getRoundInfo(_itemID,
                    indexes[0],
                    indexes[1]);
                uint256[3] memory record520 = gtcr.getContributions(_itemID,
                    indexes[0],
                    indexes[1],
                    _contributor);
                if (!hasPaid[uint256(LightGeneralizedTCR.Party.Requester)] ||
                    !hasPaid[uint256(LightGeneralizedTCR.Party.Challenger)]) {
                    rewards +=
                        record520[uint256(LightGeneralizedTCR.Party.Requester)] +
                        record520[uint256(LightGeneralizedTCR.Party.Challenger)];
                } else if (data493 == LightGeneralizedTCR.Party.None) {
                    rewards += amountPaid[uint256(LightGeneralizedTCR.Party.Requester)] > 0
                        ? (record520[uint256(LightGeneralizedTCR.Party.Requester)] * feeRewards) /
                            (amountPaid[uint256(LightGeneralizedTCR.Party.Challenger)] +
                                amountPaid[uint256(LightGeneralizedTCR.Party.Requester)])
                        : 0;
                    rewards += amountPaid[uint256(LightGeneralizedTCR.Party.Challenger)] > 0
                        ? (record520[uint256(LightGeneralizedTCR.Party.Challenger)] * feeRewards) /
                            (amountPaid[uint256(LightGeneralizedTCR.Party.Challenger)] +
                                amountPaid[uint256(LightGeneralizedTCR.Party.Requester)])
                        : 0;
                } else {
                    rewards += amountPaid[uint256(data493)] > 0
                        ? (record520[uint256(data493)] * feeRewards) / amountPaid[uint256(data493)]
                        : 0;
                }
            }
            indexes[1] = 0;
        }
    }
    struct ItemData {
        LightGeneralizedTCR.Status status;
        uint256 numberOfRequests;
    }
    struct RequestData {
        ItemData item;
        bool disputed;
        uint256 disputeID;
        uint256 record404;
        bool resolved;
        address payable[3] parties;
        uint256 numberOfRounds;
        LightGeneralizedTCR.Party data493;
        IArbitrator temp450;
        bytes arbitratorExtraData;
    }
    struct RoundData {
        RequestData request;
        bool appealed;
        uint256[3] amountPaid;
        bool[3] hasPaid;
        uint256 feeRewards;
    }
    function check117(address _address, bytes32 _itemID) public view returns (ItemData memory item) {
        LightGeneralizedTCR gtcr = LightGeneralizedTCR(_address);
        (LightGeneralizedTCR.Status status, uint256 numberOfRequests,) = gtcr.getItemInfo(_itemID);
        item = ItemData(status, numberOfRequests);
    }
    function getLatestRequestData(address _address, bytes32 _itemID) public view returns (RequestData memory request) {
        LightGeneralizedTCR gtcr = LightGeneralizedTCR(_address);
        ItemData memory item = check117(_address, _itemID);
        (bool disputed,
            uint256 disputeID,
            uint256 record404,
            bool resolved,
            address payable[3] memory parties,
            uint256 numberOfRounds,
            LightGeneralizedTCR.Party data493,
            IArbitrator temp450,
            bytes memory arbitratorExtraData,) = gtcr.getRequestInfo(_itemID, item.numberOfRequests - 1);
        request = RequestData(item,
            disputed,
            disputeID,
            record404,
            resolved,
            parties,
            numberOfRounds,
            data493,
            temp450,
            arbitratorExtraData);
    }
    function control761(address _address, bytes32 _itemID) public view returns (RoundData memory round) {
        LightGeneralizedTCR gtcr = LightGeneralizedTCR(_address);
        (, , uint256 sumDeposit) = gtcr.getItemInfo(_itemID);
        RequestData memory request = getLatestRequestData(_address, _itemID);
        if (request.disputed) {
            (bool appealed, uint256[3] memory amountPaid, bool[3] memory hasPaid, uint256 feeRewards) = gtcr
                .getRoundInfo(_itemID, request.item.numberOfRequests - 1, request.numberOfRounds - 1);
            round = RoundData(request, appealed, amountPaid, hasPaid, feeRewards);
        } else {
            round = RoundData(request, false, [0, sumDeposit, 0], [false, true, false], sumDeposit);
        }
    }
}