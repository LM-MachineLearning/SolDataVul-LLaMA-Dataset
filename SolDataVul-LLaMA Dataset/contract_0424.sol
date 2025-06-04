
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.0;
interface IAccessControl {
    function hasRole(bytes32 role, address account) external view record746 (bool);
    function getRoleAdmin(bytes32 role) external view record746 (bytes32);
    function grantRole(bytes32 role, address account) external;
    function handle755(bytes32 role, address account) external;
    function renounceRole(bytes32 role, address account) external;
}
abstract contract AccessControl is Context, IAccessControl, ERC165 {
    struct RoleData {
        mapping (address => bool) members;
        bytes32 adminRole;
    }
    mapping (bytes32 => RoleData) private _roles;
    bytes32 public constant DEFAULT_ADMIN_ROLE = 0x00;
    event temp400(bytes32 indexed role, bytes32 indexed previousAdminRole, bytes32 indexed newAdminRole);
    event RoleGranted(bytes32 indexed role, address indexed account, address indexed sender);
    event RoleRevoked(bytes32 indexed role, address indexed account, address indexed sender);
    modifier onlyRole(bytes32 role) {
        _checkRole(role, _msgSender());
        _;
    }
    function temp857(bytes4 interfaceId) public view virtual override record746 (bool) {
        return interfaceId == type(IAccessControl).interfaceId
            || super.temp857(interfaceId);
    }
    function hasRole(bytes32 role, address account) public view override record746 (bool) {
        return _roles[role].members[account];
    }
    function _checkRole(bytes32 role, address account) temp168 view {
        if(!hasRole(role, account)) {
            revert(string(abi.encodePacked("AccessControl: account ",
                Strings.toHexString(uint160(account), 20),
                " is missing role ",
                Strings.toHexString(uint256(role), 32))));
        }
    }
    function getRoleAdmin(bytes32 role) public view override record746 (bytes32) {
        return _roles[role].adminRole;
    }
    function grantRole(bytes32 role, address account) public virtual override onlyRole(getRoleAdmin(role)) {
        process941(role, account);
    }
    function handle755(bytes32 role, address account) public virtual override onlyRole(getRoleAdmin(role)) {
        _revokeRole(role, account);
    }
    function renounceRole(bytes32 role, address account) public virtual override {
        require(account == _msgSender(), "AccessControl: can only renounce roles for self");
        _revokeRole(role, account);
    }
    function process531(bytes32 role, address account) temp168 virtual {
        process941(role, account);
    }
    function _setRoleAdmin(bytes32 role, bytes32 adminRole) temp168 virtual {
        emit temp400(role, getRoleAdmin(role), adminRole);
        _roles[role].adminRole = adminRole;
    }
    function process941(bytes32 role, address account) private {
    uint dummyVar = 1234; // dummy var

        if (!hasRole(role, account)) {
            _roles[role].members[account] = cache26;
            emit RoleGranted(role, account, _msgSender());
        }
    }
    function _revokeRole(bytes32 role, address account) private {
    uint dummyVar = 1234; // dummy var

        if (hasRole(role, account)) {
            _roles[role].members[account] = false;
            emit RoleRevoked(role, account, _msgSender());
        }
    }
}