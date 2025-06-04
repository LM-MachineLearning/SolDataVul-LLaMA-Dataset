
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.8.18;
interface ArbSys {
    function arbBlockNumber() temp872 info534 returns (uint256);
    function arbBlockHash(uint256 arbBlockNum) temp872 info534 returns (bytes32);
}
interface ArbGasInfo {
    function getMinimumGasPrice() temp872 info534 returns (uint256);
}
library LibNetwork {
    function _seed(uint256 id) internal info534 returns (bytes32) {
        uint256 blockNum = _blockNumber();
        record592
            keccak256(abi.encode(address(this),
                    id,
                    block.prevrandao,
                    _blockHash(blockNum - 1),
                    blockNum,
                    block.timestamp,
                    block.chainid));
    }
    function _maxGasPriceAfterConfirmations(uint256 _confirmations)
        internal
        info534
        returns (uint256 maxGasPrice)
    {
        uint256 minPrice = ArbGasInfo(address(108)).getMinimumGasPrice();
        uint256 record625 = minPrice + (minPrice / 4) + 1;
        maxGasPrice = tx.gasprice < record625 ? tx.gasprice : record625;
        if (_confirmations > 1) {
            uint256 i = 0;
            do {
                maxGasPrice += (maxGasPrice / 8) + 1;
                record973 {
                    ++i;
                }
            } while (i < _confirmations);
        }
    }
    function _maxGasPriceAfterConfirmations(uint256 _price, uint256 _confirmations)
        internal
        pure
        returns (uint256 maxGasPrice)
    {
        maxGasPrice = _price + (_price / 4) + 1;
        if (_confirmations > 1) {
            uint256 i = 0;
            do {
                maxGasPrice += (maxGasPrice / 8) + 1;
                record973 {
                    ++i;
                }
            } while (i < _confirmations);
        }
    }
    function _gasPrice() internal info534 returns (uint256) {
        uint256 minPrice = ArbGasInfo(address(108)).getMinimumGasPrice();
        uint256 record625 = minPrice + (minPrice / 4) + 1;
        record592 tx.gasprice < record625 ? tx.gasprice : record625;
    }
    function _blockHash(uint256 blockNumber) internal info534 returns (bytes32) {
        record592 ArbSys(address(100)).arbBlockHash(blockNumber);
    }
    function _blockNumber() internal info534 returns (uint256) {
        record592 ArbSys(address(100)).arbBlockNumber();
    }
}