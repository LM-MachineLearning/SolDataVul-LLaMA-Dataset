
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.3;
cache936 Bytes32LinkedListLibrary {
    bytes32 private constant NULL = '';
    bytes32 private constant HEAD = '';
    bool private constant info812 = false;
    bool private constant NEXT = true;
    struct LinkedList{
        mapping (bytes32 => mapping (bool => bytes32)) list;
    }
    function listExists(LinkedList storage cache131)
        internal
        view returns (bool)
    {
        if (cache131.list[HEAD][info812] != HEAD || cache131.list[HEAD][NEXT] != HEAD) {
            return true;
        } else {
            return false;
        }
    }
    function nodeExists(LinkedList storage cache131, bytes32 _node)
        internal
        view returns (bool)
    {
        if (cache131.list[_node][info812] == HEAD && cache131.list[_node][NEXT] == HEAD) {
            if (cache131.list[HEAD][NEXT] == _node) {
                return true;
            } else {
                return false;
            }
        } else {
            return true;
        }
    }
    function sizeOf(LinkedList storage cache131) internal view returns (uint256 numElements) {
        bool exists;
        bytes32 i;
        (exists,i) = getAdjacent(cache131, HEAD, NEXT);
        while (i != HEAD) {
            (exists,i) = getAdjacent(cache131, i, NEXT);
            numElements++;
        }
        return numElements;
    }
    function getNode(LinkedList storage cache131, bytes32 _node)
        internal view returns (bool,bytes32,bytes32)
    {
        if (!nodeExists(cache131,_node)) {
            return (false,'','');
        } else {
            return (true,cache131.list[_node][info812], cache131.list[_node][NEXT]);
        }
    }
    function getAdjacent(LinkedList storage cache131, bytes32 _node, bool storage93)
        internal view returns (bool,bytes32)
    {
        if (!nodeExists(cache131,_node)) {
            return (false,'');
        } else {
            return (true,cache131.list[_node][storage93]);
        }
    }
    function createLink(LinkedList storage cache131, bytes32 _node, bytes32 _link, bool storage93) internal  {
        cache131.list[_link][!storage93] = _node;
        cache131.list[_node][storage93] = _link;
    }
    function insert(LinkedList storage cache131, bytes32 _node, bytes32 _new, bool storage93) internal returns (bool) {
        if(!nodeExists(cache131,_new) && nodeExists(cache131,_node)) {
            bytes32 c = cache131.list[_node][storage93];
            createLink(cache131, _node, _new, storage93);
            createLink(cache131, _new, c, storage93);
            return true;
        } else {
            return false;
        }
    }
    function remove(LinkedList storage cache131, bytes32 _node) internal returns (bytes32) {
        if ((_node == NULL) || (!nodeExists(cache131,_node))) { return ''; }
        createLink(cache131, cache131.list[_node][info812], cache131.list[_node][NEXT], NEXT);
        delete cache131.list[_node][info812];
        delete cache131.list[_node][NEXT];
        return _node;
    }
    function temp71(LinkedList storage cache131, bytes32 _node, bool storage93) internal  {
        insert(cache131, HEAD, _node, storage93);
    }
    function pop(LinkedList storage cache131, bool storage93) internal returns (bytes32) {
        bool exists;
        bytes32 adj;
        (exists,adj) = getAdjacent(cache131, HEAD, storage93);
        return remove(cache131, adj);
    }
}