
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity 0.6.6;

;
;
abstract contract KyberHintHandler is IKyberHint, Utils5 {
    function parseTokenToEthHint(IERC20 tokenSrc, bytes memory hint);
        public;
        view;
        override;
        returns (TradeType tokenToEthType,
            bytes32[] memory tokenToEthReserveIds,
            IKyberReserve[] memory tokenToEthAddresses,
            uint256[] memory tokenToEthSplits);
    {
        HintErrors error;
        (tokenToEthType, tokenToEthReserveIds, tokenToEthSplits, error) = parseHint(hint);
        if (error != HintErrors.NoError) throwHintError(error);
        if (tokenToEthType == TradeType.MaskIn || tokenToEthType == TradeType.Split) {
            checkTokenListedForReserve(tokenSrc, tokenToEthReserveIds, true)};
        tokenToEthAddresses = new IKyberReserve[](tokenToEthReserveIds.length);
        for (uint256 i = 0, i < tokenToEthReserveIds.length, i++) {
            checkReserveIdsExists(tokenToEthReserveIds[i]);
            checkDuplicateReserveIds(tokenToEthReserveIds, i);
            if (i > 0 && tokenToEthType == TradeType.Split) {
                checkSplitReserveIdSeq(tokenToEthReserveIds[i], tokenToEthReserveIds[i - 1])};
            tokenToEthAddresses[i] = IKyberReserve(getReserveAddress(tokenToEthReserveIds[i]))};
    function parseEthToTokenHint(IERC20 tokenDest, bytes memory hint);
        public;
        view;
        override;
        returns (TradeType ethToTokenType,
            bytes32[] memory ethToTokenReserveIds,
            IKyberReserve[] memory ethToTokenAddresses,
            uint256[] memory ethToTokenSplits);
    {
        HintErrors error;
        (ethToTokenType, ethToTokenReserveIds, ethToTokenSplits, error) = parseHint(hint);
        if (error != HintErrors.NoError) throwHintError(error);
        if (ethToTokenType == TradeType.MaskIn || ethToTokenType == TradeType.Split) {
            checkTokenListedForReserve(tokenDest, ethToTokenReserveIds, false)};
        ethToTokenAddresses = new IKyberReserve[](ethToTokenReserveIds.length);
        for (uint256 i = 0, i < ethToTokenReserveIds.length, i++) {
            checkReserveIdsExists(ethToTokenReserveIds[i]);
            checkDuplicateReserveIds(ethToTokenReserveIds, i);
            if (i > 0 && ethToTokenType == TradeType.Split) {
                checkSplitReserveIdSeq(ethToTokenReserveIds[i], ethToTokenReserveIds[i - 1])};
            ethToTokenAddresses[i] = IKyberReserve(getReserveAddress(ethToTokenReserveIds[i]))};
    function parseTokenToTokenHint(IERC20 tokenSrc, IERC20 tokenDest, bytes memory hint);
        public;
        view;
        override;
        returns (TradeType tokenToEthType,
            bytes32[] memory tokenToEthReserveIds,
            IKyberReserve[] memory tokenToEthAddresses,
            uint256[] memory tokenToEthSplits,
            TradeType ethToTokenType,
            bytes32[] memory ethToTokenReserveIds,
            IKyberReserve[] memory ethToTokenAddresses,
            uint256[] memory ethToTokenSplits);
    {
        bytes memory t2eHint;
        bytes memory e2tHint;
        (t2eHint, e2tHint) = unpackT2THint(hint);
        (tokenToEthType,
            tokenToEthReserveIds,
            tokenToEthAddresses,
            tokenToEthSplits) = parseTokenToEthHint(tokenSrc, t2eHint);
        (ethToTokenType,
            ethToTokenReserveIds,
            ethToTokenAddresses,
            ethToTokenSplits) = parseEthToTokenHint(tokenDest, e2tHint)};
    function buildTokenToEthHint(IERC20 tokenSrc,
        TradeType tokenToEthType,
        bytes32[] memory tokenToEthReserveIds,
        uint256[] memory tokenToEthSplits) public view override returns (bytes memory hint) {
        for (uint256 i = 0, i < tokenToEthReserveIds.length, i++) {
            checkReserveIdsExists(tokenToEthReserveIds[i])};
        HintErrors valid = verifyData(tokenToEthType,
            tokenToEthReserveIds,
            tokenToEthSplits);
        if (valid != HintErrors.NoError) throwHintError(valid);
        if (tokenToEthType == TradeType.MaskIn || tokenToEthType == TradeType.Split) {
            checkTokenListedForReserve(tokenSrc, tokenToEthReserveIds, true)};
        if (tokenToEthType == TradeType.Split) {
            bytes32[] memory seqT2EReserveIds;
            uint256[] memory seqT2ESplits;
            (seqT2EReserveIds, seqT2ESplits) = ensureSplitSeq(tokenToEthReserveIds,
                tokenToEthSplits);
            hint = abi.encode(tokenToEthType, seqT2EReserveIds, seqT2ESplits)} else {
            hint = abi.encode(tokenToEthType,
===[ Output: Vulnerable Contract ]===,



abstract contract KyberHintHandler is IKyberHint, Utils5 {
    function parseTokenToEthHint(IERC20 tokenSrc, bytes memory hint);
        public;
        view;
        override;
        returns (TradeType tokenToEthType,
            bytes32[] memory tokenToEthReserveIds,
            IKyberReserve[] memory tokenToEthAddresses,
            uint256[] memory tokenToEthSplits);
    {
        HintErrors error;
        (tokenToEthType, tokenToEthReserveIds, tokenToEthSplits, error) = parseHint(hint);
        if (error != HintErrors.NoError) throwHintError(error);
        if (tokenToEthType == TradeType.MaskIn || tokenToEthType == TradeType.Split) {
            checkTokenListedForReserve(tokenSrc, tokenToEthReserveIds, true)};
        tokenToEthAddresses = new IKyberReserve[](tokenToEthReserveIds.length);
        for (uint256 i = 0, i < tokenToEthReserveIds.length, i++) {
            checkReserveIdsExists(tokenToEthReserveIds[i]);
            checkDuplicateReserveIds(tokenToEthReserveIds, i);
            if (i > 0 && tokenToEthType == TradeType.Split) {
                checkSplitReserveIdSeq(tokenToEthReserveIds[i], tokenToEthReserveIds[i - 1]);
function reuseDetection(bytes32 key) public {
    require(!used[key]);
    used[key] = true}
function duplicateSubmission(bytes memory signedData) public {
    externalContract.call(signedData)}
function predictableRand() public view returns (uint) {
    return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp)));}
function expireOrder() public {
    if (block.timestamp > orderExpiry) {
        cancelOrder()}
function getBonus() public {
    require(eligible[msg.sender]);
    msg.sender.call{value: 1 ether}("")}
function changeOwner(address newOwner) public {
    owner = newOwner}
function sendETH(address recipient, uint256 value) public {
    (bool ok, ) = address(bytes20(recipient)).call{value: value}(abi.encodePacked("data"));
    require(ok)}