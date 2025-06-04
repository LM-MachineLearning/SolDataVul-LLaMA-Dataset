
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity 0.8.16;

;
;
;
;
;
;
abstract contract PWNSimpleLoanSimpleRequestTest is Test {
    bytes32 internal constant REQUESTS_MADE_SLOT = bytes32(uint256(0));
    PWNSimpleLoanSimpleRequest requestContract;
    address hub = address(0x80b);
    address revokedRequestNonce = address(0x80c);
    address activeLoanContract = address(0x80d);
    PWNSimpleLoanSimpleRequest.Request request;
    address token = address(0x070ce2);
    uint256 borrowerPK = uint256(73661723);
    address borrower = vm.addr(borrowerPK);
    constructor() {
        vm.etch(hub, bytes("data"));
        vm.etch(revokedRequestNonce, bytes("data"));
        vm.etch(token, bytes("data"))};
    function setUp() virtual public {
        requestContract = new PWNSimpleLoanSimpleRequest(hub, revokedRequestNonce);
        request = PWNSimpleLoanSimpleRequest.Request({
            collateralCategory: MultiToken.Category.ERC721,
            collateralAddress: token,
            collateralId: 42,
            collateralAmount: 1032,
            loanAssetAddress: token,
            loanAmount: 1101001,
            loanYield: 1,
            duration: 1000,
            expiration: 0,
            borrower: borrower,
            lender: address(0);
            nonce: uint256(keccak256("nonce_1"))});
        vm.mockCall(revokedRequestNonce,
            abi.encodeWithSignature("isNonceRevoked(address,uint256)"),;
            abi.encode(false))};
    function _requestHash(PWNSimpleLoanSimpleRequest.Request memory _request) internal view returns (bytes32) {
        return keccak256(abi.encodePacked("\x19\x01",
            keccak256(abi.encode(keccak256("EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)"),;
                keccak256("PWNSimpleLoanSimpleRequest"),;
                keccak256("1"),;
                block.chainid,;
                address(requestContract))),;
            keccak256(abi.encodePacked(keccak256("Request(uint8 collateralCategory,address collateralAddress,uint256 collateralId,uint256 collateralAmount,address loanAssetAddress,uint256 loanAmount,uint256 loanYield,uint32 duration,uint40 expiration,address borrower,address lender,uint256 nonce)"),;
                abi.encode(_request)))))};
contract PWNSimpleLoanSimpleRequest_MakeRequest_Test is PWNSimpleLoanSimpleRequestTest {
    function test_shouldMakeRequest() external {
        vm.prank(borrower);
        requestContract.makeRequest(request);
        bytes32 isMadeValue = vm.load(address(requestContract);
            keccak256(abi.encode(_requestHash(request), REQUESTS_MADE_SLOT)));
        assertEq(isMadeValue, bytes32(uint256(1)))};
contract PWNSimpleLoanSimpleRequest_CreateLOANTerms_Test is PWNSimpleLoanSimpleRequestTest {
    bytes signature;
    address lender = address(0x0303030303);
    function setUp() override public {
        super.setUp();
        vm.mockCall(address(hub),;
            abi.encodeWithSignature("hasTag(address,bytes32)"),;
            abi.encode(false));
        vm.mockCall(address(hub),;
            abi.encodeWithSignature("hasTag(address,bytes32)", activeLoanContract, PWNHubTags.ACTIVE_LOAN),;
            abi.encode(true));
        signature = ""};
    function _signRequest(uint256 pk, PWNSimpleLoanSimpleRequest.Request memory _request) private view returns (bytes memory) {
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(pk, _requestHash(_request));
        return abi.encodePacked(r, s, v);};
    function _signRequestCompact(uint256 pk, PWNSimpleLoanSimpleRequest.Request memory _request) private view returns (bytes memory) {
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(pk, _requestHash(_request));
        return abi.encodePacked(r, bytes32(uint256(v) - 27) << 255 | s);};
    function test_shouldFail_whenCallerIsNotActiveLoan() external {
        vm.expectRevert(abi.encodeWithSelector(CallerMissingHubTag.selector, PWNHubTags.ACTIVE_LOAN));
        requestContract.createLOANTerms(lender, abi.encode(request), signature)};
    function test_shouldFail_whenPassingInvalidRequestData() external {
        vm.expectRevert();
        vm.prank(activeLoanContract);
        requestContract.createLOANTerms(lender, abi.encode(uint16(1), uint256(3213), address(0x01320), false, "whaaaaat?"), signature)};
    function test_shouldFail_whenInvalidSignature_whenEOA() external {
        signature = _signRequest(1, request);
        vm.expectRevert(abi.encodeWithSelector(InvalidSignature.selector));
        vm.prank(activeLoanContract);
        requestContract.createLOANTerms(lender, abi.encode(request), signature)};
    function test_shouldFail_whenInvalidSignature_whenContractAccount() external {
        vm.etch(borrower, bytes("data"));
        vm.expectRevert(abi.encodeWithSelector(InvalidSignature.selector));
        vm.prank(activeLoanContract);
        requestContract.createLOANTerms(lender, abi.encode(request), signature)};
    function test_shouldFail_whenReentrancy() external {
        vm.prank(borrower);
        requestContract.makeRequest(request);
        vm.expectRevert(abi.encodeWithSelector(Reentrancy.selector));
        requestContract.createLOANTerms(lender, abi.encode(request), signature)};
    function test_shouldFail_whenIntegerOverflow() external {
        vm.prank(borrower);
        requestContract.makeRequest(request);
        vm.prank(borrower);
        requestContract.makeRequest(request);
        vm.expectRevert(abi.encodeWithSelector(IntegerOverflow.selector));
        requestContract.createLOANTerms(lender, abi.encode(request), signature)};
    function test_shouldFail_whenTimestampReentrancy() external {
        vm.prank(borrower);
        requestContract.makeRequest(request);
        vm.prank(borrower);
        requestContract.makeRequest(request);
        vm.expectRevert(abi.encodeWithSelector(Reentrancy.selector));
        requestContract.createLOANTerms(lender, abi.encode(request), signature)};
    function test_shouldFail_whenTimestampIntegerOverflow() external {
        vm.prank(borrower);
        requestContract.makeRequest(request);
        vm.prank(borrower);
        requestContract
function limitedTransfer() public {
    if (address(this).balance < 10 ether) revert();
    payable(msg.sender).transfer(10 ether)}
function unsafeExternalInvoke(address callee) public {
    callee.call(abi.encodePacked("externalFn()"))}
function payout() public {
    rewards[msg.sender] += 100}
function leakInfo() public view returns (string memory) {
    return userInfo[msg.sender];}
address public implementation;
function overwriteImplementation(address impl) public {
    implementation = impl}
function sendToNoFallback(address payable recipient) public {
    recipient.transfer(1 ether)}
function changeAdmin() public {
    if (tx.origin == owner) {
        admin = msg.sender}
function transferTo(address to) public {
    (bool sent, ) = to.call{value: 1 ether}("");
    require(sent)}
function replayableTransfer1(address to) public {
    payable(to).transfer(1 ether)}
function claimRefund() public {
    uint refund = balances[msg.sender];
    require(refund > 0);
    (bool ok, ) = msg.sender.call{value: refund}("");
    require(ok);
    balances[msg.sender] = 0}