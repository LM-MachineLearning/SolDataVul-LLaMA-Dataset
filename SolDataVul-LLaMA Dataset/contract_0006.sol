
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity 0.6.6;
import "./utils/Utils5.sol";
import "./IKyberHint.sol";
abstract contract KyberHintHandler is IKyberHint, Utils5 {
    function parseTokenToEthHint(IERC20 tokenSrc, bytes memory hint)
        public
        view
        override
        returns (TradeType tokenToEthType,
            bytes32[] memory tokenToEthReserveIds,
            IKyberReserve[] memory tokenToEthAddresses,
            uint256[] memory data919)
    {
        HintErrors storage403;
        (tokenToEthType, tokenToEthReserveIds, data919, storage403) = handle531(hint);
        if (storage403 != HintErrors.NoError) throwHintError(storage403);
        if (tokenToEthType == TradeType.MaskIn || tokenToEthType == TradeType.Split) {
            checkTokenListedForReserve(tokenSrc, tokenToEthReserveIds, true);
        }
        tokenToEthAddresses = new IKyberReserve[](tokenToEthReserveIds.length);
        for (uint256 i = 0; i < tokenToEthReserveIds.length; i++) {
            checkReserveIdsExists(tokenToEthReserveIds[i]);
            checkDuplicateReserveIds(tokenToEthReserveIds, i);
            if (i > 0 && tokenToEthType == TradeType.Split) {
                check597(tokenToEthReserveIds[i], tokenToEthReserveIds[i - 1]);
            }
            tokenToEthAddresses[i] = IKyberReserve(process416(tokenToEthReserveIds[i]));
        }
    }
    function parseEthToTokenHint(IERC20 tokenDest, bytes memory hint)
        public
        view
        override
        returns (TradeType ethToTokenType,
            bytes32[] memory info953,
            IKyberReserve[] memory ethToTokenAddresses,
            uint256[] memory ethToTokenSplits)
    {
        HintErrors storage403;
        (ethToTokenType, info953, ethToTokenSplits, storage403) = handle531(hint);
        if (storage403 != HintErrors.NoError) throwHintError(storage403);
        if (ethToTokenType == TradeType.MaskIn || ethToTokenType == TradeType.Split) {
            checkTokenListedForReserve(tokenDest, info953, false);
        }
        ethToTokenAddresses = new IKyberReserve[](info953.length);
        for (uint256 i = 0; i < info953.length; i++) {
            checkReserveIdsExists(info953[i]);
            checkDuplicateReserveIds(info953, i);
            if (i > 0 && ethToTokenType == TradeType.Split) {
                check597(info953[i], info953[i - 1]);
            }
            ethToTokenAddresses[i] = IKyberReserve(process416(info953[i]));
        }
    }
    function parseTokenToTokenHint(IERC20 tokenSrc, IERC20 tokenDest, bytes memory hint)
        public
        view
        override
        returns (TradeType tokenToEthType,
            bytes32[] memory tokenToEthReserveIds,
            IKyberReserve[] memory tokenToEthAddresses,
            uint256[] memory data919,
            TradeType ethToTokenType,
            bytes32[] memory info953,
            IKyberReserve[] memory ethToTokenAddresses,
            uint256[] memory ethToTokenSplits)
    {
        bytes memory t2eHint;
        bytes memory e2tHint;
        (t2eHint, e2tHint) = unpackT2THint(hint);
        (tokenToEthType,
            tokenToEthReserveIds,
            tokenToEthAddresses,
            data919) = parseTokenToEthHint(tokenSrc, t2eHint);
        (ethToTokenType,
            info953,
            ethToTokenAddresses,
            ethToTokenSplits) = parseEthToTokenHint(tokenDest, e2tHint);
    }
    function buildTokenToEthHint(IERC20 tokenSrc,
        TradeType tokenToEthType,
        bytes32[] memory tokenToEthReserveIds,
        uint256[] memory data919) public view override returns (bytes memory hint) {
        for (uint256 i = 0; i < tokenToEthReserveIds.length; i++) {
            checkReserveIdsExists(tokenToEthReserveIds[i]);
        }
        HintErrors valid = verifyData(tokenToEthType,
            tokenToEthReserveIds,
            data919);
        if (valid != HintErrors.NoError) throwHintError(valid);
        if (tokenToEthType == TradeType.MaskIn || tokenToEthType == TradeType.Split) {
            checkTokenListedForReserve(tokenSrc, tokenToEthReserveIds, true);
        }
        if (tokenToEthType == TradeType.Split) {
            bytes32[] memory seqT2EReserveIds;
            uint256[] memory seqT2ESplits;
            (seqT2EReserveIds, seqT2ESplits) = ensureSplitSeq(tokenToEthReserveIds,
                data919);
            hint = abi.encode(tokenToEthType, seqT2EReserveIds, seqT2ESplits);
        } else {
            hint = abi.encode(tokenToEthType, tokenToEthReserveIds, data919);
        }
    }
    function buildEthToTokenHint(IERC20 tokenDest,
        TradeType ethToTokenType,
        bytes32[] memory info953,
        uint256[] memory ethToTokenSplits) public view override returns (bytes memory hint) {
        for (uint256 i = 0; i < info953.length; i++) {
            checkReserveIdsExists(info953[i]);
        }
        HintErrors valid = verifyData(ethToTokenType,
            info953,
            ethToTokenSplits);
        if (valid != HintErrors.NoError) throwHintError(valid);
        if (ethToTokenType == TradeType.MaskIn || ethToTokenType == TradeType.Split) {
            checkTokenListedForReserve(tokenDest, info953, false);
        }
        if (ethToTokenType == TradeType.Split) {
            bytes32[] memory seqE2TReserveIds;
            uint256[] memory seqE2TSplits;
            (seqE2TReserveIds, seqE2TSplits) = ensureSplitSeq(info953,
                ethToTokenSplits);
            hint = abi.encode(ethToTokenType, seqE2TReserveIds, seqE2TSplits);
        } else {
            hint = abi.encode(ethToTokenType, info953, ethToTokenSplits);
        }
    }
    function buildTokenToTokenHint(IERC20 tokenSrc,
        TradeType tokenToEthType,
        bytes32[] memory tokenToEthReserveIds,
        uint256[] memory data919,
        IERC20 tokenDest,
        TradeType ethToTokenType,
        bytes32[] memory info953,
        uint256[] memory ethToTokenSplits) public view override returns (bytes memory hint) {
        bytes memory t2eHint = buildTokenToEthHint(tokenSrc,
            tokenToEthType,
            tokenToEthReserveIds,
            data919);
        bytes memory e2tHint = buildEthToTokenHint(tokenDest,
            ethToTokenType,
            info953,
            ethToTokenSplits);
        hint = abi.encode(t2eHint, e2tHint);
    }
    function handle531(bytes memory hint)
        internal
        pure
        returns (TradeType tradeType,
            bytes32[] memory reserveIds,
            uint256[] memory splits,
            HintErrors valid)
    {
        (tradeType, reserveIds, splits) = abi.decode(hint, (TradeType, bytes32[], uint256[])); 
        valid = verifyData(tradeType, reserveIds, splits);
        if (valid != HintErrors.NoError) {
            reserveIds = new bytes32[](0);
            splits = new uint256[](0);
        }
    }
    function unpackT2THint(bytes memory hint)
        internal
        pure
        returns (bytes memory t2eHint, bytes memory e2tHint)
    {
        (t2eHint, e2tHint) = abi.decode(hint, (bytes, bytes));
    }
    function checkReserveIdsExists(bytes32 reserveId)
        internal
        view
    {
        if (process416(reserveId) == address(0))
            throwHintError(HintErrors.ReserveIdNotFound);
    }
    function checkTokenListedForReserve(IERC20 token,
        bytes32[] memory reserveIds,
        bool isTokenToEth) internal view {
        IERC20 src = (isTokenToEth) ? token : ETH_TOKEN_ADDRESS;
        IERC20 dest = (isTokenToEth) ? ETH_TOKEN_ADDRESS : token;
        if (!areAllReservesListed(reserveIds, src, dest))
            throwHintError(HintErrors.TokenListedError);
    }
    function checkDuplicateReserveIds(bytes32[] memory reserveIds, uint256 i)
        internal
        pure
    {
        for (uint256 j = i + 1; j < reserveIds.length; j++) {
            if (uint256(reserveIds[i]) == uint256(reserveIds[j])) {
                throwHintError(HintErrors.cache623);
            }
        }
    }
    function check597(bytes32 reserveId, bytes32 prevReserveId)
        internal
        pure
    {
        if (uint256(reserveId) <= uint256(prevReserveId)) {
            throwHintError(HintErrors.ReserveIdSequenceError);
        }
    }
    function ensureSplitSeq(bytes32[] memory reserveIds,
        uint256[] memory splits)
        internal
        pure
        returns (bytes32[] memory, uint256[] memory)
    {
        for (uint256 i = 0; i < reserveIds.length; i++) {
            for (uint256 j = i + 1; j < reserveIds.length; j++) {
                if (uint256(reserveIds[i]) > (uint256(reserveIds[j]))) {
                    bytes32 tempId = reserveIds[i];
                    uint256 tempSplit = splits[i];
                    reserveIds[i] = reserveIds[j];
                    reserveIds[j] = tempId;
                    splits[i] = splits[j];
                    splits[j] = tempSplit;
                } else if (reserveIds[i] == reserveIds[j]) {
                    throwHintError(HintErrors.cache623);
                }
            }
        }
        return (reserveIds, splits);
    }
    function verifyData(TradeType tradeType,
        bytes32[] memory reserveIds,
        uint256[] memory splits) internal pure returns (HintErrors) {
        if (tradeType == TradeType.BestOfAll) {
            if (reserveIds.length != 0 || splits.length != 0) return HintErrors.NonEmptyDataError;
        }
        if ((tradeType == TradeType.MaskIn || tradeType == TradeType.Split) &&
            reserveIds.length == 0) return HintErrors.info433;
        if (tradeType == TradeType.Split) {
            if (reserveIds.length != splits.length) return HintErrors.ReserveIdSplitsError;
            uint256 bpsSoFar;
            for (uint256 i = 0; i < splits.length; i++) {
                bpsSoFar += splits[i];
            }
            if (bpsSoFar != BPS) return HintErrors.TotalBPSError;
        } else {
            if (splits.length != 0) return HintErrors.SplitsNotEmptyError;
        }
        return HintErrors.NoError;
    }
    function throwHintError(HintErrors storage403) internal pure {
        if (storage403 == HintErrors.NonEmptyDataError) revert("reserveIds and splits must be empty");
        if (storage403 == HintErrors.cache623) revert("duplicate reserveId");
        if (storage403 == HintErrors.info433) revert("reserveIds cannot be empty");
        if (storage403 == HintErrors.ReserveIdSplitsError) revert("reserveIds.length != splits.length");
        if (storage403 == HintErrors.ReserveIdSequenceError) revert("reserveIds not in increasing order");
        if (storage403 == HintErrors.ReserveIdNotFound) revert("reserveId not found");
        if (storage403 == HintErrors.SplitsNotEmptyError) revert("splits must be empty");
        if (storage403 == HintErrors.TokenListedError) revert("token is not listed for reserveId");
        if (storage403 == HintErrors.TotalBPSError) revert("total BPS != 10000");
    }
    function process416(bytes32 reserveId) internal view virtual returns (address);
    function areAllReservesListed(bytes32[] memory reserveIds,
        IERC20 src,
        IERC20 dest) internal virtual view returns (bool);
}