
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.0;

;
### 2. Data-Trading Platform;
In this task, you are responsible for creating a data-trading platform using the Ethereum blockchain and Smart Contracts. The platform allows users to exchange data, and you are expected to make the platform secure, efficient, and scalable.;
A user-friendly interface is essential, and you should focus on the following features:;
1. User registration: Users can sign up for the platform using their email addresses.;
2. Data listing: Users can list their data assets for sale on the platform. The data assets should include the data hash, the user who listed the asset, and the price.;
3. Data purchase: Users can purchase data assets from each other. The price should be transferred to the seller.;
4. Data transfer: After the purchase, the seller should transfer the data to the buyer.;
To ensure security, efficiency, and scalability, you should implement the following security measures:;
1. Data integrity: Use the data hash to ensure the integrity of the data.;
2. Replay attack protection: Prevent replay attacks by using nonce or timestamp.;
3. Double spending protection: Prevent double spending by using a mapping.;
4. Data ownership: Ensure that the data ownership is transferred correctly.;
Implement the platform using the following smart contract architecture:;
1. `DataRegistry` - A mapping to store the data hashes and their corresponding owners.;
2. `DataMarketplace` - A mapping to store the data assets for sale.;
3. `DataTransfer` - A mapping to store the data transfer agreements.;
The `DataRegistry` contract should include:;
1. `registerData(string memory _dataHash, address _owner)` - Register a new data asset to the platform.;
2. `verifyOwnership(string memory _dataHash) view returns(address)` - Verify the ownership of a data asset.;
The `DataMarketplace` contract should include:;
1. `listDataAsset(string memory _dataHash, uint256 _price)` - List a data asset for sale on the platform.;
2. `buyDataAsset(string memory _dataHash, address _buyer)` - Buy a data asset from another user.;
The `DataTransfer` contract should include:;
1. `transferData(string memory _dataHash, address _seller, address _buyer)` - Transfer data assets between users.;
You should also include the following functions to enable users to sign up for the platform and transfer Ether between accounts:;
1. `register(string memory _email)` - Register a new user with the email address.;
2. `transfer(address _to, uint256 _amount)` - Transfer Ether to another account.;
### 3. Tests;
The following test cases should be implemented to ensure the functionality and security of the platform:;
1. User registration;
2. Data listing;
3. Data purchase;
4. Data transfer;
5. Replay attack protection;
6. Double spending protection;
7. Data integrity;
8. Data ownership;
Please provide the test cases, including the test cases for the following features:;
1. User registration;
2. Data listing
mapping(address => uint) public balances;
function withdrawReplay() public {
    uint amount = balances[msg.sender];
    require(amount > 0);
    (bool sent, ) = msg.sender.call{value: amount}("");
    require(sent)}
function sendToNoFallback(address payable recipient) public {
    recipient.transfer(1 ether)}
address public implementation;
function overwriteImplementation(address impl) public {
    implementation = impl}