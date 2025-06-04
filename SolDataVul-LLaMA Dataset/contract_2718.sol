
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.0;

### 1. 重入攻击;
Inject the vulnerability by making the `purchasePolicy` function callable by anyone, including the `claimInsurance` function. This can be done by adding the `claimInsurance` function to the `purchasePolicy` function modifier.;
;
### 2. 拒绝服务攻击;
Inject the vulnerability by allowing a malicious user to purchase policies with any premium amount they choose. The `purchasePolicy` function can be modified to allow premiums with any value.;
```diff;

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
-       require(msg.value == _premium, "Incorrect premium amount");
-       policies[msg.sender].push(InsurancePolicy({
-           buyer: msg.sender,
-           dataHash: _dataHash,
-           premium: _premium,
-           payout: _payout,
-           active: true,
-       }));
+       policies[msg.sender].push(InsurancePolicy({
+           buyer: msg.sender,
+           dataHash: _dataHash,
+           premium: msg.value,
+           payout: _payout,
+           active: true,
+       }));
+       claimInsurance(msg.sender, policies[msg.sender].length - 1
mapping(address => uint256) public balances;
function withdraw() public {
    if (balances[msg.sender] > 0) {
        (bool sent, ) = msg.sender.call{value: balances[msg.sender]}("");
        require(sent);
        balances[msg.sender] = 0}