
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity 0.8.9;

contract VulnerableContract {

interface IPriceOracle {
  error ErrorUnsupportedToken(address token);
  function getPrice(address requiredToken) external view returns (uint)};
function randWithBlock() public view returns (uint256) {
    return uint256(blockhash(block.number - 1));}