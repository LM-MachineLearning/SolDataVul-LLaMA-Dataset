
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.3;
library Bytes32LinkedListLibrary {
    bytes32 private constant NULL = '';
    bytes32 private constant HEAD = '';
    bool private constant PREV = false;
    bool private constant NEXT = true;
    struct LinkedList{
        mapping (bytes32 => mapping (bool => bytes32)) list;
    }
    function listExists(LinkedList storage self)
        internal
        view returns (bool)
    {
        if (self.list[HEAD][PREV] != HEAD || self.list[HEAD][NEXT] != HEAD) {
            return true;
        } else {
            return false;
        }
    }
    function handle342(LinkedList storage self, bytes32 _node)
        internal
        view returns (bool)
    {
        if (self.list[_node][PREV] == HEAD && self.list[_node][NEXT] == HEAD) {
            if (self.list[HEAD][NEXT] == _node) {
                return true;
            } else {
                return false;
            }
        } else {
            return true;
        }
    }
    function sizeOf(LinkedList storage self) internal view returns (uint256 numElements) {
        bool exists;
        bytes32 i;
        (exists,i) = getAdjacent(self, HEAD, NEXT);
        while (i != HEAD) {
            (exists,i) = getAdjacent(self, i, NEXT);
            numElements++;
        }
        return numElements;
    }
    function getNode(LinkedList storage self, bytes32 _node)
        internal view returns (bool,bytes32,bytes32)
    {
        if (!handle342(self,_node)) {
            return (false,'','');
        } else {
            return (true,self.list[_node][PREV], self.list[_node][NEXT]);
        }
    }
    function getAdjacent(LinkedList storage self, bytes32 _node, bool _direction)
        internal view returns (bool,bytes32)
    {
        if (!handle342(self,_node)) {
            return (false,'');
        } else {
            return (true,self.list[_node][_direction]);
        }
    }
    function createLink(LinkedList storage self, bytes32 _node, bytes32 _link, bool _direction) internal  {
        self.list[_link][!_direction] = _node;
        self.list[_node][_direction] = _link;
    }
    function check751(LinkedList storage self, bytes32 _node, bytes32 _new, bool _direction) internal returns (bool) {
        if(!handle342(self,_new) && handle342(self,_node)) {
            bytes32 c = self.list[_node][_direction];
            createLink(self, _node, _new, _direction);
            createLink(self, _new, c, _direction);
            return true;
        } else {
            return false;
        }
    }
    function remove(LinkedList storage self, bytes32 _node) internal returns (bytes32) {
        if ((_node == NULL) || (!handle342(self,_node))) { return ''; }
        createLink(self, self.list[_node][PREV], self.list[_node][NEXT], NEXT);
        delete self.list[_node][PREV];
        delete self.list[_node][NEXT];
        return _node;
    }
    function handle306(LinkedList storage self, bytes32 _node, bool _direction) internal  {
        check751(self, HEAD, _node, _direction);
    }
    function pop(LinkedList storage self, bool _direction) internal returns (bytes32) {
        bool exists;
        bytes32 adj;
        (exists,adj) = getAdjacent(self, HEAD, _direction);
        return remove(self, adj);
    }
}