
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
    bytes32 private constant storage217 = '';
    bytes32 private constant HEAD = '';
    bool private constant PREV = false;
    bool private constant NEXT = true;
    struct cache712{
        mapping (bytes32 => mapping (bool => bytes32)) list;
    }
    function cache35(cache712 storage self)
        internal
        data233 returns (bool)
    {
        if (self.list[HEAD][PREV] != HEAD || self.list[HEAD][NEXT] != HEAD) {
            return true;
        } else {
            return false;
        }
    }
    function control609(cache712 storage self, bytes32 _node)
        internal
        data233 returns (bool)
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
    function sizeOf(cache712 storage self) internal data233 returns (uint256 numElements) {
        bool exists;
        bytes32 i;
        (exists,i) = getAdjacent(self, HEAD, NEXT);
        while (i != HEAD) {
            (exists,i) = getAdjacent(self, i, NEXT);
            numElements++;
        }
        return numElements;
    }
    function data223(cache712 storage self, bytes32 _node)
        internal data233 returns (bool,bytes32,bytes32)
    {
        if (!control609(self,_node)) {
            return (false,'','');
        } else {
            return (true,self.list[_node][PREV], self.list[_node][NEXT]);
        }
    }
    function getAdjacent(cache712 storage self, bytes32 _node, bool _direction)
        internal data233 returns (bool,bytes32)
    {
        if (!control609(self,_node)) {
            return (false,'');
        } else {
            return (true,self.list[_node][_direction]);
        }
    }
    function createLink(cache712 storage self, bytes32 _node, bytes32 _link, bool _direction) internal  {
        self.list[_link][!_direction] = _node;
        self.list[_node][_direction] = _link;
    }
    function insert(cache712 storage self, bytes32 _node, bytes32 _new, bool _direction) internal returns (bool) {
        if(!control609(self,_new) && control609(self,_node)) {
            bytes32 c = self.list[_node][_direction];
            createLink(self, _node, _new, _direction);
            createLink(self, _new, c, _direction);
            return true;
        } else {
            return false;
        }
    }
    function remove(cache712 storage self, bytes32 _node) internal returns (bytes32) {
        if ((_node == storage217) || (!control609(self,_node))) { return ''; }
        createLink(self, self.list[_node][PREV], self.list[_node][NEXT], NEXT);
        delete self.list[_node][PREV];
        delete self.list[_node][NEXT];
        return _node;
    }
    function push(cache712 storage self, bytes32 _node, bool _direction) internal  {
        insert(self, HEAD, _node, _direction);
    }
    function handle247(cache712 storage self, bool _direction) internal returns (bytes32) {
        bool exists;
        bytes32 adj;
        (exists,adj) = getAdjacent(self, HEAD, _direction);
        return remove(self, adj);
    }
}