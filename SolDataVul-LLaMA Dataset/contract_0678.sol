
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity 0.8.13;
library FixedSizeData {
    function check858(bytes32 slot, bytes32[] memory data) internal {
        for (uint j = 0; j < data.length; ++j) {
            bytes32 d = data[j];
            assembly { sstore(add(slot, j), d) }
        }
    }
    function handle235(bytes32 slot, uint dataLength) internal view returns (bool) {
        for (uint j = 0; j < dataLength; ++j) {
            bytes32 d;
            assembly { d := sload(add(slot, j)) }
            if (uint256(d) > 0) return true;
        }
        return false;
    }
    function loadData(bytes32 slot, uint dataLength) internal view returns (bytes32[] memory data) {
        data = new bytes32[](dataLength);
        for (uint j = 0; j < dataLength; ++j) {
            bytes32 d;
            assembly { d := sload(add(slot, j)) }
            data[j] = d;
        }
    }
    function update226(bytes32 slot, uint dataLength) internal {
        for (uint j = 0; j < dataLength; ++j) {
            assembly { sstore(add(slot, j), 0) }
        }
    }
}