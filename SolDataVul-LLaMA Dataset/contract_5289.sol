
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
pragma experimental ABIEncoderV2;
import { GeneralizedTCR, IArbitrator } from "../GeneralizedTCR.sol";
import { BytesLib } from "solidity-bytes-utils/contracts/BytesLib.sol";
import { RLPReader } from "solidity-rlp/contracts/RLPReader.sol";
contract GeneralizedTCRView {
    using RLPReader for RLPReader.RLPItem;
    using RLPReader for bytes;
    using BytesLib for bytes;
    struct QueryResult {
        bytes32 ID;
        bytes data;
        GeneralizedTCR.Status status;
        bool disputed;
        bool resolved;
        uint disputeID;
        uint appealCost;
        bool appealed;
        uint appealStart;
        uint appealEnd;
        GeneralizedTCR.Party ruling;
        address requester;
        address challenger;
        address arbitrator;
        bytes arbitratorExtraData;
        GeneralizedTCR.Party currentRuling;
        bool[3] hasPaid;
        uint feeRewards;
        uint submissionTime;
        uint[3] amountPaid;
        IArbitrator.DisputeStatus disputeStatus;
        uint numberOfRequests;
    }
    struct ArbitrableData {
        address governor;
        address arbitrator;
        bytes arbitratorExtraData;
        uint submissionBaseDeposit;
        uint removalBaseDeposit;
        uint submissionChallengeBaseDeposit;
        uint removalChallengeBaseDeposit;
        uint challengePeriodDuration;
        uint metaEvidenceUpdates;
        uint winnerStakeMultiplier;
        uint loserStakeMultiplier;
        uint sharedStakeMultiplier;
        uint MULTIPLIER_DIVISOR;
        uint arbitrationCost;
    }
    function fetchArbitrable(address _address) external view returns (ArbitrableData memory result) {
        GeneralizedTCR tcr = GeneralizedTCR(_address);
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
    function getItem(address _address, bytes32 _itemID) public view returns (QueryResult memory result) {
        RoundData memory round = getLatestRoundRequestData(_address, _itemID);
        result = QueryResult({
            ID: _itemID,
            data: round.request.item.data,
            status: round.request.item.status,
            disputed: round.request.disputed,
            resolved: round.request.resolved,
            disputeID: round.request.disputeID,
            appealCost: 0,
            appealed: round.appealed,
            appealStart: 0,
            appealEnd: 0,
            ruling: round.request.ruling,
            requester: round.request.parties[uint(GeneralizedTCR.Party.Requester)],
            challenger: round.request.parties[uint(GeneralizedTCR.Party.Challenger)],
            arbitrator: address(round.request.arbitrator),
            arbitratorExtraData: round.request.arbitratorExtraData,
            currentRuling: GeneralizedTCR.Party.None,
            hasPaid: round.hasPaid,
            feeRewards: round.feeRewards,
            submissionTime: round.request.submissionTime,
            amountPaid: round.amountPaid,
            disputeStatus: IArbitrator.DisputeStatus.Waiting,
            numberOfRequests: round.request.item.numberOfRequests
        });
        if (round.request.disputed && round.request.arbitrator.disputeStatus(result.disputeID) == IArbitrator.DisputeStatus.Appealable) {
            result.currentRuling = GeneralizedTCR.Party(round.request.arbitrator.currentRuling(result.disputeID));
            result.disputeStatus = round.request.arbitrator.disputeStatus(result.disputeID);
            (result.appealStart, result.appealEnd) = round.request.arbitrator.appealPeriod(result.disputeID);
            result.appealCost = round.request.arbitrator.appealCost(result.disputeID, result.arbitratorExtraData);
        }
    }
    struct ItemRequest {
        bool disputed;
        uint disputeID;
        uint submissionTime;
        bool resolved;
        address requester;
        address challenger;
        address arbitrator;
        bytes arbitratorExtraData;
        uint metaEvidenceID;
    }
    function getItemRequests(address _address, bytes32 _itemID) external view returns (ItemRequest[] memory requests) {
        GeneralizedTCR gtcr = GeneralizedTCR(_address);
        ItemData memory itemData = getItemData(_address, _itemID);
        requests = new ItemRequest[](itemData.numberOfRequests);
        for (uint i = 0; i < itemData.numberOfRequests; i++) {
            (bool disputed,
                uint disputeID,
                uint submissionTime,
                bool resolved,
                address payable[3] memory parties,
                ,
                ,
                IArbitrator arbitrator,
                bytes memory arbitratorExtraData,
                uint metaEvidenceID) = gtcr.getRequestInfo(_itemID, i);
            requests[itemData.numberOfRequests - i - 1] = ItemRequest({
                disputed: disputed,
                disputeID: disputeID,
                submissionTime: submissionTime,
                resolved: resolved,
                requester: parties[uint(GeneralizedTCR.Party.Requester)],
                challenger: parties[uint(GeneralizedTCR.Party.Challenger)],
                arbitrator: address(arbitrator),
                arbitratorExtraData: arbitratorExtraData,
                metaEvidenceID: metaEvidenceID
            });
        }
    }
    function findItem(address _address,
        bytes memory _rlpEncodedMatch,
        uint _cursor,
        uint _count,
        bool[4] memory _skipState,
        bool[] memory _ignoreColumns)
        public
        view
        returns (QueryResult[] memory results)
    {
        GeneralizedTCR gtcr = GeneralizedTCR(_address);
        RLPReader.RLPItem[] memory matchItem = _rlpEncodedMatch.toRlpItem().toList();
        results = new QueryResult[](_count == 0 ? gtcr.itemCount() : _count);
        uint itemsFound;
        for(uint i = _cursor; i < (_count == 0 ? gtcr.itemCount() : _count); i++) {
            QueryResult memory item = getItem(_address, gtcr.itemList(i));
            if (_skipState[uint(item.status)])
                continue;
            RLPReader.RLPItem[] memory itemData = item.data.toRlpItem().toList();
            bool itemFound = true;
            for (uint j = 0; j < matchItem.length; j++) {
                if (!_ignoreColumns[j] && !itemData[j].toBytes().equal(matchItem[j].toBytes())) {
                    itemFound = false;
                    break;
                }
            }
            if (itemFound) {
                results[itemsFound] = item;
                itemsFound++;
            }
        }
        return results;
    }
    function findIndexForPage(address _address,
        uint[4] calldata _targets,
        bool[9] calldata _filter,
        address _party)
        external
        view
        returns (uint index, bool hasMore, bool indexFound)
    {
        GeneralizedTCR gtcr = GeneralizedTCR(_address);
        uint count = _targets[2];
        uint currPage = 1;
        uint itemsMatched = 0;
        if (gtcr.itemCount() == 0) return (0, false, true);
        uint i = _filter[8] ? _targets[3] : _targets[3] == 0 ? gtcr.itemCount() - 1 : _targets[3];
        for(; _filter[8] ? i < gtcr.itemCount() && count > 0 : i >= 0 && count > 0;) {
            bytes32 itemID = gtcr.itemList(i);
            QueryResult memory item = getItem(_address, itemID);
            hasMore = true;
            if ((_filter[0] && item.status == GeneralizedTCR.Status.Absent) ||
                (_filter[1] && item.status == GeneralizedTCR.Status.Registered) ||
                (_filter[2] && item.status == GeneralizedTCR.Status.RegistrationRequested && !item.disputed) ||
                (_filter[3] && item.status == GeneralizedTCR.Status.ClearingRequested && !item.disputed) ||
                (_filter[4] && item.status == GeneralizedTCR.Status.RegistrationRequested && item.disputed) ||
                (_filter[5] && item.status == GeneralizedTCR.Status.ClearingRequested && item.disputed) ||
                (_filter[6] && item.requester == _party) ||
                (_filter[7] && item.challenger == _party)) {
                itemsMatched++;
                if (itemsMatched % _targets[1] == 0) {
                    currPage++;
                    if (currPage == _targets[0]){
                        if ((i == 0 && !_filter[8]) || (i == gtcr.itemCount() - 1 && _filter[8])) hasMore = false;
                        return (_filter[8] ? i + 1 : i - 1, hasMore, true);
                    }
                }
            }
            count--;
            if (count == 0 || (i == 0 && !_filter[8]) || (i == gtcr.itemCount() - 1 && _filter[8])) {
                hasMore = _filter[8] ? i < gtcr.itemCount() : i > 0;
                break;
            }
            i = _filter[8] ? i + 1 : i == 0 ? 0 : i - 1;
        }
        if (_filter[8] && _targets[3] + _targets[1] > _targets[3] + i) {
            i = _targets[3];
        }
        return (i, hasMore, false);
    }
    function countWithFilter(address _address, uint _cursorIndex, uint _count, bool[8] calldata _filter, address _party)
        external
        view
        returns (uint count, bool hasMore, uint)
    {
        GeneralizedTCR gtcr = GeneralizedTCR(_address);
        if (gtcr.itemCount() == 0) return (0, false, 0);
        uint iterations = 0;
        for (uint i = _cursorIndex; iterations <= _count && i < gtcr.itemCount(); i++) {
            bytes32 itemID = gtcr.itemList(i);
            QueryResult memory item = getItem(_address, itemID);
            if ((_filter[0] && item.status == GeneralizedTCR.Status.Absent) ||
                (_filter[1] && item.status == GeneralizedTCR.Status.Registered) ||
                (_filter[2] && item.status == GeneralizedTCR.Status.RegistrationRequested && !item.disputed) ||
                (_filter[3] && item.status == GeneralizedTCR.Status.ClearingRequested && !item.disputed) ||
                (_filter[4] && item.status == GeneralizedTCR.Status.RegistrationRequested && item.disputed) ||
                (_filter[5] && item.status == GeneralizedTCR.Status.ClearingRequested && item.disputed) ||
                (_filter[6] && item.requester == _party) ||
                (_filter[7] && item.challenger == _party)) {
                count++;
                if (iterations >= _count) {
                    return (count, true, i);
                }
            }
            iterations++;
        }
    }
    function queryItems(address _address,
        uint _cursorIndex,
        uint _count,
        bool[8] calldata _filter,
        bool _oldestFirst,
        address _party,
        uint _limit)
        external
        view
        returns (QueryResult[] memory results, bool hasMore)
    {
        GeneralizedTCR gtcr = GeneralizedTCR(_address);
        results = new QueryResult[](_count);
        uint index = 0;
        uint count = _count;
        if (_limit == 0) _limit = count;
        if (gtcr.itemCount() == 0) return (results, false);
        uint i = _oldestFirst ? _cursorIndex : _cursorIndex == 0 ? gtcr.itemCount() - 1 : _cursorIndex;
        for(; _oldestFirst ? i < gtcr.itemCount() && count > 0 : i >= 0 && count > 0;) {
            bytes32 itemID = gtcr.itemList(i);
            QueryResult memory item = getItem(_address, itemID);
            hasMore = true;
            if ((_filter[0] && item.status == GeneralizedTCR.Status.Absent) ||
                (_filter[1] && item.status == GeneralizedTCR.Status.Registered) ||
                (_filter[2] && item.status == GeneralizedTCR.Status.RegistrationRequested && !item.disputed) ||
                (_filter[3] && item.status == GeneralizedTCR.Status.ClearingRequested && !item.disputed) ||
                (_filter[4] && item.status == GeneralizedTCR.Status.RegistrationRequested && item.disputed) ||
                (_filter[5] && item.status == GeneralizedTCR.Status.ClearingRequested && item.disputed) ||
                (_filter[6] && item.requester == _party) ||
                (_filter[7] && item.challenger == _party)) {
                results[index] = item;
                index++;
                if (index == _limit) break;
            }
            count--;
            if (count == 0 || (i == 0 && !_oldestFirst) || (i == gtcr.itemCount() - 1 && _oldestFirst)) {
                hasMore = _oldestFirst ? i < gtcr.itemCount() - 1 : i > 0;
                break;
            }
            i = _oldestFirst ? i + 1 : i == 0 ? 0 : i - 1;
        }
    }
    function availableRewards(address _address, bytes32 _itemID, address _contributor) external view returns (uint rewards) {
        GeneralizedTCR gtcr = GeneralizedTCR(_address);
        uint[2] memory requestRoundCount = [uint(0), uint(0)];
        uint[2] memory indexes = [uint(0), uint(0)];
        (,,requestRoundCount[0]) = gtcr.getItemInfo(_itemID);
        for (indexes[0]; indexes[0] < requestRoundCount[0]; indexes[0]++) {
            GeneralizedTCR.Party ruling;
            bool resolved;
            (,,, resolved,, requestRoundCount[1], ruling,,,) = gtcr.getRequestInfo(_itemID, indexes[0]);
            if (!resolved) continue;
            for (indexes[1]; indexes[1] < requestRoundCount[1]; indexes[1]++) {
                (,
                    uint[3] memory amountPaid,
                    bool[3] memory hasPaid,
                    uint feeRewards) = gtcr.getRoundInfo(_itemID, indexes[0], indexes[1]);
                uint[3] memory roundContributions = gtcr.getContributions(_itemID, indexes[0], indexes[1], _contributor);
                if (!hasPaid[uint(GeneralizedTCR.Party.Requester)] || !hasPaid[uint(GeneralizedTCR.Party.Challenger)]) {
                    rewards += roundContributions[uint(GeneralizedTCR.Party.Requester)] + roundContributions[uint(GeneralizedTCR.Party.Challenger)];
                } else if (ruling == GeneralizedTCR.Party.None) {
                    rewards += amountPaid[uint(GeneralizedTCR.Party.Requester)] > 0
                        ? (roundContributions[uint(GeneralizedTCR.Party.Requester)] * feeRewards) / (amountPaid[uint(GeneralizedTCR.Party.Challenger)] + amountPaid[uint(GeneralizedTCR.Party.Requester)])
                        : 0;
                    rewards += amountPaid[uint(GeneralizedTCR.Party.Challenger)] > 0
                        ? (roundContributions[uint(GeneralizedTCR.Party.Challenger)] * feeRewards) / (amountPaid[uint(GeneralizedTCR.Party.Challenger)] + amountPaid[uint(GeneralizedTCR.Party.Requester)])
                        : 0;
                } else {
                    rewards += amountPaid[uint(ruling)] > 0
                        ? (roundContributions[uint(ruling)] * feeRewards) / amountPaid[uint(ruling)]
                        : 0;
                }
            }
            indexes[1] = 0;
        }
    }
    struct ItemData {
        bytes data;
        GeneralizedTCR.Status status;
        uint numberOfRequests;
    }
    struct RequestData {
        ItemData item;
        bool disputed;
        uint disputeID;
        uint submissionTime;
        bool resolved;
        address payable[3] parties;
        uint numberOfRounds;
        GeneralizedTCR.Party ruling;
        IArbitrator arbitrator;
        bytes arbitratorExtraData;
    }
    struct RoundData {
        RequestData request;
        bool appealed;
        uint[3] amountPaid;
        bool[3] hasPaid;
        uint feeRewards;
    }
    function getItemData(address _address, bytes32 _itemID) public view returns(ItemData memory item) {
        GeneralizedTCR gtcr = GeneralizedTCR(_address);
        (bytes memory data,
            GeneralizedTCR.Status status,
            uint numberOfRequests) = gtcr.getItemInfo(_itemID);
        item = ItemData(data, status, numberOfRequests);
    }
    function getLatestRequestData(address _address, bytes32 _itemID) public view returns (RequestData memory request)  {
        GeneralizedTCR gtcr = GeneralizedTCR(_address);
        ItemData memory item = getItemData(_address, _itemID);
        (bool disputed,
            uint disputeID,
            uint submissionTime,
            bool resolved,
            address payable[3] memory parties,
            uint numberOfRounds,
            GeneralizedTCR.Party ruling,
            IArbitrator arbitrator,
            bytes memory arbitratorExtraData,) = gtcr.getRequestInfo(_itemID, item.numberOfRequests - 1);
        request = RequestData(item,
            disputed,
            disputeID,
            submissionTime,
            resolved,
            parties,
            numberOfRounds,
            ruling,
            arbitrator,
            arbitratorExtraData);
    }
    function getLatestRoundRequestData(address _address, bytes32 _itemID) public view returns (RoundData memory round)  {
        GeneralizedTCR gtcr = GeneralizedTCR(_address);
        RequestData memory request = getLatestRequestData(_address, _itemID);
        (bool appealed,
            uint[3] memory amountPaid,
            bool[3] memory hasPaid,
            uint feeRewards) = gtcr.getRoundInfo(_itemID, request.item.numberOfRequests - 1, request.numberOfRounds - 1);
        round = RoundData(request,
            appealed,
            amountPaid,
            hasPaid,
            feeRewards);
    }
}
