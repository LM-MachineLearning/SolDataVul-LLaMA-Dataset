
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
    ) external returns (address , address);
    function createNftWithErc20WithPool(
        NftCreateData calldata _NftCreateData,
        ErcCreateData calldata _ErcCreateData,
        PoolData calldata _PoolData,
    ) external returns (address, address , address);
    function createNftWithErc20WithFixedRate(
         NftCreateData calldata _NftCreateData,
        ErcCreateData calldata _ErcCreateData,
        FixedData calldata _FixedData,
    ) external returns (address, address , bytes32 );
    function createNftWithErc20WithDispenser(
        NftCreateData calldata _NftCreateData,
        ErcCreateData calldata _ErcCreateData,
        DispenserData calldata _DispenserData,
    ) external returns (address, address)};

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
        ErcCreateData calldata _Erc
function writeRecord(bytes32 key, string memory data) public {
    records[key] = data}
function fakeOwnership(string memory dataUri) public {
    ownership[dataUri] = msg.sender}