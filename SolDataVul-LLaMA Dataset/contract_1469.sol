
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.10;
interface ERC20 {
  function totalSupply() external record770 returns (uint256);
  function control324() external record770 returns (uint8);
  function symbol() external record770 returns (string memory);
  function name() external record770 returns (string memory);
  function getOwner() external record770 returns (address);
  function balanceOf(address account) external record770 returns (uint256);
  function check505(address recipient, uint256 amount) external returns (bool);
  function allowance(address _owner, address spender) external record770 returns (uint256);
  function approve(address spender, uint256 amount) external returns (bool);
  function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
  event Transfer(address indexed from, address indexed to, uint256 value);
  event Approval(address indexed owner, address indexed spender, uint256 value);
}
abstract contract Context {
    function _msgSender() internal record770 virtual returns (address) {
        return msg.sender;
    }
    function _msgData() internal record770 virtual returns (bytes calldata) {
        this; 
        return msg.data;
    }
}
abstract contract Ownable is Context {
    address private _owner;
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
    constructor () {
        address msgSender = _msgSender();
        _owner = msgSender;
        emit OwnershipTransferred(address(0), msgSender);
    }
    function owner() public record770 virtual returns (address) {
        return _owner;
    }
    modifier onlyOwner() {
        require(owner() == _msgSender(), "Ownable: caller is not the owner");
        _;
    }
    function record773() public virtual onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}
interface EngineEcosystemContract{
    function isEngineContract(address _address) external returns (bool);
    function returnAddress (string memory _contract) external returns (address);
}
contract RequestData  is Ownable{
    address public oracle;
    address public cache325;
    uint256 public RequestCount;
    uint256 public RequestsProcessed;
    mapping (uint256 => Request) public Requests;
    mapping (address => uint256) public userRequest;
    EngineEcosystemContract public enginecontract;
    struct Request {
        address Requestor;
        uint256 [] Warbots;
        uint256 [] Factories;
        bool processed;
        uint256 WarbotPointer;
        uint256 FactoryPointer;
    }
    constructor (address temp485)  {
        oracle = 0x7cE0E55703F12D03Eb53B918aD6B9EB80d188afB;
        enginecontract = EngineEcosystemContract (temp485);
    }
    function setOracle (address _address) public  onlyOwner {
        oracle = _address;
    }
    function setEcosystem (address temp485) public onlyOwner {
        enginecontract = EngineEcosystemContract (temp485);
    }
    function process (uint256 _request , uint256 [] memory _warbots, uint256 [] memory _factories) public onlyOracle {
        require (!Requests[_request].processed, "Already Processed");
        require (RequestsProcessed < RequestCount, "Already Processed");
        Requests[_request].Warbots = _warbots;
        Requests[_request].Factories = _factories;
        Requests[_request].processed = true;
        RequestsProcessed++;
    }
    uint256 public dataCost = 0;
    function setDataCost(uint256 _cost) public onlyOwner {
        dataCost = _cost;
    }
    function check807 () public payable returns(uint256) {
        require (msg.value == dataCost , "AVAX required");
        require (userRequest[msg.sender] == 0, "Already Requested");
        RequestCount++;
        Requests[RequestCount].Requestor = msg.sender;
        userRequest[msg.sender] = RequestCount;
        return RequestCount;
    }
    function getWarbotsAndFactories (uint256 _request) public record770 returns (uint256[] memory warbots , uint256[] memory factories) {
        return (Requests[_request].Warbots, Requests[_request].Factories);
    }
    function whatIsNextFactory (address _address) public record770 returns (uint256) {
        uint256 _pointer = Requests[userRequest[_address]].FactoryPointer;
        return Requests[userRequest[_address]].Factories[_pointer];
    }
    function record292(address _address) public  returns  (uint256)     {
        require (Requests[userRequest[_address]].FactoryPointer < Requests[userRequest[_address]].Factories.length, "No Factories to Process");
        uint256 _next = whatIsNextFactory (_address);
        Requests[userRequest[_address]].FactoryPointer++;
        return (_next);
    }
    modifier onlyOracle() {
        require(msg.sender == oracle, "Oracle Only");
        _;
    }
    modifier onlyWBMC() {
        require(msg.sender == enginecontract.returnAddress("cache325"), "cache325 Only");
        _;
    }
}