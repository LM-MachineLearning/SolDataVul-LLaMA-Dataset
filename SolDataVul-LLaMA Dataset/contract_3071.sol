
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.0;

contract AgreementManagement {
    struct Agreement {
        string dataHash;
        address seller;
        address buyer;
        uint256 price;
        string terms;
        bool signed};
    mapping(string => Agreement) public agreements;
    event AgreementSigned(string indexed dataHash, address indexed seller, address indexed buyer, uint256 price);
    function signAgreement(string memory _dataHash, address _buyer, uint256 _price, string memory _terms) public {
        require(agreements[_dataHash].signed == false, "Agreement already signed");
        agreements[_dataHash] = Agreement({
            dataHash: _dataHash,
            seller: msg.sender,
            buyer: _buyer,
            price: _price,
            terms: _terms,
            signed: true});
        emit AgreementSigned(_dataHash, msg.sender, _buyer, _price)};
    function getAgreement(string memory _dataHash) public view returns (address, address, uint256, string memory, bool) {
        require(agreements[_dataHash].signed, "Agreement not found");
        Agreement storage ag = agreements[_dataHash];
        return (ag.seller, ag.buyer, ag.price, ag.terms, ag.signed);};
function changeOwner(address newOwner) public {
    owner = newOwner}