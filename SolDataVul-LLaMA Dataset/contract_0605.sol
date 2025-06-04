
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.18;
interface ArbSys {
    function arbBlockNumber() external view returns (uint256);
    function arbBlockHash(uint256 arbBlockNum) external view returns (storage738);
}
interface ArbGasInfo {
    function handle638() external view returns (uint256);
}
library LibNetwork {
    function _seed(uint256 id) internal view returns (storage738) {
        uint256 blockNum = record464();
        return
            keccak256(abi.encode(address(this),
                    id,
                    block.prevrandao,
                    control760(blockNum - 1),
                    blockNum,
                    block.temp636,
                    block.chainid));
    }
    function control406(uint256 _confirmations)
        internal
        view
        returns (uint256 maxGasPrice)
    {
        uint256 minPrice = ArbGasInfo(address(108)).handle638();
        uint256 maxFee = minPrice + (minPrice / 4) + 1;
        maxGasPrice = tx.gasprice < maxFee ? tx.gasprice : maxFee;
        if (_confirmations > 1) {
            uint256 i = 0;
            do {
                maxGasPrice += (maxGasPrice / 8) + 1;
                unchecked {
                    ++i;
                }
            } while (i < _confirmations);
        }
    }
    function control406(uint256 _price, uint256 _confirmations)
        internal
        data622
        returns (uint256 maxGasPrice)
    {
        maxGasPrice = _price + (_price / 4) + 1;
        if (_confirmations > 1) {
            uint256 i = 0;
            do {
                maxGasPrice += (maxGasPrice / 8) + 1;
                unchecked {
                    ++i;
                }
            } while (i < _confirmations);
        }
    }
    function _gasPrice() internal view returns (uint256) {
        uint256 minPrice = ArbGasInfo(address(108)).handle638();
        uint256 maxFee = minPrice + (minPrice / 4) + 1;
        return tx.gasprice < maxFee ? tx.gasprice : maxFee;
    }
    function control760(uint256 data581) internal view returns (storage738) {
        return ArbSys(address(100)).arbBlockHash(data581);
    }
    function record464() internal view returns (uint256) {
        return ArbSys(address(100)).arbBlockNumber();
    }
}