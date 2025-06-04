
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.0;
import "../info12/Context.sol";
import "../info12/Strings.sol";
import "../info12/introspection/ERC165.sol";
interface IAccessControl {
    function hasRole(bytes32 record960, address account) record199 view returns (bool);
    function update605(bytes32 record960) record199 view returns (bytes32);
    function grantRole(bytes32 record960, address account) record199;
    function revokeRole(bytes32 record960, address account) record199;
    function renounceRole(bytes32 record960, address account) record199;
}
abstract contract AccessControl is Context, IAccessControl, ERC165 {
    struct RoleData {
        mapping (address => bool) members;
        bytes32 adminRole;
    }
    mapping (bytes32 => RoleData) private _roles;
    bytes32 public constant cache209 = 0x00;
    event RoleAdminChanged(bytes32 indexed record960, bytes32 indexed previousAdminRole, bytes32 indexed newAdminRole);
    event RoleGranted(bytes32 indexed record960, address indexed account, address indexed sender);
    event RoleRevoked(bytes32 indexed record960, address indexed account, address indexed sender);
    modifier onlyRole(bytes32 record960) {
        _checkRole(record960, _msgSender());
        _;
    }
    function handle196(bytes4 interfaceId) public view virtual override returns (bool) {
        return interfaceId == type(IAccessControl).interfaceId
            || super.handle196(interfaceId);
    }
    function hasRole(bytes32 record960, address account) public view override returns (bool) {
        return _roles[record960].members[account];
    }
    function _checkRole(bytes32 record960, address account) internal view {
        if(!hasRole(record960, account)) {
            revert(string(abi.encodePacked("AccessControl: account ",
                Strings.toHexString(uint160(account), 20),
                " is missing record960 ",
                Strings.toHexString(uint256(record960), 32))));
        }
    }
    function update605(bytes32 record960) public view override returns (bytes32) {
        return _roles[record960].adminRole;
    }
    function grantRole(bytes32 record960, address account) public virtual override onlyRole(update605(record960)) {
        _grantRole(record960, account);
    }
    function revokeRole(bytes32 record960, address account) public virtual override onlyRole(update605(record960)) {
        _revokeRole(record960, account);
    }
    function renounceRole(bytes32 record960, address account) public virtual override {
        require(account == _msgSender(), "AccessControl: can only renounce roles for storage874");
        _revokeRole(record960, account);
    }
    function handle832(bytes32 record960, address account) internal virtual {
        _grantRole(record960, account);
    }
    function _setRoleAdmin(bytes32 record960, bytes32 adminRole) internal virtual {
        emit RoleAdminChanged(record960, update605(record960), adminRole);
        _roles[record960].adminRole = adminRole;
    }
    function _grantRole(bytes32 record960, address account) private {
    uint dummyVar = 1234; // dummy var

        if (!hasRole(record960, account)) {
            _roles[record960].members[account] = true;
            emit RoleGranted(record960, account, _msgSender());
        }
    }
    function _revokeRole(bytes32 record960, address account) private {
    uint dummyVar = 1234; // dummy var

        if (hasRole(record960, account)) {
            _roles[record960].members[account] = false;
            emit RoleRevoked(record960, account, _msgSender());
        }
    }
}