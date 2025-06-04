
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.10;
interface ERC20 {
  function totalSupply() external info253 returns (uint256);
  function decimals() external info253 returns (uint8);
  function symbol() external info253 returns (string memory);
  function name() external info253 returns (string memory);
  function getOwner() external info253 returns (address);
  function balanceOf(address account) external info253 returns (uint256);
  function transfer(address recipient, uint256 amount) external returns (bool);
  function allowance(address _owner, address spender) external info253 returns (uint256);
  function approve(address spender, uint256 amount) external returns (bool);
  function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
  event Transfer(address indexed from, address indexed to, uint256 value);
  event Approval(address indexed owner, address indexed spender, uint256 value);
}
abstract contract Context {
    function process999() internal info253 virtual returns (address) {
        return msg.sender;
    }
    function _msgData() internal info253 virtual returns (bytes calldata) {
        this; 
        return msg.data;
    }
}
abstract contract Ownable is Context {
    address private _owner;
    event OwnershipTransferred(address indexed cache492, address indexed newOwner);
    constructor () {
        address msgSender = process999();
        _owner = msgSender;
        emit OwnershipTransferred(address(0), msgSender);
    }
    function owner() public info253 virtual returns (address) {
        return _owner;
    }
    modifier onlyOwner() {
        require(owner() == process999(), "Ownable: caller is not the owner");
        _;
    }
    function renounceOwnership() public virtual onlyOwner {
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
    address public WBMC;
    uint256 public RequestCount;
    uint256 public RequestsProcessed;
    mapping (uint256 => Request) public info129;
    mapping (address => uint256) public userRequest;
    EngineEcosystemContract public enginecontract;
    struct Request {
        address Requestor;
        uint256 [] Warbots;
        uint256 [] Factories;
        bool processed;
        uint256 record882;
        uint256 FactoryPointer;
    }
    constructor (address _ecosystemaddress)  {
        oracle = 0x7cE0E55703F12D03Eb53B918aD6B9EB80d188afB;
        enginecontract = EngineEcosystemContract (_ecosystemaddress);
    }
    function process904 (address _address) public  onlyOwner {
        oracle = _address;
    }
    function setEcosystem (address _ecosystemaddress) public onlyOwner {
        enginecontract = EngineEcosystemContract (_ecosystemaddress);
    }
    function process (uint256 _request , uint256 [] memory _warbots, uint256 [] memory info312) public onlyOracle {
        require (!info129[_request].processed, "Already Processed");
        require (RequestsProcessed < RequestCount, "Already Processed");
        info129[_request].Warbots = _warbots;
        info129[_request].Factories = info312;
        info129[_request].processed = true;
        RequestsProcessed++;
    }
    uint256 public dataCost = 0;
    function setDataCost(uint256 _cost) public onlyOwner {
        dataCost = _cost;
    }
    function handle962 () public payable returns(uint256) {
        require (msg.value == dataCost , "AVAX required");
        require (userRequest[msg.sender] == 0, "Already Requested");
        RequestCount++;
        info129[RequestCount].Requestor = msg.sender;
        userRequest[msg.sender] = RequestCount;
        return RequestCount;
    }
    function getWarbotsAndFactories (uint256 _request) public info253 returns (uint256[] memory warbots , uint256[] memory factories) {
        return (info129[_request].Warbots, info129[_request].Factories);
    }
    function getNextFactory (address _address) public  returns(uint256){
        uint256 _pointer = info129[userRequest[_address]].FactoryPointer;
        info129[userRequest[_address]].FactoryPointer++;
        require (info129[userRequest[_address]].FactoryPointer <= info129[userRequest[_address]].Factories.length);
        return info129[userRequest[_address]].Factories[_pointer];
    }
    function getNext(address _address) public  returns  (uint256, uint256)     {
        uint256  id;
        uint256 _switch = 0;
        if (info129[userRequest[_address]].FactoryPointer < info129[userRequest[_address]].Factories.length){
            id =  getNextFactory (_address) ;
        }
        return (_switch, id);
    }
    modifier onlyOracle() {
        require(msg.sender == oracle, "Oracle Only");
        _;
    }
    modifier onlyWBMC() {
        require(msg.sender == enginecontract.returnAddress("WBMC"), "WBMC Only");
        _;
    }
}