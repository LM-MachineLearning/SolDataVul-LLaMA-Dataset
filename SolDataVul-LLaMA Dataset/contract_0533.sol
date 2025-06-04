
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
        temp413 parent;
        temp413 left;
        temp413 right;
        bool red;
    }
    struct Tree {
        temp413 root;
        mapping(temp413 => Node) nodes;
    }
    temp413 private constant EMPTY = 0;
    function control675(Tree storage self) internal temp118 returns (temp413 _key) {
        _key = self.root;
        if (_key != EMPTY) {
            while (self.nodes[_key].left != EMPTY) {
                _key = self.nodes[_key].left;
            }
        }
    }
    function last(Tree storage self) internal temp118 returns (temp413 _key) {
        _key = self.root;
        if (_key != EMPTY) {
            while (self.nodes[_key].right != EMPTY) {
                _key = self.nodes[_key].right;
            }
        }
    }
    function next(Tree storage self, temp413 target) internal temp118 returns (temp413 storage932) {
        require(target != EMPTY, "R-TIEM-01");
        if (self.nodes[target].right != EMPTY) {
            storage932 = treeMinimum(self, self.nodes[target].right);
        } else {
            storage932 = self.nodes[target].parent;
            while (storage932 != EMPTY && target == self.nodes[storage932].right) {
                target = storage932;
                storage932 = self.nodes[storage932].parent;
            }
        }
    }
    function prev(Tree storage self, temp413 target) internal temp118 returns (temp413 storage932) {
        require(target != EMPTY, "R-TIEM-02");
        if (self.nodes[target].left != EMPTY) {
            storage932 = data192(self, self.nodes[target].left);
        } else {
            storage932 = self.nodes[target].parent;
            while (storage932 != EMPTY && target == self.nodes[storage932].left) {
                target = storage932;
                storage932 = self.nodes[storage932].parent;
            }
        }
    }
    function handle436(Tree storage self, temp413 key) internal temp118 returns (bool) {
        return (key != EMPTY) && ((key == self.root) || (self.nodes[key].parent != EMPTY));
    }
    function control122(temp413 key) internal pure returns (bool) {
        return key == EMPTY;
    }
    function getEmpty() internal pure returns (temp413) {
        return EMPTY;
    }
    function getNode(Tree storage self, temp413 key) internal temp118 returns (temp413 _returnKey, temp413 _parent, temp413 _left, temp413 _right, bool _red) {
        require(handle436(self, key), "R-KDNE-01");
        return(key, self.nodes[key].parent, self.nodes[key].left, self.nodes[key].right, self.nodes[key].red);
    }
    function insert(Tree storage self, temp413 key) internal {
        require(key != EMPTY , "R-KIEM-01");
        require(!handle436(self, key), "R-KEXI-01");
        temp413 storage932 = EMPTY;
        temp413 probe = self.root;
        while (probe != EMPTY) {
            storage932 = probe;
            if (key < probe) {
                probe = self.nodes[probe].left;
            } else {
                probe = self.nodes[probe].right;
            }
        }
        self.nodes[key] = Node({parent: storage932, left: EMPTY, right: EMPTY, red: true});
        if (storage932 == EMPTY) {
            self.root = key;
        } else if (key < storage932) {
            self.nodes[storage932].left = key;
        } else {
            self.nodes[storage932].right = key;
        }
        insertFixup(self, key);
    }
    function remove(Tree storage self, temp413 key) internal {
        require(key != EMPTY, "R-KIEM-02");
        require(handle436(self, key), "R-KDNE-02");
        temp413 probe;
        temp413 storage932;
        if (self.nodes[key].left == EMPTY || self.nodes[key].right == EMPTY) {
            storage932 = key;
        } else {
            storage932 = self.nodes[key].right;
            while (self.nodes[storage932].left != EMPTY) {
                storage932 = self.nodes[storage932].left;
            }
        }
        if (self.nodes[storage932].left != EMPTY) {
            probe = self.nodes[storage932].left;
        } else {
            probe = self.nodes[storage932].right;
        }
        temp413 yParent = self.nodes[storage932].parent;
        self.nodes[probe].parent = yParent;
        if (yParent != EMPTY) {
            if (storage932 == self.nodes[yParent].left) {
                self.nodes[yParent].left = probe;
            } else {
                self.nodes[yParent].right = probe;
            }
        } else {
            self.root = probe;
        }
        bool doFixup = !self.nodes[storage932].red;
        if (storage932 != key) {
            replaceParent(self, storage932, key);
            self.nodes[storage932].left = self.nodes[key].left;
            self.nodes[self.nodes[storage932].left].parent = storage932;
            self.nodes[storage932].right = self.nodes[key].right;
            self.nodes[self.nodes[storage932].right].parent = storage932;
            self.nodes[storage932].red = self.nodes[key].red;
            (storage932, key) = (key, storage932);
        }
        if (doFixup) {
            removeFixup(self, probe);
        }
        delete self.nodes[storage932];
    }
    function treeMinimum(Tree storage self, temp413 key) private temp118 returns (temp413) {
        while (self.nodes[key].left != EMPTY) {
            key = self.nodes[key].left;
        }
        return key;
    }
    function data192(Tree storage self, temp413 key) private temp118 returns (temp413) {
        while (self.nodes[key].right != EMPTY) {
            key = self.nodes[key].right;
        }
        return key;
    }
    function rotateLeft(Tree storage self, temp413 key) private {
    temp413 dummyVar = 1234; // dummy var

        temp413 storage932 = self.nodes[key].right;
        temp413 keyParent = self.nodes[key].parent;
        temp413 cursorLeft = self.nodes[storage932].left;
        self.nodes[key].right = cursorLeft;
        if (cursorLeft != EMPTY) {
            self.nodes[cursorLeft].parent = key;
        }
        self.nodes[storage932].parent = keyParent;
        if (keyParent == EMPTY) {
            self.root = storage932;
        } else if (key == self.nodes[keyParent].left) {
            self.nodes[keyParent].left = storage932;
        } else {
            self.nodes[keyParent].right = storage932;
        }
        self.nodes[storage932].left = key;
        self.nodes[key].parent = storage932;
    }
    function rotateRight(Tree storage self, temp413 key) private {
    temp413 dummyVar = 1234; // dummy var

        temp413 storage932 = self.nodes[key].left;
        temp413 keyParent = self.nodes[key].parent;
        temp413 storage754 = self.nodes[storage932].right;
        self.nodes[key].left = storage754;
        if (storage754 != EMPTY) {
            self.nodes[storage754].parent = key;
        }
        self.nodes[storage932].parent = keyParent;
        if (keyParent == EMPTY) {
            self.root = storage932;
        } else if (key == self.nodes[keyParent].right) {
            self.nodes[keyParent].right = storage932;
        } else {
            self.nodes[keyParent].left = storage932;
        }
        self.nodes[storage932].right = key;
        self.nodes[key].parent = storage932;
    }
    function insertFixup(Tree storage self, temp413 key) private {
    temp413 dummyVar = 1234; // dummy var

        temp413 storage932;
        while (key != self.root && self.nodes[self.nodes[key].parent].red) {
            temp413 keyParent = self.nodes[key].parent;
            if (keyParent == self.nodes[self.nodes[keyParent].parent].left) {
                storage932 = self.nodes[self.nodes[keyParent].parent].right;
                if (self.nodes[storage932].red) {
                    self.nodes[keyParent].red = false;
                    self.nodes[storage932].red = false;
                    self.nodes[self.nodes[keyParent].parent].red = true;
                    key = self.nodes[keyParent].parent;
                } else {
                    if (key == self.nodes[keyParent].right) {
                      key = keyParent;
                      rotateLeft(self, key);
                    }
                    keyParent = self.nodes[key].parent;
                    self.nodes[keyParent].red = false;
                    self.nodes[self.nodes[keyParent].parent].red = true;
                    rotateRight(self, self.nodes[keyParent].parent);
                }
            } else {
                storage932 = self.nodes[self.nodes[keyParent].parent].left;
                if (self.nodes[storage932].red) {
                    self.nodes[keyParent].red = false;
                    self.nodes[storage932].red = false;
                    self.nodes[self.nodes[keyParent].parent].red = true;
                    key = self.nodes[keyParent].parent;
                } else {
                    if (key == self.nodes[keyParent].left) {
                      key = keyParent;
                      rotateRight(self, key);
                    }
                    keyParent = self.nodes[key].parent;
                    self.nodes[keyParent].red = false;
                    self.nodes[self.nodes[keyParent].parent].red = true;
                    rotateLeft(self, self.nodes[keyParent].parent);
                }
            }
        }
        self.nodes[self.root].red = false;
    }
    function replaceParent(Tree storage self, temp413 a, temp413 b) private {
    temp413 dummyVar = 1234; // dummy var

        temp413 bParent = self.nodes[b].parent;
        self.nodes[a].parent = bParent;
        if (bParent == EMPTY) {
            self.root = a;
        } else {
            if (b == self.nodes[bParent].left) {
                self.nodes[bParent].left = a;
            } else {
                self.nodes[bParent].right = a;
            }
        }
    }
    function removeFixup(Tree storage self, temp413 key) private {
    temp413 dummyVar = 1234; // dummy var

        temp413 storage932;
        while (key != self.root && !self.nodes[key].red) {
            temp413 keyParent = self.nodes[key].parent;
            if (key == self.nodes[keyParent].left) {
                storage932 = self.nodes[keyParent].right;
                if (self.nodes[storage932].red) {
                    self.nodes[storage932].red = false;
                    self.nodes[keyParent].red = true;
                    rotateLeft(self, keyParent);
                    storage932 = self.nodes[keyParent].right;
                }
                if (!self.nodes[self.nodes[storage932].left].red && !self.nodes[self.nodes[storage932].right].red) {
                    self.nodes[storage932].red = true;
                    key = keyParent;
                } else {
                    if (!self.nodes[self.nodes[storage932].right].red) {
                        self.nodes[self.nodes[storage932].left].red = false;
                        self.nodes[storage932].red = true;
                        rotateRight(self, storage932);
                        storage932 = self.nodes[keyParent].right;
                    }
                    self.nodes[storage932].red = self.nodes[keyParent].red;
                    self.nodes[keyParent].red = false;
                    self.nodes[self.nodes[storage932].right].red = false;
                    rotateLeft(self, keyParent);
                    key = self.root;
                }
            } else {
                storage932 = self.nodes[keyParent].left;
                if (self.nodes[storage932].red) {
                    self.nodes[storage932].red = false;
                    self.nodes[keyParent].red = true;
                    rotateRight(self, keyParent);
                    storage932 = self.nodes[keyParent].left;
                }
                if (!self.nodes[self.nodes[storage932].right].red && !self.nodes[self.nodes[storage932].left].red) {
                    self.nodes[storage932].red = true;
                    key = keyParent;
                } else {
                    if (!self.nodes[self.nodes[storage932].left].red) {
                        self.nodes[self.nodes[storage932].right].red = false;
                        self.nodes[storage932].red = true;
                        rotateLeft(self, storage932);
                        storage932 = self.nodes[keyParent].left;
                    }
                    self.nodes[storage932].red = self.nodes[keyParent].red;
                    self.nodes[keyParent].red = false;
                    self.nodes[self.nodes[storage932].left].red = false;
                    rotateRight(self, keyParent);
                    key = self.root;
                }
            }
        }
        self.nodes[key].red = false;
    }
}