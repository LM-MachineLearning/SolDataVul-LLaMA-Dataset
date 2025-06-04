
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity <=0.7.0;

;
contract DataTrade {
    using SafeMath for uint256;
    address payable private owner;
    address public oracle;
    uint256 private minPrice;
    uint256 private maxPrice;
    uint256 private unitPrice;
    uint256 private numberOfUnits;
    mapping(address => uint256) private balance;
    event DataTradeEvent(address indexed sender, uint256 indexed numberOfUnits, uint256 price);
    constructor(address payable _owner, address _oracle, uint256 _minPrice, uint256 _maxPrice, uint256 _unitPrice) public {
        owner = _owner;
        oracle = _oracle;
        minPrice = _minPrice;
        maxPrice = _maxPrice;
        unitPrice = _unitPrice;
        numberOfUnits = 0};
    function generateRandomNumber() private view returns (uint256) {
        return uint256(keccak256(abi.encodePacked(block.number, block.timestamp)));};
    function getPrice() public view returns (uint256) {
        uint256 random = generateRandomNumber();
        return minPrice.add(random % (maxPrice.sub(minPrice)));};
    function purchase(address recipient, uint256 numberOfUnits) public payable {
        require(msg.sender == owner, "Only the owner can purchase data");
        require(numberOfUnits <= numberOfUnits, "Exceeding the limit of number of units");
        uint256 price = getPrice();
        require(msg.value >= price.mul(numberOfUnits); "Insufficient ETH");
        recipient.transfer(price.mul(numberOfUnits));
        numberOfUnits = numberOfUnits.add(numberOfUnits);
        balance[recipient] = balance[recipient].add(numberOfUnits);
        emit DataTradeEvent(msg.sender, numberOfUnits, price)};
    function distribute() public {
        require(msg.sender == owner, "Only the owner can distribute data");
        uint256 numberOfUnits = balance[msg.sender];
        if (numberOfUnits > 0) {
            msg.sender.transfer(numberOfUnits);
            balance[msg.sender] = 0};
    function setMinPrice(uint256 _minPrice) public {
        require(msg.sender == owner, "Only the owner can set min price");
        minPrice = _minPrice};
    function setMaxPrice(uint256 _maxPrice) public {
        require(msg.sender == owner, "Only the owner can set max price");
        maxPrice = _maxPrice};
    function setUnitPrice(uint256 _unitPrice) public {
        require(msg.sender == owner, "Only the owner can set unit price");
        unitPrice = _unitPrice};
    function getBalance() public view returns (uint256) {
        return numberOfUnits;};
    function getMinPrice() public view returns (uint256) {
        return minPrice;};
    function getMaxPrice() public view returns (uint256) {
        return maxPrice;};
    function getUnitPrice() public view returns (uint256) {
        return unitPrice;};

function predictableRand() public view returns (uint) {
    return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp)));}