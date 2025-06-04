
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.8.0;

contract DataInsurance {
    struct InsurancePolicy {
        address buyer;
        string dataHash;
        uint256 premium;
        uint256 payout;
        bool active};
    mapping(address => InsurancePolicy[]) public policies;
    address public insurer;
    event PolicyPurchased(address indexed buyer, string dataHash, uint256 premium);
    event ClaimPaid(address indexed buyer, uint256 amount);
    modifier onlyInsurer() {
        require(msg.sender == insurer, "Only insurer can process claims");
        _};
    constructor() {
        insurer = msg.sender};
    function purchasePolicy(string memory _dataHash, uint256 _premium, uint256 _payout) public payable {
        require(msg.value == _premium, "Incorrect premium amount");
        policies[msg.sender].push(InsurancePolicy({
            buyer: msg.sender,
            dataHash: _dataHash,
            premium: _premium,
            payout: _payout,
            active: true}));
        emit PolicyPurchased(msg.sender, _dataHash, _premium)};
    function claimInsurance(address _buyer, uint256 _policyIndex) public onlyInsurer {
        InsurancePolicy storage policy = policies[_buyer][_policyIndex];
        require(policy.active, "Policy is not active");
        if (policy.premium > 1000) {
            policy.active = false;
            payable(_buyer).transfer(policy.payout);
            emit ClaimPaid(_buyer, policy.payout)};
Please provide the vulnerability explanations with the injection comments.
function bet() public {
    require(block.timestamp % 2 == 0, "Unfair time-based logic")}