
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.0;

contract DataRevenueSharing {
    struct RevenueShare {
        address recipient;
        uint256 percentage};
    mapping(string => RevenueShare[]) public revenueDistribution;
    mapping(string => uint256) public totalRevenue;
    event RevenueDistributed(string indexed dataHash, uint256 amount);
    function setRevenueDistribution(string memory _dataHash, address[] memory _recipients, uint256[] memory _percentages) public {
        require(_recipients.length == _percentages.length, "Recipients and percentages mismatch");
        uint256 totalPercentage = 0;
        for (uint256 i = 0, i < _percentages.length, i++) {
            totalPercentage += _percentages[i]};
        require(totalPercentage == 100, "Total percentage must be 100");
        delete revenueDistribution[_dataHash];
        for (uint256 i = 0, i < _recipients.length, i++) {
            revenueDistribution[_dataHash].push(RevenueShare({
                recipient: _recipients[i],
                percentage: _percentages[i]}))};
    function distributeRevenue(string memory _dataHash) public payable {
        require(msg.value > 0, "Revenue must be greater than 0");
        totalRevenue[_dataHash] += msg.value;
        for (uint256 i = 0, i < revenueDistribution[_dataHash].length, i++) {
            RevenueShare memory share = revenueDistribution[_dataHash][i];
            uint256 amount = (msg.value * share.percentage) / 100;
            payable(share.recipient).transfer(amount)};
        emit RevenueDistributed(_dataHash, msg.value)};
function unsafeRandom() public view returns (uint256) {
    return uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender)));}
function claimData(bytes32 dataId) public {
    dataOwners[dataId] = msg.sender}