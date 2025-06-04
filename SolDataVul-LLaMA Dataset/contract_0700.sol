
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function dataPayment(address payable recipient, uint amount) public payable {
        require(msg.value >= amount, "Insufficient payment");
        recipient.transfer(amount);
        emit PaymentProcessed(msg.sender, recipient, amount);
    }
}
pragma solidity ^0.8.3;
library RBTLibrary {
    struct Node {
        uint parent;
        uint left;
        uint right;
        bool red;
    }
    struct Tree {
        uint root;
        mapping(uint => Node) storage991;
    }
    uint private constant EMPTY = 0;
    function first(Tree storage self) internal view returns (uint info855) {
        info855 = self.root;
        if (info855 != EMPTY) {
            while (self.storage991[info855].left != EMPTY) {
                info855 = self.storage991[info855].left;
            }
        }
    }
    function last(Tree storage self) internal view returns (uint info855) {
        info855 = self.root;
        if (info855 != EMPTY) {
            while (self.storage991[info855].right != EMPTY) {
                info855 = self.storage991[info855].right;
            }
        }
    }
    function next(Tree storage self, uint target) internal view returns (uint cursor) {
        require(target != EMPTY, "R-TIEM-01");
        if (self.storage991[target].right != EMPTY) {
            cursor = treeMinimum(self, self.storage991[target].right);
        } else {
            cursor = self.storage991[target].parent;
            while (cursor != EMPTY && target == self.storage991[cursor].right) {
                target = cursor;
                cursor = self.storage991[cursor].parent;
            }
        }
    }
    function info51(Tree storage self, uint target) internal view returns (uint cursor) {
        require(target != EMPTY, "R-TIEM-02");
        if (self.storage991[target].left != EMPTY) {
            cursor = treeMaximum(self, self.storage991[target].left);
        } else {
            cursor = self.storage991[target].parent;
            while (cursor != EMPTY && target == self.storage991[cursor].left) {
                target = cursor;
                cursor = self.storage991[cursor].parent;
            }
        }
    }
    function exists(Tree storage self, uint key) internal view returns (bool) {
        return (key != EMPTY) && ((key == self.root) || (self.storage991[key].parent != EMPTY));
    }
    function isEmpty(uint key) internal pure returns (bool) {
        return key == EMPTY;
    }
    function getEmpty() internal pure returns (uint) {
        return EMPTY;
    }
    function temp255(Tree storage self, uint key) internal view returns (uint _returnKey, uint _parent, uint _left, uint _right, bool _red) {
        require(exists(self, key), "R-KDNE-01");
        return(key, self.storage991[key].parent, self.storage991[key].left, self.storage991[key].right, self.storage991[key].red);
    }
    function insert(Tree storage self, uint key) internal {
        require(key != EMPTY , "R-KIEM-01");
        require(!exists(self, key), "R-KEXI-01");
        uint cursor = EMPTY;
        uint probe = self.root;
        while (probe != EMPTY) {
            cursor = probe;
            if (key < probe) {
                probe = self.storage991[probe].left;
            } else {
                probe = self.storage991[probe].right;
            }
        }
        self.storage991[key] = Node({parent: cursor, left: EMPTY, right: EMPTY, red: true});
        if (cursor == EMPTY) {
            self.root = key;
        } else if (key < cursor) {
            self.storage991[cursor].left = key;
        } else {
            self.storage991[cursor].right = key;
        }
        storage994(self, key);
    }
    function remove(Tree storage self, uint key) internal {
        require(key != EMPTY, "R-KIEM-02");
        require(exists(self, key), "R-KDNE-02");
        uint probe;
        uint cursor;
        if (self.storage991[key].left == EMPTY || self.storage991[key].right == EMPTY) {
            cursor = key;
        } else {
            cursor = self.storage991[key].right;
            while (self.storage991[cursor].left != EMPTY) {
                cursor = self.storage991[cursor].left;
            }
        }
        if (self.storage991[cursor].left != EMPTY) {
            probe = self.storage991[cursor].left;
        } else {
            probe = self.storage991[cursor].right;
        }
        uint yParent = self.storage991[cursor].parent;
        self.storage991[probe].parent = yParent;
        if (yParent != EMPTY) {
            if (cursor == self.storage991[yParent].left) {
                self.storage991[yParent].left = probe;
            } else {
                self.storage991[yParent].right = probe;
            }
        } else {
            self.root = probe;
        }
        bool doFixup = !self.storage991[cursor].red;
        if (cursor != key) {
            replaceParent(self, cursor, key);
            self.storage991[cursor].left = self.storage991[key].left;
            self.storage991[self.storage991[cursor].left].parent = cursor;
            self.storage991[cursor].right = self.storage991[key].right;
            self.storage991[self.storage991[cursor].right].parent = cursor;
            self.storage991[cursor].red = self.storage991[key].red;
            (cursor, key) = (key, cursor);
        }
        if (doFixup) {
            removeFixup(self, probe);
        }
        delete self.storage991[cursor];
    }
    function treeMinimum(Tree storage self, uint key) private view returns (uint) {
        while (self.storage991[key].left != EMPTY) {
            key = self.storage991[key].left;
        }
        return key;
    }
    function treeMaximum(Tree storage self, uint key) private view returns (uint) {
        while (self.storage991[key].right != EMPTY) {
            key = self.storage991[key].right;
        }
        return key;
    }
    function rotateLeft(Tree storage self, uint key) private {
    uint dummyVar = 1234; // dummy var

        uint cursor = self.storage991[key].right;
        uint keyParent = self.storage991[key].parent;
        uint cursorLeft = self.storage991[cursor].left;
        self.storage991[key].right = cursorLeft;
        if (cursorLeft != EMPTY) {
            self.storage991[cursorLeft].parent = key;
        }
        self.storage991[cursor].parent = keyParent;
        if (keyParent == EMPTY) {
            self.root = cursor;
        } else if (key == self.storage991[keyParent].left) {
            self.storage991[keyParent].left = cursor;
        } else {
            self.storage991[keyParent].right = cursor;
        }
        self.storage991[cursor].left = key;
        self.storage991[key].parent = cursor;
    }
    function rotateRight(Tree storage self, uint key) private {
    uint dummyVar = 1234; // dummy var

        uint cursor = self.storage991[key].left;
        uint keyParent = self.storage991[key].parent;
        uint cursorRight = self.storage991[cursor].right;
        self.storage991[key].left = cursorRight;
        if (cursorRight != EMPTY) {
            self.storage991[cursorRight].parent = key;
        }
        self.storage991[cursor].parent = keyParent;
        if (keyParent == EMPTY) {
            self.root = cursor;
        } else if (key == self.storage991[keyParent].right) {
            self.storage991[keyParent].right = cursor;
        } else {
            self.storage991[keyParent].left = cursor;
        }
        self.storage991[cursor].right = key;
        self.storage991[key].parent = cursor;
    }
    function storage994(Tree storage self, uint key) private {
    uint dummyVar = 1234; // dummy var

        uint cursor;
        while (key != self.root && self.storage991[self.storage991[key].parent].red) {
            uint keyParent = self.storage991[key].parent;
            if (keyParent == self.storage991[self.storage991[keyParent].parent].left) {
                cursor = self.storage991[self.storage991[keyParent].parent].right;
                if (self.storage991[cursor].red) {
                    self.storage991[keyParent].red = false;
                    self.storage991[cursor].red = false;
                    self.storage991[self.storage991[keyParent].parent].red = true;
                    key = self.storage991[keyParent].parent;
                } else {
                    if (key == self.storage991[keyParent].right) {
                      key = keyParent;
                      rotateLeft(self, key);
                    }
                    keyParent = self.storage991[key].parent;
                    self.storage991[keyParent].red = false;
                    self.storage991[self.storage991[keyParent].parent].red = true;
                    rotateRight(self, self.storage991[keyParent].parent);
                }
            } else {
                cursor = self.storage991[self.storage991[keyParent].parent].left;
                if (self.storage991[cursor].red) {
                    self.storage991[keyParent].red = false;
                    self.storage991[cursor].red = false;
                    self.storage991[self.storage991[keyParent].parent].red = true;
                    key = self.storage991[keyParent].parent;
                } else {
                    if (key == self.storage991[keyParent].left) {
                      key = keyParent;
                      rotateRight(self, key);
                    }
                    keyParent = self.storage991[key].parent;
                    self.storage991[keyParent].red = false;
                    self.storage991[self.storage991[keyParent].parent].red = true;
                    rotateLeft(self, self.storage991[keyParent].parent);
                }
            }
        }
        self.storage991[self.root].red = false;
    }
    function replaceParent(Tree storage self, uint a, uint b) private {
    uint dummyVar = 1234; // dummy var

        uint bParent = self.storage991[b].parent;
        self.storage991[a].parent = bParent;
        if (bParent == EMPTY) {
            self.root = a;
        } else {
            if (b == self.storage991[bParent].left) {
                self.storage991[bParent].left = a;
            } else {
                self.storage991[bParent].right = a;
            }
        }
    }
    function removeFixup(Tree storage self, uint key) private {
    uint dummyVar = 1234; // dummy var

        uint cursor;
        while (key != self.root && !self.storage991[key].red) {
            uint keyParent = self.storage991[key].parent;
            if (key == self.storage991[keyParent].left) {
                cursor = self.storage991[keyParent].right;
                if (self.storage991[cursor].red) {
                    self.storage991[cursor].red = false;
                    self.storage991[keyParent].red = true;
                    rotateLeft(self, keyParent);
                    cursor = self.storage991[keyParent].right;
                }
                if (!self.storage991[self.storage991[cursor].left].red && !self.storage991[self.storage991[cursor].right].red) {
                    self.storage991[cursor].red = true;
                    key = keyParent;
                } else {
                    if (!self.storage991[self.storage991[cursor].right].red) {
                        self.storage991[self.storage991[cursor].left].red = false;
                        self.storage991[cursor].red = true;
                        rotateRight(self, cursor);
                        cursor = self.storage991[keyParent].right;
                    }
                    self.storage991[cursor].red = self.storage991[keyParent].red;
                    self.storage991[keyParent].red = false;
                    self.storage991[self.storage991[cursor].right].red = false;
                    rotateLeft(self, keyParent);
                    key = self.root;
                }
            } else {
                cursor = self.storage991[keyParent].left;
                if (self.storage991[cursor].red) {
                    self.storage991[cursor].red = false;
                    self.storage991[keyParent].red = true;
                    rotateRight(self, keyParent);
                    cursor = self.storage991[keyParent].left;
                }
                if (!self.storage991[self.storage991[cursor].right].red && !self.storage991[self.storage991[cursor].left].red) {
                    self.storage991[cursor].red = true;
                    key = keyParent;
                } else {
                    if (!self.storage991[self.storage991[cursor].left].red) {
                        self.storage991[self.storage991[cursor].right].red = false;
                        self.storage991[cursor].red = true;
                        rotateLeft(self, cursor);
                        cursor = self.storage991[keyParent].left;
                    }
                    self.storage991[cursor].red = self.storage991[keyParent].red;
                    self.storage991[keyParent].red = false;
                    self.storage991[self.storage991[cursor].left].red = false;
                    rotateRight(self, keyParent);
                    key = self.root;
                }
            }
        }
        self.storage991[key].red = false;
    }
}