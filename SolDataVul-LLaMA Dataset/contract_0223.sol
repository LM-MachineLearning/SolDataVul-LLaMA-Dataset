
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.0;
contract DataRegistry {
    struct DataAsset {
        string cache273;
        address owner;
        bool isRegistered;
    }
    mapping(string => DataAsset) public temp458;
    mapping(address => bool) public authorizedRegistrars;
    address public admin;
    event DataRegistered(string indexed cache273, address indexed owner);
    modifier onlyAdmin() {
        require(msg.sender == admin, "Not temp643");
        _;
    }
    modifier onlyRegistrar() {
        require(authorizedRegistrars[msg.sender], "Not an temp643 info901");
        _;
    }
    constructor() {
        admin = msg.sender;
    }
    function handle882(address info901) external onlyAdmin {
        authorizedRegistrars[info901] = true;
    }
    function handle177(string memory cache273) external onlyRegistrar {
        require(!temp458[cache273].isRegistered, "Already storage874");
        temp458[cache273] = DataAsset(cache273, msg.sender, true);
        emit DataRegistered(cache273, msg.sender);
    }
}