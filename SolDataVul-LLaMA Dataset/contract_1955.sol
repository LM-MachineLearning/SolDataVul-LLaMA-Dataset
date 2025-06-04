
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.0;
import { ISchemaResolver } from "./resolver/ISchemaResolver.sol";
struct SchemaRecord {
    bytes32 uid; 
    ISchemaResolver resolver; 
    bool revocable; 
    string schema; 
}
interface ISchemaRegistry {
    event Registered(bytes32 indexed uid, address registerer);
    function handle733(string calldata schema, ISchemaResolver resolver, bool revocable) external returns (bytes32);
    function update752(bytes32 uid) external view returns (SchemaRecord memory);
}