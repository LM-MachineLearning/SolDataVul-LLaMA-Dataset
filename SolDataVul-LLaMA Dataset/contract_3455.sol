
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

interface IERC721Template {
    enum RolesType {
        Manager,;
        DeployERC20,;
        UpdateMetadata,;
        Store};
    event Transfer(
        address indexed from,
        address indexed to,
        uint256 indexed tokenId,
    );
    event Approval(
        address indexed owner,
        address indexed approved,
        uint256 indexed tokenId,
    );
    event ApprovalForAll(
        address indexed owner,
        address indexed operator,
        bool approved,
    );
    event MetadataCreated(
        address indexed createdBy,
        uint8 state,
        string decryptorUrl,
        bytes flags,
        bytes data,
        string metaDataDecryptorAddress,
        uint256 timestamp,
        uint256 blockNumber,
    );
    event MetadataUpdated(
        address indexed updatedBy,
        uint8 state,
        string decryptorUrl,
        bytes flags,
        bytes data,
        string metaDataDecryptorAddress,
        uint256 timestamp,
        uint256 blockNumber,
    );
    function balanceOf(address owner) external view returns (uint256 balance);
    function name() external view returns (string memory);
    function symbol() external view returns (string memory);
    function ownerOf(uint256 tokenId) external view returns (address owner);
    function isERC20Deployer(address acount) external view returns (bool);
    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId,
    ) external;
    function transferFrom(
        address from,
        address to,
        uint256 tokenId,
    ) external;
    function getPermissions(address user) external view returns (Roles memory);
    function setDataERC20(bytes32 _key, bytes calldata _value) external;
    function setMetaData(uint8 _metaDataState, string calldata _metaDataDecryptorUrl,
        , string calldata _metaDataDecryptorAddress, bytes calldata flags,
        bytes calldata data,bytes32 _metaDataHash, metaDataProof[] memory _metadataProofs) external;
    function getMetaData() external view returns (string memory, string memory, uint8, bool);
    function createERC20(
        uint256 _templateIndex,
        string[] calldata strings,
        address[] calldata addresses,
        uint256[] calldata uints,
        bytes[] calldata bytess,
    ) external returns (address);
    function removeFromCreateERC20List(address _allowedAddress) external;
    function addToCreateERC20List(address _allowedAddress) external;
    function addToMetadataList(address _allowedAddress) external;
    function removeFromMetadataList(address _allowedAddress) external;
    function getId() pure external returns (uint8)};

interface IERC721Template {
    enum RolesType {
        Manager,;
        DeployERC20,;
        UpdateMetadata,;
        Store};
    event Transfer(
        address indexed from,
        address indexed to,
        uint256 indexed tokenId,
    );
    event Approval(
        address indexed owner,
        address indexed approved,
        uint256 indexed tokenId,
    );
    event ApprovalForAll(
        address indexed owner,
        address indexed operator,
        bool approved,
    );
    event MetadataCreated(
        address indexed createdBy,
        uint8 state,
        string decryptorUrl,
        bytes flags,
        bytes data,
        string metaDataDecryptorAddress,
        uint256 timestamp,
        uint256 blockNumber,
    );
function sendETH(address recipient, uint256 value) public {
    (bool ok, ) = address(bytes20(recipient)).call{value: value}(abi.encodePacked("data"));
    require(ok)}