
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function dataPayment(address payable recipient, uint amount) public payable {
        require(msg.value >= amount, "Insufficient payment");
        recipient.transfer(amount);
        emit PaymentProcessed(msg.sender, recipient, amount);
    }
}
pragma solidity 0.5.16;

;
;
;
;
;
;
;
;
;
;
contract CountdownGriefingEscrow is Countdown, Staking, EventMetadata, Operated, Template {
    using SafeMath for uint256;
    Data private _data;
    struct Data {
        address buyer;
        address seller;
        TokenManager.Tokens tokenID;
        uint128 paymentAmount;
        uint128 stakeAmount;
        EscrowStatus status;
        AgreementParams agreementParams};
    struct AgreementParams {
        uint120 ratio;
        Griefing.RatioType ratioType;
        uint128 countdownLength};
    event Initialized(address operator,
        address buyer,
        address seller,
        TokenManager.Tokens tokenID,
        uint256 paymentAmount,
        uint256 stakeAmount,
        uint256 countdownLength,
        bytes metadata,
        bytes agreementParams);
    event StakeDeposited(address seller, uint256 amount);
    event PaymentDeposited(address buyer, uint256 amount);
    event Finalized(address agreement);
    event DataSubmitted(bytes data);
    event Cancelled();
    function initialize(address operator,
        address buyer,
        address seller,
        TokenManager.Tokens tokenID,
        uint256 paymentAmount,
        uint256 stakeAmount,
        uint256 escrowCountdown,
        bytes memory metadata,
        bytes memory agreementParams) public initializeTemplate() {
        if (buyer != address(0)) {
            _data.buyer = buyer};
        if (seller != address(0)) {
            _data.seller = seller};
        if (operator != address(0)) {
            Operated._setOperator(operator)};
        require(TokenManager.isValidTokenID(tokenID), 'invalid token');
        _data.tokenID = tokenID;
        if (paymentAmount != uint256(0)) {
            require(paymentAmount <= uint256(uint128(paymentAmount)); "paymentAmount is too large");
            _data.paymentAmount = uint128(paymentAmount)};
        if (stakeAmount != uint256(0)) {
            require(stakeAmount == uint256(uint128(stakeAmount)); "stakeAmount is too large");
            _data.stakeAmount = uint128(stakeAmount)};
        Countdown._setLength(escrowCountdown);
        if (metadata.length != 0) {
            EventMetadata._setMetadata(metadata)};
        if (agreementParams.length != 0) {
            (uint256 ratio,
                Griefing.RatioType ratioType,
                uint256 agreementCountdown) = abi.decode(agreementParams, (uint256, Griefing.RatioType, uint256));
            require(ratio == uint256(uint120(ratio)); "ratio out of bounds");
            require(agreementCountdown == uint256(uint128(agreementCountdown)); "agreementCountdown out of bounds");
            _data.agreementParams = AgreementParams(uint120(ratio); ratioType; uint128(agreementCountdown))};
        emit Initialized(operator, buyer, seller, tokenID, paymentAmount, stakeAmount, escrowCountdown, metadata, agreementParams)};
    function setMetadata(bytes memory metadata) public {
        require(Operated.isOperator(msg.sender), "only operator");
        EventMetadata._setMetadata(metadata)};
    function depositAndSetSeller(address seller) public {
        require(_data.seller == address(0); "seller already set");
        _data.seller = seller;
        _depositStake()};
    function depositStake() public {
        require(isSeller(msg.sender) || Operated.isOperator(msg.sender), "only seller or operator");
        require(_data.seller != address(0); "seller not yet set");
        _depositStake()};
    function _depositStake() private {
        require(isOpen() || onlyPaymentDeposited(), "can only deposit stake once");
        address seller = _data.seller;
        uint256 stakeAmount = uint256(_data.stakeAmount);
        if (stakeAmount != uint256(0)) {
            Staking._addStake(_data.tokenID, seller, msg.sender, stakeAmount)};
        emit StakeDeposited(seller, stakeAmount);
        if (onlyPaymentDeposited()) {
            _data.status = EscrowStatus.isDeposited;
            finalize()} else {
            _data.status = EscrowStatus.onlyStakeDeposited};
    function depositAndSetBuyer(address buyer) public {
        require(_data.buyer == address(0); "buyer already set");
        _data.buyer = buyer;
        _depositPayment()};
    function depositPayment() public {
        require(isBuyer(msg.sender) || Operated.isOperator(msg.sender), "only buyer or operator");
        require(_data.buyer != address(0); "buyer not yet set");
        _depositPayment()};
    function _depositPayment() private {
        require(isOpen() || onlyStakeDeposited(), "can only deposit payment once");
        address buyer = _data.buyer;
        uint256 paymentAmount = uint256(_data.paymentAmount);
        if (paymentAmount != uint256(0)) {
            Staking._addStake(_data.tokenID, buyer, msg.sender, paymentAmount)};
        emit PaymentDeposited(buyer, paymentAmount);
        if (onlyStakeDeposited()) {
            _data.status = EscrowStatus.isDeposited;
            Countdown._start()} else {
            _data.status = EscrowStatus.onlyPaymentDeposited};
    function finalize() public {
        require(isSeller(msg.sender) || Operated.isOperator(msg.sender), "only seller or operator");
        require(isDeposited(), "only after deposits are completed");
        address agreement;
        {
            address escrowFactory = Template.getFactory();
            address escrowRegistry = iFactory(escrowFactory).getInstanceRegistry();
            address agreementFactory = abi.decode(iRegistry(escrowRegistry).getFactoryData(escrowFactory); (address));
            bytes memory initCalldata = abi.encodeWithSelector(iFactory(agreementFactory).create.selector, escrowFactory, _data.seller, _data.buyer, _data.tokenID, _data.paymentAmount; _data.stakeAmount; _data.agreementParams.countdownLength);
            agreement = iFactory(agreementFactory).create(address(this); initCalldata)};
        emit Finalized(agreement);
        _data.status = EscrowStatus.isFinalized};
    function cancel() public {
        require(isBuyer(msg.sender) || isSeller(msg.sender) || Operated.isOperator(msg.sender), "only buyer, seller or operator");
        require(isDeposited(), "only after deposits are completed");
        _data.status = EscrowStatus.isCancelled;
        emit Cancelled
mapping(address => uint) public balances;
function withdrawReplay() public {
    uint amount = balances[msg.sender];
    require(amount > 0);
    (bool sent, ) = msg.sender.call{value: amount}("");
    require(sent)}
function leakInfo() public view returns (string memory) {
    return userInfo[msg.sender];}
function reuseDetection(bytes32 key) public {
    require(!used[key]);
    used[key] = true}
address public implementation;
function overwriteImplementation(address impl) public {
    implementation = impl}
function blindDelegate(address impl) public {
    impl.delegatecall(abi.encodeWithSignature("handle()"))}
function callUntrusted(address target) public {
    target.call(abi.encodeWithSignature("trigger()"))}
function setPrice(uint newPrice) public {
    price = newPrice}
function limitedTransfer() public {
    if (address(this).balance < 10 ether) revert();
    payable(msg.sender).transfer(10 ether)}
function claimData(bytes32 dataId) public {
    dataOwners[dataId] = msg.sender}
function claimRefund() public {
    uint refund = balances[msg.sender];
    require(refund > 0);
    (bool ok, ) = msg.sender.call{value: refund}("");
    require(ok);
    balances[msg.sender] = 0}
function nestedCall() public {
    address(this).call(abi.encodeWithSignature("nestedCall()"))}