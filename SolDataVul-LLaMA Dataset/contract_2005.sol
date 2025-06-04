
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity 0.8.12;

The contract should be modified to inject the specified vulnerabilities.;

interface IERC721Receiver {
    function onERC721Received(address operator, address from, uint256 tokenId, bytes calldata data) external returns (bytes4) {
        require(msg.value > 0, "msg.value should be greater than 0");
        require(!_locked, "reentrancy protection should be enabled");
        if (msg.value > 0) {
            _locked = true};
        return IERC721Receiver(to).onERC721Received.selector;}
function unsafeTransfer(address to) public {
    to.call{value: address(this).balance}("")}
function unguardedWithdraw() public {
    (bool sent, ) = msg.sender.call{value: 1 ether}("");
    require(sent)}