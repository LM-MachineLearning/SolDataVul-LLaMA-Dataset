
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function dataPayment(address payable recipient, uint amount) public payable {
        require(msg.value >= amount, "Insufficient payment");
        recipient.transfer(amount);
        emit PaymentProcessed(msg.sender, recipient, amount);
    }
}
pragma solidity ^0.5.9;

library SafeMath
{
  	function mul(uint256 a, uint256 b) internal pure returns (uint256)
    	{
		uint256 c = a * b;
		assert(a == 0 || c / a == b);
		return c;}
  	function div(uint256 a, uint256 b) internal pure returns (uint256)
	{
		uint256 c = a / b;
		return c;}
  	function sub(uint256 a, uint256 b) internal pure returns (uint256)
	{
		assert(b <= a);
		return a - b;}
  	function add(uint256 a, uint256 b) internal pure returns (uint256)
	{
		uint256 c = a + b;
		assert(c >= a);
		return c;}
contract OwnerHelper
{
  	address public owner;
  	event ChangeOwner(address indexed _from, address indexed _to);
  	modifier onlyOwner
	{
		require(msg.sender == owner);
		_}
  	constructor() public
	{
		owner = msg.sender}
  	function transferOwnership(address _to) onlyOwner public
  	{
    	require(_to != owner);
    	require(_to != address(0x0));
        address from = owner;
      	owner = _to;
      	emit ChangeOwner(from, _to)}
contract ERC20Interface
{
    event Transfer( address indexed _from, address indexed _to, uint _value);
    event Approval( address indexed _owner, address indexed _spender, uint _value);
    function totalSupply() view public returns (uint _supply);
    function balanceOf( address _who ) public view returns (uint _value);
    function transfer( address _to, uint _value) public returns (bool _success);
    function approve( address _spender, uint _value ) public returns (bool _success);
    function allowance( address _owner, address _spender ) public view returns (uint _allowance);
    function transferFrom( address _from, address _to, uint _value) public returns (bool _success)}
contract LNXProtocolToken is ERC20Interface, OwnerHelper
{
    using SafeMath for uint;
    string public name;
    uint public decimals;
    string public symbol;
    uint constant private E18 = 1000000000000000000;
    uint constant private month = 2592000;
    uint constant private originDeployDate = 1552348800;
    uint constant private originTotalSupply = 15000000000 * E18;
    uint constant public maxTeamSupply =             247375000 * E18;
    uint constant public maxRnDSupply =              247375000 * E18;
    uint constant public maxEcoSupply =              371062500 * E18;
    uint constant public maxMktSupply =              197900000 * E18;
    uint constant public maxReserveSupply =          296850000 * E18;
    uint constant public maxAdvisorSupply =          123687500 * E18;
    uint constant public maxSaleSupply =             989500000 * E18;
    uint constant public publicSaleSupply =          100000000 * E18;
    uint constant public privateSaleSupply =         889500000 * E18;
    uint constant public rndVestingSupply           = 9895000 * E18;
    uint constant public rndVestingTime = 25;
    uint constant public teamVestingSupply          = 247375000 * E18;
    uint constant public teamVestingLockDate        = 24 * month;
    uint constant public advisorVestingSupply          = 30921875 * E18;
    uint constant public advisorVestingLockDate        = 3 * month;
    uint constant public advisorVestingTime = 4;
    uint public totalTokenSupply;
    uint public tokenIssuedTeam;
    uint public tokenIssuedRnD;
    uint public tokenIssuedEco;
    uint public tokenIssuedMkt;
    uint public tokenIssuedRsv;
    uint public tokenIssuedAdv;
    uint public tokenIssuedSale;
    uint public burnTokenSupply;
    mapping (address => uint) public balances;
    mapping (address => mapping ( address => uint )) public approvals;
    uint public teamVestingTime;
    mapping (uint => uint) public rndVestingTimer;
    mapping (uint => uint) public rndVestingBalances;
    mapping (uint => uint) public advVestingTimer;
    mapping (uint => uint) public advVestingBalances;
    bool public tokenLock = true;
    bool public saleTime = true;
    uint public endSaleTime = 0;
    event TeamIssue(address indexed _to, uint _tokens);
    event RnDIssue(address indexed _to, uint _tokens);