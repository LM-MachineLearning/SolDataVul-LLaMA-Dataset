
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
contract CountdownGriefingEscrow is Countdown, Staking, EventMetadata, Operated, Template {
    using SafeMath for uint256;
    Data private _data;
    struct Data {
        address buyer;
        address seller;
        uint128 paymentAmount;
        uint128 stakeAmount;
        EscrowStatus status;
        AgreementParams agreementParams;
    }
    struct AgreementParams {
        uint120 ratio;
        Griefing.RatioType ratioType;
        uint128 countdownLength;
    }
    event Initialized(
        address operator,
        address buyer,
        address seller,
        uint256 paymentAmount,
        uint256 stakeAmount,
        uint256 countdownLength,
        bytes metadata,
        bytes agreementParams
    );
    event StakeDeposited(address seller, uint256 amount);
    event PaymentDeposited(address buyer, uint256 amount);
    event Finalized(address agreement);
    event DataSubmitted(bytes data);
    event Cancelled();
    function initialize(
        address operator,
        address buyer,
        address seller,
        uint256 paymentAmount,
        uint256 stakeAmount,
        uint256 escrowCountdown,
        bytes memory metadata,
        bytes memory agreementParams
    ) public initializeTemplate() {
        if (buyer != address(0)) {
            _data.buyer = buyer;
        }
        if (seller != address(0)) {
            _data.seller = seller;
        }
        if (operator != address(0)) {
            Operated._setOperator(operator);
        }
        if (paymentAmount != uint256(0)) {
            require(paymentAmount <= uint256(uint128(paymentAmount)), "paymentAmount is too large");
            _data.paymentAmount = uint128(paymentAmount);
        }
        if (stakeAmount != uint256(0)) {
            require(stakeAmount == uint256(uint128(stakeAmount)), "stakeAmount is too large");
            _data.stakeAmount = uint128(stakeAmount);
        }
        Countdown._setLength(escrowCountdown);
        if (metadata.length != 0) {
            EventMetadata._setMetadata(metadata);
        }
        if (agreementParams.length != 0) {
            (
                uint256 ratio,
                Griefing.RatioType ratioType,
                uint256 agreementCountdown
            ) = abi.decode(agreementParams, (uint256, Griefing.RatioType, uint256));
            require(ratio == uint256(uint120(ratio)), "ratio out of bounds");
            require(agreementCountdown == uint256(uint128(agreementCountdown)), "agreementCountdown out of bounds");
            _data.agreementParams = AgreementParams(uint120(ratio), ratioType, uint128(agreementCountdown));
        }
        emit Initialized(operator, buyer, seller, paymentAmount, stakeAmount, escrowCountdown, metadata, agreementParams);
    }
    function setMetadata(bytes memory metadata) public {
        require(Operated.isOperator(msg.sender), "only operator");
        EventMetadata._setMetadata(metadata);
    }
    function depositAndSetSeller(address seller) public {
        require(_data.seller == address(0), "seller already set");
        _data.seller = seller;
        _depositStake();
    }
    function depositStake() public {
        require(_data.seller != address(0), "seller not yet set");
        require(isSeller(msg.sender) || Operated.isOperator(msg.sender), "only seller or operator");
        _depositStake();
    }
    function _depositStake() private {
        require(isOpen() || onlyPaymentDeposited(), "can only deposit stake once");
        address seller = _data.seller;
        uint256 stakeAmount = uint256(_data.stakeAmount);
        if (stakeAmount != uint256(0)) {
            Staking._addStake(seller, msg.sender, stakeAmount);
        }
        emit StakeDeposited(seller, stakeAmount);
        if (onlyPaymentDeposited()) {
            _data.status = EscrowStatus.isDeposited;
            finalize();
        } else {
            _data.status = EscrowStatus.onlyStakeDeposited;
        }
    }
    function depositAndSetBuyer(address buyer) public {
        require(_data.buyer == address(0), "buyer already set");
        _data.buyer = buyer;
        _depositPayment();
    }
    function depositPayment() public {
        require(_data.buyer != address(0), "buyer not yet set");
        require(isBuyer(msg.sender) || Operated.isOperator(msg.sender), "only buyer or operator");
        _depositPayment();
    }
    function _depositPayment() private {
        require(isOpen() || onlyStakeDeposited(), "can only deposit payment once");
        address buyer = _data.buyer;
        uint256 paymentAmount = uint256(_data.paymentAmount);
        if (paymentAmount != uint256(0)) {
            Staking._addStake(buyer, msg.sender, paymentAmount);
        }
        emit PaymentDeposited(buyer, paymentAmount);
        if (onlyStakeDeposited()) {
            _data.status = EscrowStatus.isDeposited;
            Countdown._start();
        } else {
            _data.status = EscrowStatus.onlyPaymentDeposited;
        }
    }
    function finalize() public {
        require(isSeller(msg.sender) || Operated.isOperator(msg.sender), "only seller or operator");
        require(isDeposited(), "only after deposit");
        address agreement;
        {
            address escrowFactory = Template.getFactory();
            address escrowRegistry = iFactory(escrowFactory).getInstanceRegistry();
            address agreementFactory = abi.decode(iRegistry(escrowRegistry).getFactoryData(escrowFactory), (address));
            bytes memory initCalldata = abi.encodeWithSignature(
                'initialize(address,address,address,uint256,uint8,uint256,bytes)',
                address(this),
                _data.seller,
                _data.buyer,
                uint256(_data.agreementParams.ratio),
                _data.agreementParams.ratioType,
                uint256(_data.agreementParams.countdownLength),
                bytes("")
            );
            agreement = iFactory(agreementFactory).create(initCalldata);
        }
        uint256 totalStake;
        {
            uint256 paymentAmount = Deposit._clearDeposit(_data.buyer);
            uint256 stakeAmount = Deposit._clearDeposit(_data.seller);
            totalStake = paymentAmount.add(stakeAmount);
        }
        if (totalStake > 0) {
            require(IERC20(BurnNMR.getToken()).approve(agreement, totalStake), "token approval failed");
            CountdownGriefing(agreement).increaseStake(totalStake);
        }
        CountdownGriefing(agreement).startCountdown();
        address operator = Operated.getOperator();
        if (operator != address(0)) {
            CountdownGriefing(agreement).transferOperator(operator);
        } else {
            CountdownGriefing(agreement).renounceOperator();
        }
        _data.status = EscrowStatus.isFinalized;
        delete _data.paymentAmount;
        delete _data.stakeAmount;
        delete _data.agreementParams;
        emit Finalized(agreement);
    }
    function submitData(bytes memory data) public {
        require(isSeller(msg.sender) || Operated.isOperator(msg.sender), "only seller or operator");
        require(isFinalized(), "only after finalized");
        emit DataSubmitted(data);
    }
    function cancel() public {
        require(isSeller(msg.sender) || isBuyer(msg.sender) || Operated.isOperator(msg.sender), "only seller or buyer or operator");
        require(isOpen() || onlyStakeDeposited() || onlyPaymentDeposited(), "only before deposits are completed");
        _cancel();
    }
    function timeout() public {
        require(isBuyer(msg.sender) || Operated.isOperator(msg.sender), "only buyer or operator");
        require(isDeposited() && Countdown.isOver(), "only after countdown ended");
        _cancel();
    }
    function _cancel() private {
        address seller = _data.seller;
        address buyer = _data.buyer;
        if (Staking.getStake(seller) != 0) {
            Staking._takeFullStake(seller, seller);
        }
        if (Staking.getStake(buyer) != 0) {
            Staking._takeFullStake(buyer, buyer);
        }
        _data.status = EscrowStatus.isCancelled;
        delete _data.paymentAmount;
        delete _data.stakeAmount;
        delete _data.agreementParams;
        emit Cancelled();
    }
    function transferOperator(address operator) public {
        require(Operated.isOperator(msg.sender), "only operator");
        Operated._transferOperator(operator);
    }
    function renounceOperator() public {
        require(Operated.isOperator(msg.sender), "only operator");
        Operated._renounceOperator();
    }
    function getBuyer() public view returns (address buyer) {
        return _data.buyer;
    }
    function isBuyer(address caller) internal view returns (bool validity) {
        return caller == getBuyer();
    }
    function getSeller() public view returns (address seller) {
        return _data.seller;
    }
    function isSeller(address caller) internal view returns (bool validity) {
        return caller == getSeller();
    }
    function getData() public view returns (
        uint128 paymentAmount,
        uint128 stakeAmount,
        uint120 ratio,
        Griefing.RatioType ratioType,
        uint128 countdownLength
    ) {
        return (
            _data.paymentAmount,
            _data.stakeAmount,
            _data.agreementParams.ratio,
            _data.agreementParams.ratioType,
            _data.agreementParams.countdownLength
        );
    }
    enum EscrowStatus { isOpen, onlyStakeDeposited, onlyPaymentDeposited, isDeposited, isFinalized, isCancelled }
    function getEscrowStatus() public view returns (EscrowStatus status) {
        return _data.status;
    }
    function isOpen() internal view returns (bool validity) {
        return getEscrowStatus() == EscrowStatus.isOpen;
    }
    function onlyStakeDeposited() internal view returns (bool validity) {
        return getEscrowStatus() == EscrowStatus.onlyStakeDeposited;
    }
    function onlyPaymentDeposited() internal view returns (bool validity) {
        return getEscrowStatus() == EscrowStatus.onlyPaymentDeposited;
    }
    function isDeposited() internal view returns (bool validity) {
        return getEscrowStatus() == EscrowStatus.isDeposited;
    }
    function isFinalized() internal view returns (bool validity) {
        return getEscrowStatus() == EscrowStatus.isFinalized;
    }
    function isCancelled() internal view returns (bool validity) {
        return getEscrowStatus() == EscrowStatus.isCancelled;
    }
}
