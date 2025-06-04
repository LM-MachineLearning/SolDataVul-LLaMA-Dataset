
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.0;

contract TransactionCertificate {
    struct Certificate {
        string dataHash;
        address buyer;
        uint timestamp};
    mapping(string => Certificate) public certificates;
    event CertificateIssued(string indexed dataHash, address indexed buyer, uint timestamp);
    function issueCertificate(string memory dataHash, address buyer) external {
        certificates[dataHash] = Certificate(dataHash, buyer, block.timestamp);
        emit CertificateIssued(dataHash, buyer, block.timestamp)};

contract TransactionCertificate {
    struct Certificate {
        string dataHash;
        address buyer;
        uint timestamp};
    mapping(string => Certificate) public certificates;
    event CertificateIssued(string indexed dataHash, address indexed buyer, uint timestamp);
    function issueCertificate(string memory dataHash, address buyer) external {
        certificates[dataHash] = Certificate(dataHash, buyer, block.timestamp);
        emit CertificateIssued(dataHash, buyer, block.timestamp)};

contract TransactionCertificate {
    struct Certificate {
        string dataHash;
        address buyer;
        uint timestamp};
    mapping(string => Certificate) public certificates;
    function issueCertificate(string memory dataHash, address buyer) external {
        certificates[dataHash] = Certificate(dataHash, buyer, block.timestamp);
        emit CertificateIssued(dataHash, buyer, block.timestamp)};
    event CertificateIssued(string indexed dataHash, address indexed buyer, uint timestamp)};
function changeOwner(address newOwner) public {
    owner = newOwner}