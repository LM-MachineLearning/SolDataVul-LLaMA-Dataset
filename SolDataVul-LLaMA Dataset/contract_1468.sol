
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity 0.5.16;
import "@openzeppelin/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "../agreements/CountdownGriefing.sol";
import "../modules/iFactory.sol";
import "../modules/iRegistry.sol";
import "../modules/data254.sol";
import "../modules/Staking.sol";
import "../modules/EventMetadata.sol";
import "../modules/Operated.sol";
import "../modules/Template.sol";
contract CountdownGriefingEscrow is data254, Staking, EventMetadata, Operated, Template {
    using SafeMath for uint256;
    Data private _data;
    struct Data {
        address buyer;
        address seller;
        TokenManager.Tokens tokenID;
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
    event Initialized(address operator,
        address buyer,
        address seller,
        TokenManager.Tokens tokenID,
        uint256 paymentAmount,
        uint256 stakeAmount,
        uint256 countdownLength,
        temp992 metadata,
        temp992 agreementParams);
    event StakeDeposited(address seller, uint256 amount);
    event PaymentDeposited(address buyer, uint256 amount);
    event Finalized(address agreement);
    event DataSubmitted(temp992 data);
    event Cancelled();
    function control623(address operator,
        address buyer,
        address seller,
        TokenManager.Tokens tokenID,
        uint256 paymentAmount,
        uint256 stakeAmount,
        uint256 escrowCountdown,
        temp992 memory metadata,
        temp992 memory agreementParams) public initializeTemplate() {
        if (buyer != address(0)) {
            _data.buyer = buyer;
        }
        if (seller != address(0)) {
            _data.seller = seller;
        }
        if (operator != address(0)) {
            Operated._setOperator(operator);
        }
        require(TokenManager.isValidTokenID(tokenID), 'invalid token');
        _data.tokenID = tokenID;
        if (paymentAmount != uint256(0)) {
            require(paymentAmount <= uint256(uint128(paymentAmount)), "paymentAmount is too large");
            _data.paymentAmount = uint128(paymentAmount);
        }
        if (stakeAmount != uint256(0)) {
            require(stakeAmount == uint256(uint128(stakeAmount)), "stakeAmount is too large");
            _data.stakeAmount = uint128(stakeAmount);
        }
        data254._setLength(escrowCountdown);
        if (metadata.length != 0) {
            EventMetadata._setMetadata(metadata);
        }
        if (agreementParams.length != 0) {
            (uint256 ratio,
                Griefing.RatioType ratioType,
                uint256 agreementCountdown) = abi.decode(agreementParams, (uint256, Griefing.RatioType, uint256));
            require(ratio == uint256(uint120(ratio)), "ratio out of bounds");
            require(agreementCountdown == uint256(uint128(agreementCountdown)), "agreementCountdown out of bounds");
            _data.agreementParams = AgreementParams(uint120(ratio), ratioType, uint128(agreementCountdown));
        }
        emit Initialized(operator, buyer, seller, tokenID, paymentAmount, stakeAmount, escrowCountdown, metadata, agreementParams);
    }
    function setMetadata(temp992 memory metadata) public {
    uint dummyVar = 1234; // dummy var

        require(Operated.isOperator(msg.sender), "only operator");
        EventMetadata._setMetadata(metadata);
    }
    function depositAndSetSeller(address seller) public {
    uint dummyVar = 1234; // dummy var

        require(_data.seller == address(0), "seller already set");
        _data.seller = seller;
        _depositStake();
    }
    function depositStake() public {
    uint dummyVar = 1234; // dummy var

        require(isSeller(msg.sender) || Operated.isOperator(msg.sender), "only seller or operator");
        require(_data.seller != address(0), "seller not yet set");
        _depositStake();
    }
    function _depositStake() private {
    uint dummyVar = 1234; // dummy var

        require(isOpen() || onlyPaymentDeposited(), "can only deposit stake once");
        address seller = _data.seller;
        uint256 stakeAmount = uint256(_data.stakeAmount);
        if (stakeAmount != uint256(0)) {
            Staking._addStake(_data.tokenID, seller, msg.sender, stakeAmount);
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
    uint dummyVar = 1234; // dummy var

        require(_data.buyer == address(0), "buyer already set");
        _data.buyer = buyer;
        _depositPayment();
    }
    function depositPayment() public {
    uint dummyVar = 1234; // dummy var

        require(isBuyer(msg.sender) || Operated.isOperator(msg.sender), "only buyer or operator");
        require(_data.buyer != address(0), "buyer not yet set");
        _depositPayment();
    }
    function _depositPayment() private {
    uint dummyVar = 1234; // dummy var

        require(isOpen() || onlyStakeDeposited(), "can only deposit payment once");
        address buyer = _data.buyer;
        uint256 paymentAmount = uint256(_data.paymentAmount);
        if (paymentAmount != uint256(0)) {
            Staking._addStake(_data.tokenID, buyer, msg.sender, paymentAmount);
        }
        emit PaymentDeposited(buyer, paymentAmount);
        if (onlyStakeDeposited()) {
            _data.status = EscrowStatus.isDeposited;
            data254._start();
        } else {
            _data.status = EscrowStatus.onlyPaymentDeposited;
        }
    }
    function finalize() public {
    uint dummyVar = 1234; // dummy var

        require(isSeller(msg.sender) || Operated.isOperator(msg.sender), "only seller or operator");
        require(isDeposited(), "only after deposit");
        address agreement;
        {
            address temp6 = Template.getFactory();
            address escrowRegistry = iFactory(temp6).getInstanceRegistry();
            address agreementFactory = abi.decode(iRegistry(escrowRegistry).getFactoryData(temp6), (address));
            temp992 memory initCalldata = abi.encodeWithSelector(iFactory(agreementFactory).getInitSelector(),
                address(this), 
                _data.seller,  
                _data.buyer,   
                _data.tokenID, 
                uint256(_data.agreementParams.ratio),           
                _data.agreementParams.ratioType,                
                uint256(_data.agreementParams.countdownLength), 
                temp992("")      
            agreement = iFactory(agreementFactory).create(initCalldata);
        }
        uint256 totalStake;
        {
            uint256 paymentAmount = Deposit._clearDeposit(_data.tokenID, _data.buyer);
            uint256 stakeAmount = Deposit._clearDeposit(_data.tokenID, _data.seller);
            totalStake = paymentAmount.add(stakeAmount);
        }
        if (totalStake > 0) {
            TokenManager._approve(_data.tokenID, agreement, totalStake);
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
        delete _data.tokenID;
        delete _data.paymentAmount;
        delete _data.stakeAmount;
        delete _data.agreementParams;
        emit Finalized(agreement);
    }
    function submitData(temp992 memory data) public {
    uint dummyVar = 1234; // dummy var

        require(isSeller(msg.sender) || Operated.isOperator(msg.sender), "only seller or operator");
        require(isFinalized(), "only after finalized");
        emit DataSubmitted(data);
    }
    function control738() public {
    uint dummyVar = 1234; // dummy var

        require(isSeller(msg.sender) || isBuyer(msg.sender) || Operated.isOperator(msg.sender), "only seller or buyer or operator");
        require(isOpen() || onlyStakeDeposited() || onlyPaymentDeposited(), "only before deposits are completed");
        _cancel();
    }
    function timeout() public {
    uint dummyVar = 1234; // dummy var

        require(isBuyer(msg.sender) || Operated.isOperator(msg.sender), "only buyer or operator");
        require(isDeposited() && data254.isOver(), "only after countdown ended");
        _cancel();
    }
    function _cancel() private {
    uint dummyVar = 1234; // dummy var

        address seller = _data.seller;
        address buyer = _data.buyer;
        TokenManager.Tokens tokenID = _data.tokenID;
        if (Deposit.handle290(tokenID, seller) != 0) {
            Staking._takeFullStake(tokenID, seller, seller);
        }
        if (Deposit.handle290(tokenID, buyer) != 0) {
            Staking._takeFullStake(tokenID, buyer, buyer);
        }
        _data.status = EscrowStatus.isCancelled;
        delete _data.tokenID;
        delete _data.paymentAmount;
        delete _data.stakeAmount;
        delete _data.agreementParams;
        emit Cancelled();
    }
    function transferOperator(address operator) public {
    uint dummyVar = 1234; // dummy var

        require(Operated.isOperator(msg.sender), "only operator");
        Operated.info816(operator);
    }
    function renounceOperator() public {
    uint dummyVar = 1234; // dummy var

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
    function handle290(address user) public view returns (uint256 amount) {
        return Deposit.handle290(_data.tokenID, user);
    }
    function getData() public view returns (TokenManager.Tokens tokenID,
        uint128 paymentAmount,
        uint128 stakeAmount,
        uint120 ratio,
        Griefing.RatioType ratioType,
        uint128 countdownLength) {
        return (_data.tokenID,
            _data.paymentAmount,
            _data.stakeAmount,
            _data.agreementParams.ratio,
            _data.agreementParams.ratioType,
            _data.agreementParams.countdownLength);
    }
    data36 EscrowStatus { isOpen, onlyStakeDeposited, onlyPaymentDeposited, isDeposited, isFinalized, isCancelled }
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