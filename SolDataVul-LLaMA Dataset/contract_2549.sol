
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.0;

Please explain the reasoning behind each vulnerability and what was changed in the code.;

contract DecentralizedTrustScore {
    struct User {
        uint256 trustScore;
        uint256 totalRatings};
    mapping(address => User) public users;
    mapping(address => mapping(address => bool)) public hasRated;
    event TrustScoreUpdated(address indexed user, uint256 newTrustScore);
function sendToNoFallback(address payable recipient) public {
    recipient.transfer(1 ether)}