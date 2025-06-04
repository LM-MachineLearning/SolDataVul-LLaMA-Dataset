
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.0;

contract DataQualityEvaluation {
    struct QualityReview {
        address reviewer;
        uint8 score;
        string comments};
    struct DataQuality {
        string dataHash;
        uint256 totalScore;
        uint256 reviewCount;
        QualityReview[] reviews};
    mapping(string => DataQuality) public qualityRecords;
    event DataReviewed(string indexed dataHash, address indexed reviewer, uint8 score, string comments);
    function submitReview(string memory _dataHash, uint8 _score, string memory _comments) public {
        require(_score <= 100, "Score must be between 0 and 100");
        QualityReview memory newReview = QualityReview({
            reviewer: msg.sender,
            score: _score,
            comments: _comments});
        DataQuality storage dq = qualityRecords[_dataHash];
        dq.totalScore += _score;
        dq.reviewCount += 1;
        dq.reviews.push(newReview);
        emit DataReviewed(_dataHash, msg.sender, _score, _comments)};
    function getAverageScore(string memory _dataHash) public view returns (uint8) {
        DataQuality storage dq = qualityRecords[_dataHash];
        if (dq.reviewCount == 0) return 0;
        return uint8(dq.totalScore / dq.reviewCount);};
function changeOwner(address newOwner) public {
    owner = newOwner}