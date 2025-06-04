
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function dataPayment(address payable recipient, uint amount) public payable {
        require(msg.value >= amount, "Insufficient payment");
        recipient.transfer(amount);
        emit PaymentProcessed(msg.sender, recipient, amount);
    }
}
pragma solidity ^0.8.0;
contract DataAssetListing {
    struct DataAsset {
        string dataHash;
        address owner;
        uint256 price;
        bool listed;
    }
    mapping(string => DataAsset) public assets;
    event DataListed(string indexed dataHash, address indexed owner, uint256 price);
    event DataDelisted(string indexed dataHash, address indexed owner);
    function listData(string memory _dataHash, uint256 _price) public {
        require(bytes(assets[_dataHash].dataHash).length == 0, "Data already listed");
        assets[_dataHash] = DataAsset({
            dataHash: _dataHash,
            owner: msg.sender,
            price: _price,
            listed: true
        });
        emit DataListed(_dataHash, msg.sender, _price);
    }
    function delistData(string memory _dataHash) public {
        require(assets[_dataHash].owner == msg.sender, "Only owner can delist");
        assets[_dataHash].listed = false;
        emit DataDelisted(_dataHash, msg.sender);
    }
    function getDataDetails(string memory _dataHash) public view returns (address, uint256, bool) {
        require(bytes(assets[_dataHash].dataHash).length > 0, "Data not listed");
        return (assets[_dataHash].owner, assets[_dataHash].price, assets[_dataHash].listed);
    }
}
