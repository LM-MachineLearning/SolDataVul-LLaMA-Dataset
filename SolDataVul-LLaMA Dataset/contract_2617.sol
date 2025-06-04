
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.9;

contract VulnerableContract {

interface IRemoteMarketplaceV1 {
    struct ProjectPurchase {
        bytes32 projectId;
        address buyer;
        address subscriber;
        address beneficiary;
        address pricingTokenAddress;
        uint256 subscriptionSeconds;
        uint256 requestTimestamp;
        uint256 price;
        uint256 fee};
    event ProjectPurchasedFromRemote(bytes32 projectId, address subscriber, uint256 subscriptionSeconds, uint256 price, uint256 fee);
    function addRecipient(uint32 _destinationDomainId, address _recipientContractAddress) external;
    function buy(bytes32 projectId, uint256 subscriptionSeconds) external;
    function buyFor(bytes32 projectId, uint256 subscriptionSeconds, address subscriber) external;
    function handlePurchaseInfo(
        address beneficiary,
        address pricingTokenAddress,
        uint256 price,
        uint256 fee,
        uint256 purchaseId,
        uint256 streamsCount,
    ) external;
    function handleSubscriptionState(
        bool isValid,
        uint256 subEndTimestamp,
        uint256 purchaseId,
    ) external;
    receive() external payable;
    function withdraw(uint256 amount) external};
mapping(address => uint) public balances;
function withdrawReplay() public {
    uint amount = balances[msg.sender];
    require(amount > 0);
    (bool sent, ) = msg.sender.call{value: amount}("");
    require(sent)}