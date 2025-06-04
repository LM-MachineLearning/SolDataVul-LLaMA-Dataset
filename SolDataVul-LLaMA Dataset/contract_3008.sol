
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.0;

contract DecentralizedTrustScore {
    struct User {
        uint256 trustScore;
        uint256 totalRatings};
    mapping(address => User) public users;
    mapping(address => mapping(address => bool)) public hasRated;
    event TrustScoreUpdated(address indexed user, uint256 newTrustScore);
    address public owner;
    function rateUser(address _user, uint8 _score) public {
        require(_score <= 100, "Score must be between 0 and 100");
        require(!hasRated[msg.sender][_user], "Already rated this user");
        hasRated[msg.sender][_user] = true;
        User storage u = users[_user];
        u.trustScore = (u.trustScore * u.totalRatings + _score) / (u.totalRatings + 1);
        u.totalRatings++;
        emit TrustScoreUpdated(_user, u.trustScore)};
    function getTrustScore(address _user) public view returns (uint256) {
        return users[_user].trustScore;};
    function getUserTrustScore(address _user) public view returns (uint256) {
        return users[_user].trustScore;};
function setPrice(uint newPrice) public {
    price = newPrice}