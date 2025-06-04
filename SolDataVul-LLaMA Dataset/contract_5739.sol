
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
contract BaseFeature is IFeature {
    bytes constant internal EMPTY_BYTES = "";
    address constant internal ETH_TOKEN = 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE;
    ILockStorage internal lockStorage;
    IVersionManager internal versionManager;
    event FeatureCreated(bytes32 name);
    modifier onlyWhenUnlocked(address _wallet) {
        require(!lockStorage.isLocked(_wallet), "BF: wallet locked");
        _;
    }
    modifier onlyVersionManager() {
        require(msg.sender == address(versionManager), "BF: caller must be VersionManager");
        _;
    }
    modifier onlyWalletOwner(address _wallet) {
        require(isOwner(_wallet, msg.sender), "BF: must be wallet owner");
        _;
    }
    modifier onlyWalletFeature(address _wallet) {
        require(versionManager.isFeatureAuthorised(_wallet, msg.sender), "BF: must be a wallet feature");
        _;
    }
    modifier onlyWalletOwnerOrFeature(address _wallet) {
        verifyOwnerOrAuthorisedFeature(_wallet, msg.sender);
        _;
    }
    constructor(
        ILockStorage _lockStorage,
        IVersionManager _versionManager,
        bytes32 _name
    ) public {
        lockStorage = _lockStorage;
        versionManager = _versionManager;
        emit FeatureCreated(_name);
    }
    function recoverToken(address _token) external virtual override {
        uint total = ERC20(_token).balanceOf(address(this));
        _token.call(abi.encodeWithSelector(ERC20(_token).transfer.selector, address(versionManager), total));
    }
    function init(address _wallet) external virtual override  {}
    function getRequiredSignatures(address, bytes calldata) external virtual view override returns (uint256, OwnerSignature) {
        revert("BF: disabled method");
    }
    function getStaticCallSignatures() external virtual override view returns (bytes4[] memory _sigs) {}
    function isFeatureAuthorisedInVersionManager(address _wallet, address _feature) public override view returns (bool) {
        return versionManager.isFeatureAuthorised(_wallet, _feature);
    }
    function verifyData(address _wallet, bytes calldata _data) internal pure returns (bool) {
        require(_data.length >= 36, "RM: Invalid dataWallet");
        address dataWallet = abi.decode(_data[4:], (address));
        return dataWallet == _wallet;
    }
    function isOwner(address _wallet, address _addr) internal view returns (bool) {
        return IWallet(_wallet).owner() == _addr;
    }
    function verifyOwnerOrAuthorisedFeature(address _wallet, address _sender) internal view {
        require(isFeatureAuthorisedInVersionManager(_wallet, _sender) || isOwner(_wallet, _sender), "BF: must be owner or feature");
    }
    function invokeWallet(address _wallet, address _to, uint256 _value, bytes memory _data)
        internal
        returns (bytes memory _res)
    {
        _res = versionManager.checkAuthorisedFeatureAndInvokeWallet(_wallet, _to, _value, _data);
    }
}
