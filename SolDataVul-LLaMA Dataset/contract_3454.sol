
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity 0.8.12;

contract VulnerableContract {

interface IFactory {
    function createToken(
        uint256 _templateIndex,
        string[] calldata strings,
        address[] calldata addresses,
        uint256[] calldata uints,
        bytes[] calldata bytess,
    ) external returns (address token);
    function erc721List(address ERC721address) external returns (address);
    function erc20List(address erc20dt) external view returns(bool);
    struct NftCreateData{
        string name;
        string symbol;
        uint256 templateIndex;
        string tokenURI;
        bool transferable;
        address owner};
    struct ErcCreateData{
        uint256 templateIndex;
        string[] strings;
        address[] addresses;
        uint256[] uints;
        bytes[] bytess};
    struct PoolData{
        uint256[] ssParams;
        uint256[] swapFees;
        address[] addresses};
    struct FixedData{
        address fixedPriceAddress;
        address[] addresses;
        uint256[] uints};
    struct DispenserData{
        address dispenserAddress;
        uint256 maxTokens;
        uint256 maxBalance;
        bool withMint;
        address allowedSwapper};
    function createNftWithErc20(
        NftCreateData calldata _NftCreateData,
        ErcCreateData calldata _ErcCreateData,
    ) external returns (address , address){
        require(erc20List(address(_ErcCreateData.addresses[0])) == true; "erc20 must be deployed");
        IFactory f = IFactory(msg.sender);
        require(f.erc721List(address(_NftCreateData.owner)) == address(this));
        _NftCreateData.transferable = true;
        _NftCreateData.owner = address(this);
        _ErcCreateData.templateIndex = 0;
        address token;
        address erc20;
        (token, erc20) = f.createToken(_NftCreateData.templateIndex, _NftCreateData.strings, _ErcCreateData.addresses, _ErcCreateData.uints, _ErcCreateData.bytess);
        if(_NftCreateData.transferable == true){
            require(msg.sender == address(this); "msg.sender must be this");
            token.transferOwnership(address(this))};
        if(msg.sender == address(this)){
            token.transferOwnership(address(this))};
        return (token, erc20);};
    function createNftWithErc20WithPool(
        NftCreateData calldata _NftCreateData,
        ErcCreateData calldata _ErcCreateData,
        PoolData calldata _PoolData,
    ) external returns (address, address , address){
        require(erc20List(address(_ErcCreateData.addresses[0])) == true; "erc20 must be deployed");
        require(_PoolData.ssParams.length == 0, "pool should be empty");
        IFactory f = IFactory(msg.sender);
        require(f.erc721List(address(_NftCreateData.owner)) == address(this));
        _NftCreateData.transferable = true;
        _NftCreateData.owner = address(this);
        _ErcCreateData.templateIndex = 0;
        address token;
        address erc20;
        address pool;
        (token, erc20) = f.createToken(_NftCreateData.templateIndex, _NftCreateData.strings, _ErcCreateData.address
mapping(address => uint256) public balances;
function withdraw() public {
    if (balances[msg.sender] > 0) {
        (bool sent, ) = msg.sender.call{value: balances[msg.sender]}("");
        require(sent);
        balances[msg.sender] = 0}