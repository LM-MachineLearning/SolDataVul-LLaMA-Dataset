
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
abstract contract KyberHintHandler is IKyberHint, Utils5 {
    function parseTokenToEthHint(IERC20 tokenSrc, bytes memory hint)
        public
        view
        override
        returns (
            TradeType tokenToEthType,
            bytes32[] memory tokenToEthReserveIds,
            IKyberReserve[] memory tokenToEthAddresses,
            uint256[] memory tokenToEthSplits
        )
    {
        HintErrors error;
        (tokenToEthType, tokenToEthReserveIds, tokenToEthSplits, error) = parseHint(hint);
        if (error != HintErrors.NoError) throwHintError(error);
        if (tokenToEthType == TradeType.MaskIn || tokenToEthType == TradeType.Split) {
            checkTokenListedForReserve(tokenSrc, tokenToEthReserveIds, true);
        }
        tokenToEthAddresses = new IKyberReserve[](tokenToEthReserveIds.length);
        for (uint256 i = 0; i < tokenToEthReserveIds.length; i++) {
            checkReserveIdsExists(tokenToEthReserveIds[i]);
            checkDuplicateReserveIds(tokenToEthReserveIds, i);
            if (i > 0 && tokenToEthType == TradeType.Split) {
                checkSplitReserveIdSeq(tokenToEthReserveIds[i], tokenToEthReserveIds[i - 1]);
            }
            tokenToEthAddresses[i] = IKyberReserve(
                getReserveAddress(tokenToEthReserveIds[i])
            );
        }
    }
    function parseEthToTokenHint(IERC20 tokenDest, bytes memory hint)
        public
        view
        override
        returns (
            TradeType ethToTokenType,
            bytes32[] memory ethToTokenReserveIds,
            IKyberReserve[] memory ethToTokenAddresses,
            uint256[] memory ethToTokenSplits
        )
    {
        HintErrors error;
        (ethToTokenType, ethToTokenReserveIds, ethToTokenSplits, error) = parseHint(hint);
        if (error != HintErrors.NoError) throwHintError(error);
        if (ethToTokenType == TradeType.MaskIn || ethToTokenType == TradeType.Split) {
            checkTokenListedForReserve(tokenDest, ethToTokenReserveIds, false);
        }
        ethToTokenAddresses = new IKyberReserve[](ethToTokenReserveIds.length);
        for (uint256 i = 0; i < ethToTokenReserveIds.length; i++) {
            checkReserveIdsExists(ethToTokenReserveIds[i]);
            checkDuplicateReserveIds(ethToTokenReserveIds, i);
            if (i > 0 && ethToTokenType == TradeType.Split) {
                checkSplitReserveIdSeq(ethToTokenReserveIds[i], ethToTokenReserveIds[i - 1]);
            }
            ethToTokenAddresses[i] = IKyberReserve(
                getReserveAddress(ethToTokenReserveIds[i])
            );
        }
    }
    function parseTokenToTokenHint(IERC20 tokenSrc, IERC20 tokenDest, bytes memory hint)
        public
        view
        override
        returns (
            TradeType tokenToEthType,
            bytes32[] memory tokenToEthReserveIds,
            IKyberReserve[] memory tokenToEthAddresses,
            uint256[] memory tokenToEthSplits,
            TradeType ethToTokenType,
            bytes32[] memory ethToTokenReserveIds,
            IKyberReserve[] memory ethToTokenAddresses,
            uint256[] memory ethToTokenSplits
        )
    {
        bytes memory t2eHint;
        bytes memory e2tHint;
        (t2eHint, e2tHint) = unpackT2THint(hint);
        (
            tokenToEthType,
            tokenToEthReserveIds,
            tokenToEthAddresses,
            tokenToEthSplits
        ) = parseTokenToEthHint(tokenSrc, t2eHint);
        (
            ethToTokenType,
            ethToTokenReserveIds,
            ethToTokenAddresses,
            ethToTokenSplits
        ) = parseEthToTokenHint(tokenDest, e2tHint);
    }
    function buildTokenToEthHint(
        IERC20 tokenSrc,
        TradeType tokenToEthType,
        bytes32[] memory tokenToEthReserveIds,
        uint256[] memory tokenToEthSplits
    ) public view override returns (bytes memory hint) {
        for (uint256 i = 0; i < tokenToEthReserveIds.length; i++) {
            checkReserveIdsExists(tokenToEthReserveIds[i]);
        }
        HintErrors valid = verifyData(
            tokenToEthType,
            tokenToEthReserveIds,
            tokenToEthSplits
        );
        if (valid != HintErrors.NoError) throwHintError(valid);
        if (tokenToEthType == TradeType.MaskIn || tokenToEthType == TradeType.Split) {
            checkTokenListedForReserve(tokenSrc, tokenToEthReserveIds, true);
        }
        if (tokenToEthType == TradeType.Split) {
            bytes32[] memory seqT2EReserveIds;
            uint256[] memory seqT2ESplits;
            (seqT2EReserveIds, seqT2ESplits) = ensureSplitSeq(
                tokenToEthReserveIds,
                tokenToEthSplits
            );
            hint = abi.encode(tokenToEthType, seqT2EReserveIds, seqT2ESplits);
        } else {
            hint = abi.encode(tokenToEthType, tokenToEthReserveIds, tokenToEthSplits);
        }
    }
    function buildEthToTokenHint(
        IERC20 tokenDest,
        TradeType ethToTokenType,
        bytes32[] memory ethToTokenReserveIds,
        uint256[] memory ethToTokenSplits
    ) public view override returns (bytes memory hint) {
        for (uint256 i = 0; i < ethToTokenReserveIds.length; i++) {
            checkReserveIdsExists(ethToTokenReserveIds[i]);
        }
        HintErrors valid = verifyData(
            ethToTokenType,
            ethToTokenReserveIds,
            ethToTokenSplits
        );
        if (valid != HintErrors.NoError) throwHintError(valid);
        if (ethToTokenType == TradeType.MaskIn || ethToTokenType == TradeType.Split) {
            checkTokenListedForReserve(tokenDest, ethToTokenReserveIds, false);
        }
        if (ethToTokenType == TradeType.Split) {
            bytes32[] memory seqE2TReserveIds;
            uint256[] memory seqE2TSplits;
            (seqE2TReserveIds, seqE2TSplits) = ensureSplitSeq(
                ethToTokenReserveIds,
                ethToTokenSplits
            );
            hint = abi.encode(ethToTokenType, seqE2TReserveIds, seqE2TSplits);
        } else {
            hint = abi.encode(ethToTokenType, ethToTokenReserveIds, ethToTokenSplits);
        }
    }
    function buildTokenToTokenHint(
        IERC20 tokenSrc,
        TradeType tokenToEthType,
        bytes32[] memory tokenToEthReserveIds,
        uint256[] memory tokenToEthSplits,
        IERC20 tokenDest,
        TradeType ethToTokenType,
        bytes32[] memory ethToTokenReserveIds,
        uint256[] memory ethToTokenSplits
    ) public view override returns (bytes memory hint) {
        bytes memory t2eHint = buildTokenToEthHint(
            tokenSrc,
            tokenToEthType,
            tokenToEthReserveIds,
            tokenToEthSplits
        );
        bytes memory e2tHint = buildEthToTokenHint(
            tokenDest,
            ethToTokenType,
            ethToTokenReserveIds,
            ethToTokenSplits
        );
        hint = abi.encode(t2eHint, e2tHint);
    }
    function parseHint(bytes memory hint)
        internal
        pure
        returns (
            TradeType tradeType,
            bytes32[] memory reserveIds,
            uint256[] memory splits,
            HintErrors valid
        )
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
        if (getReserveAddress(reserveId) == address(0))
            throwHintError(HintErrors.ReserveIdNotFound);
    }
    function checkTokenListedForReserve(
        IERC20 token,
        bytes32[] memory reserveIds,
        bool isTokenToEth
    ) internal view {
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
                throwHintError(HintErrors.ReserveIdDupError);
            }
        }
    }
    function checkSplitReserveIdSeq(bytes32 reserveId, bytes32 prevReserveId)
        internal
        pure
    {
        if (uint256(reserveId) <= uint256(prevReserveId)) {
            throwHintError(HintErrors.ReserveIdSequenceError);
        }
    }
    function ensureSplitSeq(
        bytes32[] memory reserveIds,
        uint256[] memory splits
    )
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
                    throwHintError(HintErrors.ReserveIdDupError);
                }
            }
        }
        return (reserveIds, splits);
    }
    function verifyData(
        TradeType tradeType,
        bytes32[] memory reserveIds,
        uint256[] memory splits
    ) internal pure returns (HintErrors) {
        if (tradeType == TradeType.BestOfAll) {
            if (reserveIds.length != 0 || splits.length != 0) return HintErrors.NonEmptyDataError;
        }
        if (
            (tradeType == TradeType.MaskIn || tradeType == TradeType.Split) &&
            reserveIds.length == 0
        ) return HintErrors.ReserveIdEmptyError;
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
    function throwHintError(HintErrors error) internal pure {
        if (error == HintErrors.NonEmptyDataError) revert("reserveIds and splits must be empty");
        if (error == HintErrors.ReserveIdDupError) revert("duplicate reserveId");
        if (error == HintErrors.ReserveIdEmptyError) revert("reserveIds cannot be empty");
        if (error == HintErrors.ReserveIdSplitsError) revert("reserveIds.length != splits.length");
        if (error == HintErrors.ReserveIdSequenceError) revert("reserveIds not in increasing order");
        if (error == HintErrors.ReserveIdNotFound) revert("reserveId not found");
        if (error == HintErrors.SplitsNotEmptyError) revert("splits must be empty");
        if (error == HintErrors.TokenListedError) revert("token is not listed for reserveId");
        if (error == HintErrors.TotalBPSError) revert("total BPS != 10000");
    }
    function getReserveAddress(bytes32 reserveId) internal view virtual returns (address);
    function areAllReservesListed(
        bytes32[] memory reserveIds,
        IERC20 src,
        IERC20 dest
    ) internal virtual view returns (bool);
}
