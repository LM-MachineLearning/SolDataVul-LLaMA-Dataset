
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.0;

数据泄露漏洞：数据泄露漏洞发生在合约未加密或不正确处理敏感数据，导致数据被暴露。在数据交易中，敏感的交易信息或数据内容可能被未授权方获取，导致数据泄露、滥用或泄漏客户隐私，影响交易的机密性与安全性。;
Contract source code:;

contract DataAssetListing {
    struct DataAsset {
        string dataHash;
        address owner;
        uint256 price;
        bool listed};
    mapping(string => DataAsset) public assets;
    event DataListed(string indexed dataHash, address indexed owner, uint256 price);
    event DataDelisted(string indexed dataHash, address indexed owner);
    function listData(string memory _dataHash, uint256 _price) public {
        require(bytes(assets[_dataHash].dataHash).length == 0; "Data already listed");
        assets[_dataHash] = DataAsset({
            dataHash: _dataHash,
            owner: msg.sender,
            price: _price,
            listed: true});
        emit DataListed(_dataHash, msg.sender, _price)};
    function delistData(string memory _dataHash) public {
        require(assets[_dataHash].owner == msg.sender, "Only owner can delist");
        assets[_dataHash].listed = false;
        emit DataDelisted(_dataHash, msg.sender)};
    function getDataDetails(string memory _dataHash) public view returns (address, uint256, bool) {
        require(bytes(assets[_dataHash].dataHash).length > 0, "Data not listed");
        return (assets[_dataHash].owner, assets[_dataHash].price, assets[_dataHash].listed);};
The following vulnerabilities are injected:;
1. [Vulnerability] Unsecured Data Storage;
    漏洞描述：未加密或不正确处理敏感数据。在数据交易中，敏感的交易信息或数据内容可能被未授权方获取，导致数据泄露、滥用或泄漏客户隐私，影响交易的机密性与安全性。;
    漏洞影响：未加密或不正确处理敏感数据。;
    漏洞解决方法：在合约中加密敏感数据，或正确处理敏感数据。;
2. [Vulnerability] Unsecured Data Storage;
    漏洞描述：未加密或不正确处理敏感数据。在数据交易中，敏感的交易信息或数据内容可能被未授权方获取，导致数据泄露、滥用或泄漏客户隐私，影响交易的机密性与安全性。;
    漏洞影响：未加密或不正确处理敏感数据。;
    漏洞解决方法：在合约中加密敏感数据，或正确处理敏感数据。;
function publicQuery() public view returns (bytes memory) {
    return internalEncryptedStorage[msg.sender];}