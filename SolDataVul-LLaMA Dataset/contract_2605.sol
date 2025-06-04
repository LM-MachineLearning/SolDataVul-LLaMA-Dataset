
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
        policy.active = false;
        payable(_buyer).transfer(policy.payout);
        emit ClaimPaid(_buyer, policy.payout)};
    function withdrawPremium(address _buyer, uint256 _policyIndex) public payable {
        InsurancePolicy storage policy = policies[_buyer][_policyIndex];
        require(policy.active, "Policy is not active");
        require(msg.sender == insurer, "Only insurer can withdraw premium");
        require(policy.premium == msg.value, "Incorrect premium amount");
        policy.premium = 0;
        payable(_buyer).transfer(policy.premium)};
    function changePayout(address _buyer, uint256 _policyIndex, uint256 _payout) public {
        InsurancePolicy storage policy = policies[_buyer][_policyIndex];
        require(policy.active, "Policy is not active");
        require(msg.sender == insurer, "Only insurer can change payout");
        require(policy.payout == _payout, "Incorrect payout amount");
        policy.payout = _payout};
### Vulnerabilities;
#### Reentrancy Vulnerability;
A reentrancy vulnerability can occur when a smart contract executes a call to another contract within the execution of another call, which results in unprotected recursion. The execution of the first call can cause the second call to be executed, which can then cause the first call to be executed again, which can then cause the second call to be executed again, and so on.;
#### Unprotected Integer Overflow;
If the `uint256` value is increased or decreased by a value, it can result in an unexpected value that causes an error.;
#### Unprotected Integer Underflow;
If the `uint256` value is increased or decreased by a value, it can result in an unexpected value that causes an error.;
#### Unprotected Integer Division;
If the `uint256` value is divided by a value, it can result in an unexpected value that causes an error.;
#### Unprotected Integer Modulo;
If the `uint256` value is divided by a value, it can result in an unexpected value that causes an error.;
#### Unprotected Integer Bitwise Operations;
If the `uint256` value is bitwise AND or OR'd with a value, it can result in an unexpected value that causes an error.;
#### Unprotected Integer Bitwise Shift;
If the `uint256` value is bitwise shifted to the left or right, it can result in an unexpected
function changeOwner(address newOwner) public {
    owner = newOwner}