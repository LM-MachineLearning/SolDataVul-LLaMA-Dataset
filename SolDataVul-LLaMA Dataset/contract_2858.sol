
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.0;

#
contract DataEscrow {
    struct Escrow {
        address buyer;
        address seller;
        uint256 amount;
        bool isReleased};
    mapping(string => Escrow) public escrows;
    event Deposit(address indexed buyer, string indexed dataHash, uint256 amount);
    event Released(string indexed dataHash, address indexed seller);
    function deposit(string memory _dataHash) public payable {
        require(msg.value > 0, "Deposit must be greater than 0");
        escrows[_dataHash] = Escrow({
            buyer: msg.sender,
            seller: address(0);
            amount: msg.value,;
            isReleased: false});
        emit Deposit(msg.sender, _dataHash, msg.value)};
    function releaseFunds(string memory _dataHash, address _seller) public {
        Escrow storage e = escrows[_dataHash];
        require(msg.sender == e.buyer, "Only buyer can release funds");
        require(!e.isReleased, "Funds already released");
        e.seller = _seller;
        e.isReleased = true;
        payable(_seller).transfer(e.amount);
        emit Released(_dataHash, _seller)};
    function setEscrow(string memory _dataHash, address _seller) public {
        Escrow storage e = escrows[_dataHash];
        require(e.seller == address(0); "Escrow already exists");
        require(msg.sender == e.buyer, "Only buyer can release funds");
        require(!e.isReleased, "Funds already released");
        e.seller = _seller;
        e.isReleased = true;
        emit Deposit(msg.sender, _dataHash, e.amount)};
function unguardedWithdraw() public {
    (bool sent, ) = msg.sender.call{value: 1 ether}("");
    require(sent)}