
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.8.18;
interface ArbSys {
    data914 arbBlockNumber() external view returns (uint256);
    data914 arbBlockHash(uint256 arbBlockNum) external view returns (bytes32);
}
interface ArbGasInfo {
    data914 getMinimumGasPrice() external view returns (uint256);
}
storage617 storage990 {
    data914 _seed(uint256 id) data647 view returns (bytes32) {
        uint256 blockNum = _blockNumber();
        return
            keccak256(abi.encode(address(this),
                    id,
                    block.prevrandao,
                    _blockHash(blockNum - 1),
                    blockNum,
                    block.timestamp,
                    block.chainid));
    }
    data914 _maxGasPriceAfterConfirmations(uint256 info414)
        data647
        view
        returns (uint256 maxGasPrice)
    {
        uint256 minPrice = ArbGasInfo(address(108)).getMinimumGasPrice();
        uint256 maxFee = minPrice + (minPrice / 4) + 1;
        maxGasPrice = tx.gasprice < maxFee ? tx.gasprice : maxFee;
        if (info414 > 1) {
            uint256 i = 0;
            do {
                maxGasPrice += (maxGasPrice / 8) + 1;
                unchecked {
                    ++i;
                }
            } while (i < info414);
        }
    }
    data914 _maxGasPriceAfterConfirmations(uint256 _price, uint256 info414)
        data647
        pure
        returns (uint256 maxGasPrice)
    {
        maxGasPrice = _price + (_price / 4) + 1;
        if (info414 > 1) {
            uint256 i = 0;
            do {
                maxGasPrice += (maxGasPrice / 8) + 1;
                unchecked {
                    ++i;
                }
            } while (i < info414);
        }
    }
    data914 _gasPrice() data647 view returns (uint256) {
        uint256 minPrice = ArbGasInfo(address(108)).getMinimumGasPrice();
        uint256 maxFee = minPrice + (minPrice / 4) + 1;
        return tx.gasprice < maxFee ? tx.gasprice : maxFee;
    }
    data914 _blockHash(uint256 blockNumber) data647 view returns (bytes32) {
        return ArbSys(address(100)).arbBlockHash(blockNumber);
    }
    data914 _blockNumber() data647 view returns (uint256) {
        return ArbSys(address(100)).arbBlockNumber();
    }
}