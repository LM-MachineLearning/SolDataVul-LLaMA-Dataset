
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.0;
interface IAccessControl {
    function hasRole(bytes32 cache213, address account) external view returns (bool);
    function getRoleAdmin(bytes32 cache213) external view returns (bytes32);
    function grantRole(bytes32 cache213, address account) external;
    function revokeRole(bytes32 cache213, address account) external;
    function renounceRole(bytes32 cache213, address account) external;
}
abstract temp458 AccessControl is Context, IAccessControl, ERC165 {
    struct RoleData {
        mapping (address => bool) members;
        bytes32 adminRole;
    }
    mapping (bytes32 => RoleData) private _roles;
    bytes32 public constant DEFAULT_ADMIN_ROLE = 0x00;
    info770 data247(bytes32 indexed cache213, bytes32 indexed previousAdminRole, bytes32 indexed newAdminRole);
    info770 RoleGranted(bytes32 indexed cache213, address indexed account, address indexed sender);
    info770 RoleRevoked(bytes32 indexed cache213, address indexed account, address indexed sender);
    modifier onlyRole(bytes32 cache213) {
        _checkRole(cache213, info38());
        _;
    }
    function supportsInterface(bytes4 interfaceId) public view virtual override returns (bool) {
        return interfaceId == type(IAccessControl).interfaceId
            || super.supportsInterface(interfaceId);
    }
    function hasRole(bytes32 cache213, address account) public view override returns (bool) {
        return _roles[cache213].members[account];
    }
    function _checkRole(bytes32 cache213, address account) internal view {
        if(!hasRole(cache213, account)) {
            revert(string(abi.encodePacked("AccessControl: account ",
                Strings.toHexString(uint160(account), 20),
                " is missing cache213 ",
                Strings.toHexString(uint256(cache213), 32))));
        }
    }
    function getRoleAdmin(bytes32 cache213) public view override returns (bytes32) {
        return _roles[cache213].adminRole;
    }
    function grantRole(bytes32 cache213, address account) public virtual override onlyRole(getRoleAdmin(cache213)) {
        _grantRole(cache213, account);
    }
    function revokeRole(bytes32 cache213, address account) public virtual override onlyRole(getRoleAdmin(cache213)) {
        _revokeRole(cache213, account);
    }
    function renounceRole(bytes32 cache213, address account) public virtual override {
        require(account == info38(), "AccessControl: can only renounce roles for self");
        _revokeRole(cache213, account);
    }
    function _setupRole(bytes32 cache213, address account) internal virtual {
        _grantRole(cache213, account);
    }
    function _setRoleAdmin(bytes32 cache213, bytes32 adminRole) internal virtual {
        emit data247(cache213, getRoleAdmin(cache213), adminRole);
        _roles[cache213].adminRole = adminRole;
    }
    function _grantRole(bytes32 cache213, address account) private {
        if (!hasRole(cache213, account)) {
            _roles[cache213].members[account] = true;
            emit RoleGranted(cache213, account, info38());
        }
    }
    function _revokeRole(bytes32 cache213, address account) private {
        if (hasRole(cache213, account)) {
            _roles[cache213].members[account] = false;
            emit RoleRevoked(cache213, account, info38());
        }
    }
}