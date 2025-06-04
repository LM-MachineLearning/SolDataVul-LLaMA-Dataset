
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function dataPayment(address payable recipient, uint amount) public payable {
        require(msg.value >= amount, "Insufficient payment");
        recipient.transfer(amount);
        emit PaymentProcessed(msg.sender, recipient, amount);
    }
}
library ScheduledCallLib {
    struct CallDatabase {
        Relay unauthorizedRelay;
        Relay authorizedRelay;
        bytes32 lastCallKey;
        bytes lastData;
        uint lastDataLength;
        bytes32 lastDataHash;
        ResourcePoolLib.Pool callerPool;
        GroveLib.Index callIndex;
        AccountingLib.Bank gasBank;
        mapping (bytes32 => Call) calls;
        mapping (bytes32 => bytes) data_registry;
        mapping (bytes32 => bool) accountAuthorizations;
    }
    struct Call {
            address contractAddress;
            address scheduledBy;
            uint calledAtBlock;
            uint targetBlock;
            uint8 gracePeriod;
            uint nonce;
            uint baseGasPrice;
            uint gasPrice;
            uint gasUsed;
            uint gasCost;
            uint payout;
            uint fee;
            address executedBy;
            bytes4 abiSignature;
            bool isCancelled;
            bool wasCalled;
            bool wasSuccessful;
            bytes32 dataHash;
    }
    address constant owner = 0xd3cda913deb6f67967b99d67acdfa1712c293601;
    function getCallContractAddress(CallDatabase storage self, bytes32 callKey) constant returns (address) {
            return self.calls[callKey].contractAddress;
    }
    function getCallScheduledBy(CallDatabase storage self, bytes32 callKey) constant returns (address) {
            return self.calls[callKey].scheduledBy;
    }
    function getCallCalledAtBlock(CallDatabase storage self, bytes32 callKey) constant returns (uint) {
            return self.calls[callKey].calledAtBlock;
    }
    function getCallGracePeriod(CallDatabase storage self, bytes32 callKey) constant returns (uint) {
            return self.calls[callKey].gracePeriod;
    }
    function getCallTargetBlock(CallDatabase storage self, bytes32 callKey) constant returns (uint) {
            return self.calls[callKey].targetBlock;
    }
    function getCallBaseGasPrice(CallDatabase storage self, bytes32 callKey) constant returns (uint) {
            return self.calls[callKey].baseGasPrice;
    }
    function getCallGasPrice(CallDatabase storage self, bytes32 callKey) constant returns (uint) {
            return self.calls[callKey].gasPrice;
    }
    function getCallGasUsed(CallDatabase storage self, bytes32 callKey) constant returns (uint) {
            return self.calls[callKey].gasUsed;
    }
    function getCallABISignature(CallDatabase storage self, bytes32 callKey) constant returns (bytes4) {
            return self.calls[callKey].abiSignature;
    }
    function checkIfCalled(CallDatabase storage self, bytes32 callKey) constant returns (bool) {
            return self.calls[callKey].wasCalled;
    }
    function checkIfSuccess(CallDatabase storage self, bytes32 callKey) constant returns (bool) {
            return self.calls[callKey].wasSuccessful;
    }
    function checkIfCancelled(CallDatabase storage self, bytes32 callKey) constant returns (bool) {
            return self.calls[callKey].isCancelled;
    }
    function getCallDataHash(CallDatabase storage self, bytes32 callKey) constant returns (bytes32) {
            return self.calls[callKey].dataHash;
    }
    function getCallPayout(CallDatabase storage self, bytes32 callKey) constant returns (uint) {
            return self.calls[callKey].payout;
    }
    function getCallFee(CallDatabase storage self, bytes32 callKey) constant returns (uint) {
            return self.calls[callKey].fee;
    }
    function addAuthorization(CallDatabase storage self, address schedulerAddress, address contractAddress) public {
            self.accountAuthorizations[sha3(schedulerAddress, contractAddress)] = true;
    }
    function removeAuthorization(CallDatabase storage self, address schedulerAddress, address contractAddress) public {
            self.accountAuthorizations[sha3(schedulerAddress, contractAddress)] = false;
    }
    function checkAuthorization(CallDatabase storage self, address schedulerAddress, address contractAddress) constant returns (bool) {
            return self.accountAuthorizations[sha3(schedulerAddress, contractAddress)];
    }
    function getCallData(CallDatabase storage self, bytes32 callKey) constant returns (bytes) {
            return self.data_registry[self.calls[callKey].dataHash];
    }
    uint constant CALL_WINDOW_SIZE = 16;
    function getGenerationIdForCall(CallDatabase storage self, bytes32 callKey) constant returns (uint) {
            Call call = self.calls[callKey];
            return ResourcePoolLib.getGenerationForWindow(self.callerPool, call.targetBlock, call.targetBlock + call.gracePeriod);
    }
    function getDesignatedCaller(CallDatabase storage self, bytes32 callKey, uint blockNumber) constant returns (address) {
            Call call = self.calls[callKey];
            if (blockNumber < call.targetBlock || blockNumber > call.targetBlock + call.gracePeriod) {
                    return 0x0;
            }
            uint numWindows = call.gracePeriod / CALL_WINDOW_SIZE;
            uint blockWindow = (blockNumber - call.targetBlock) / CALL_WINDOW_SIZE;
            if (blockWindow + 2 > numWindows) {
                    return 0x0;
            }
            uint generationId = ResourcePoolLib.getGenerationForWindow(self.callerPool, call.targetBlock, call.targetBlock + call.gracePeriod);
            if (generationId == 0) {
                    return 0x0;
            }
            var generation = self.callerPool.generations[generationId];
            uint offset = uint(callKey) % generation.members.length;
            return generation.members[(offset + blockWindow) % generation.members.length];
    }
    event _AwardedMissedBlockBonus(address indexed fromCaller, address indexed toCaller, uint indexed generationId, bytes32 callKey, uint blockNumber, uint bonusAmount);
    function AwardedMissedBlockBonus(address fromCaller, address toCaller, uint generationId, bytes32 callKey, uint blockNumber, uint bonusAmount) public {
        _AwardedMissedBlockBonus(fromCaller, toCaller, generationId, callKey, blockNumber, bonusAmount);
    }
    function getMinimumBond() constant returns (uint) {
            return tx.gasprice * block.gaslimit;
    }
    function doBondBonusTransfer(CallDatabase storage self, address fromCaller, address toCaller) internal returns (uint) {
            uint bonusAmount = getMinimumBond();
            uint bondBalance = self.callerPool.bonds[fromCaller];
            if (bonusAmount > bondBalance) {
                    bonusAmount = bondBalance;
            }
            ResourcePoolLib.deductFromBond(self.callerPool, fromCaller, bonusAmount);
            ResourcePoolLib.addToBond(self.callerPool, toCaller, bonusAmount);
            return bonusAmount;
    }
    function awardMissedBlockBonus(CallDatabase storage self, address toCaller, bytes32 callKey) public {
            var call = self.calls[callKey];
            var generation = self.callerPool.generations[ResourcePoolLib.getGenerationForWindow(self.callerPool, call.targetBlock, call.targetBlock + call.gracePeriod)];
            uint i;
            uint bonusAmount;
            address fromCaller;
            uint numWindows = call.gracePeriod / CALL_WINDOW_SIZE;
            uint blockWindow = (block.number - call.targetBlock) / CALL_WINDOW_SIZE;
            if (blockWindow + 2 > numWindows) {
                    address firstCaller = getDesignatedCaller(self, callKey, call.targetBlock);
                    for (i = call.targetBlock; i <= call.targetBlock + call.gracePeriod; i += CALL_WINDOW_SIZE) {
                            fromCaller = getDesignatedCaller(self, callKey, i);
                            if (fromCaller == firstCaller && i != call.targetBlock) {
                                    break;
                            }
                            if (fromCaller == toCaller) {
                                    continue;
                            }
                            bonusAmount = doBondBonusTransfer(self, fromCaller, toCaller);
                            AwardedMissedBlockBonus(fromCaller, toCaller, generation.id, callKey, block.number, bonusAmount);
                    }
                    return;
            }
            if (generation.members.length < 2) {
                    return;
            }
            for (i = 0; i < generation.members.length; i++) {
                    if (generation.members[i] == toCaller) {
                            fromCaller = generation.members[(i + generation.members.length - 1) % generation.members.length];
                            bonusAmount = doBondBonusTransfer(self, fromCaller, toCaller);
                            AwardedMissedBlockBonus(fromCaller, toCaller, generation.id, callKey, block.number, bonusAmount);
                            if (ResourcePoolLib.getNextGenerationId(self.callerPool) == 0) {
                                    ResourcePoolLib.createNextGeneration(self.callerPool);
                            }
                            ResourcePoolLib.removeFromGeneration(self.callerPool, ResourcePoolLib.getNextGenerationId(self.callerPool), fromCaller);
                            return;
                    }
            }
    }
    event _DataRegistered(bytes32 indexed dataHash);
    function DataRegistered(bytes32 dataHash) constant {
        _DataRegistered(dataHash);
    }
    function registerData(CallDatabase storage self, bytes data) public {
            self.lastData.length = data.length - 4;
            if (data.length > 4) {
                    for (uint i = 0; i < self.lastData.length; i++) {
                            self.lastData[i] = data[i + 4];
                    }
            }
            self.data_registry[sha3(self.lastData)] = self.lastData;
            self.lastDataHash = sha3(self.lastData);
            self.lastDataLength = self.lastData.length;
    }
    uint constant EXTRA_CALL_GAS = 153321;
    uint constant CALL_OVERHEAD = 120104;
    event _CallExecuted(address indexed executedBy, bytes32 indexed callKey);
    function CallExecuted(address executedBy, bytes32 callKey) public {
        _CallExecuted(executedBy, callKey);
    }
    event _CallAborted(address indexed executedBy, bytes32 indexed callKey, bytes18 reason);
    function CallAborted(address executedBy, bytes32 callKey, bytes18 reason) public {
        _CallAborted(executedBy, callKey, reason);
    }
    function doCall(CallDatabase storage self, bytes32 callKey, address msgSender) public {
            uint gasBefore = msg.gas;
            Call storage call = self.calls[callKey];
            if (call.wasCalled) {
                    _CallAborted(msg.sender, callKey, "ALREADY CALLED");
                    return;
            }
            if (call.isCancelled) {
                    _CallAborted(msg.sender, callKey, "CANCELLED");
                    return;
            }
            if (call.contractAddress == 0x0) {
                    _CallAborted(msg.sender, callKey, "UNKNOWN");
                    return;
            }
            if (block.number < call.targetBlock) {
                    _CallAborted(msg.sender, callKey, "TOO EARLY");
                    return;
            }
            if (block.number > call.targetBlock + call.gracePeriod) {
                    _CallAborted(msg.sender, callKey, "TOO LATE");
                    return;
            }
            uint heldBalance = getCallMaxCost(self, callKey);
            if (self.gasBank.accountBalances[call.scheduledBy] < heldBalance) {
                    call.wasCalled = true;
                    _CallAborted(msg.sender, callKey, "INSUFFICIENT_FUNDS");
                    return;
            }
            if (self.callerPool.generations[ResourcePoolLib.getCurrentGenerationId(self.callerPool)].members.length > 0) {
                    address designatedCaller = getDesignatedCaller(self, callKey, block.number);
                    if (designatedCaller != 0x0 && designatedCaller != msgSender) {
                            _CallAborted(msg.sender, callKey, "WRONG_CALLER");
                            return;
                    }
                    uint blockWindow = (block.number - call.targetBlock) / CALL_WINDOW_SIZE;
                    if (blockWindow > 0) {
                            awardMissedBlockBonus(self, msgSender, callKey);
                    }
            }
            call.gasPrice = tx.gasprice;
            call.executedBy = msgSender;
            call.calledAtBlock = block.number;
            var data = self.data_registry[call.dataHash];
            AccountingLib.withdraw(self.gasBank, call.scheduledBy, heldBalance);
            if (checkAuthorization(self, call.scheduledBy, call.contractAddress)) {
                    call.wasSuccessful = self.authorizedRelay.relayCall.gas(msg.gas - CALL_OVERHEAD)(call.contractAddress, call.abiSignature, data);
            }
            else {
                    call.wasSuccessful = self.unauthorizedRelay.relayCall.gas(msg.gas - CALL_OVERHEAD)(call.contractAddress, call.abiSignature, data);
            }
            AccountingLib.deposit(self.gasBank, call.scheduledBy, heldBalance);
            call.wasCalled = true;
            uint feeScalar = getCallFeeScalar(call.baseGasPrice, call.gasPrice);
            call.gasUsed = (gasBefore - msg.gas + EXTRA_CALL_GAS);
            call.gasCost = call.gasUsed * call.gasPrice;
            call.payout = call.gasCost * feeScalar * 101 / 10000;
            call.fee = call.gasCost * feeScalar / 10000;
            AccountingLib.deductFunds(self.gasBank, call.scheduledBy, call.payout + call.fee);
            AccountingLib.addFunds(self.gasBank, msgSender, call.payout);
            AccountingLib.addFunds(self.gasBank, owner, call.fee);
    }
    function getCallMaxCost(CallDatabase storage self, bytes32 callKey) constant returns (uint) {
            var call = self.calls[callKey];
            uint gasCost = tx.gasprice * block.gaslimit;
            uint feeScalar = getCallFeeScalar(call.baseGasPrice, tx.gasprice);
            return gasCost * feeScalar * 102 / 10000;
    }
    function getCallFeeScalar(uint baseGasPrice, uint gasPrice) constant returns (uint) {
            if (gasPrice > baseGasPrice) {
                    return 100 * baseGasPrice / gasPrice;
            }
            else {
                    return 200 - 100 * baseGasPrice / (2 * baseGasPrice - gasPrice);
            }
    }
    bytes32 constant emptyDataHash = 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470;
    function computeCallKey(address scheduledBy, address contractAddress, bytes4 abiSignature, bytes32 dataHash, uint targetBlock, uint8 gracePeriod, uint nonce) constant returns (bytes32) {
            return sha3(scheduledBy, contractAddress, abiSignature, dataHash, targetBlock, gracePeriod, nonce);
    }
    uint constant MAX_BLOCKS_IN_FUTURE = 40;
    event _CallScheduled(bytes32 indexed callKey);
    function CallScheduled(bytes32 callKey) public {
        _CallScheduled(callKey);
    }
    event _CallRejected(bytes32 indexed callKey, bytes15 reason);
    function CallRejected(bytes32 callKey, bytes15 reason) public {
        _CallRejected(callKey, reason);
    }
    function getCallWindowSize() public returns (uint) {
        return CALL_WINDOW_SIZE;
    }
    function getMinimumGracePeriod() public returns (uint) {
        return 4 * CALL_WINDOW_SIZE;
    }
    function scheduleCall(CallDatabase storage self, address schedulerAddress, address contractAddress, bytes4 abiSignature, bytes32 dataHash, uint targetBlock, uint8 gracePeriod, uint nonce) public returns (bytes15) {
            bytes32 callKey = computeCallKey(schedulerAddress, contractAddress, abiSignature, dataHash, targetBlock, gracePeriod, nonce);
            if (dataHash != emptyDataHash && self.data_registry[dataHash].length == 0) {
                    return "NO_DATA";
            }
            if (targetBlock < block.number + MAX_BLOCKS_IN_FUTURE) {
                    return "TOO_SOON";
            }
            Call storage call = self.calls[callKey];
            if (call.contractAddress != 0x0) {
                    return "DUPLICATE";
            }
            if (gracePeriod < getMinimumGracePeriod()) {
                    return "GRACE_TOO_SHORT";
            }
            self.lastCallKey = callKey;
            call.contractAddress = contractAddress;
            call.scheduledBy = schedulerAddress;
            call.nonce = nonce;
            call.abiSignature = abiSignature;
            call.dataHash = dataHash;
            call.targetBlock = targetBlock;
            call.gracePeriod = gracePeriod;
            call.baseGasPrice = tx.gasprice;
            GroveLib.insert(self.callIndex, callKey, int(call.targetBlock));
            return 0x0;
    }
    event _CallCancelled(bytes32 indexed callKey);
    function CallCancelled(bytes32 callKey) public {
        _CallCancelled(callKey);
    }
    uint constant MIN_CANCEL_WINDOW = 8;
    function cancelCall(CallDatabase storage self, bytes32 callKey, address msgSender) public returns (bool) {
            Call storage call = self.calls[callKey];
            if (call.scheduledBy != msgSender) {
                    return false;
            }
            if (call.wasCalled) {
                    return false;
            }
            if (call.targetBlock - MIN_CANCEL_WINDOW <= block.number) {
                    return false;
            }
            call.isCancelled = true;
            return true;
    }
}
