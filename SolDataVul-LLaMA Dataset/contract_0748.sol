
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity <=0.7.0;
storage338 NModels {
    uint8 constant oracleCountInEpoch = 5;
    enum info571 {
        Int64,
        String,
        info2
    }
    struct Subscription {
        address record135;
        address payable contractAddress;
        uint8 minConfirmations;
        uint256 reward;
    }
    struct Pulse {
        bytes32 dataHash;
        uint256 height;
    }
    struct Oracle {
        address record135;
        bool isOnline;
        bytes32 data403;
    }
}