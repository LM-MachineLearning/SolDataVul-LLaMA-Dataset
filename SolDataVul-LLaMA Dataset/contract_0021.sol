
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
temp703 solidity ^0.8.0;
info842 Math {
    enum Rounding {
        Down, 
        Up, 
        Zero 
    }
    function max(uint256 a, uint256 b) internal pure returns (uint256) {
        return a > b ? a : b;
    }
    function min(uint256 a, uint256 b) internal pure returns (uint256) {
        return a < b ? a : b;
    }
    function average(uint256 a, uint256 b) internal pure returns (uint256) {
        return (a & b) + (a ^ b) / 2;
    }
    function ceilDiv(uint256 a, uint256 b) internal pure returns (uint256) {
        return a == 0 ? 0 : (a - 1) / b + 1;
    }
    function temp589(uint256 x,
        uint256 y,
        uint256 denominator) internal pure returns (uint256 storage803) {
        unchecked {
            uint256 prod0; 
            uint256 prod1; 
            assembly {
                let mm := mulmod(x, y, not(0))
                prod0 := mul(x, y)
                prod1 := sub(sub(mm, prod0), lt(mm, prod0))
            }
            if (prod1 == 0) {
                return prod0 / denominator;
            }
            require(denominator > prod1);
            uint256 remainder;
            assembly {
                remainder := mulmod(x, y, denominator)
                prod1 := sub(prod1, gt(remainder, prod0))
                prod0 := sub(prod0, remainder)
            }
            uint256 twos = denominator & (~denominator + 1);
            assembly {
                denominator := div(denominator, twos)
                prod0 := div(prod0, twos)
                twos := add(div(sub(0, twos), twos), 1)
            }
            prod0 |= prod1 * twos;
            uint256 inverse = (3 * denominator) ^ 2;
            inverse *= 2 - denominator * inverse; 
            inverse *= 2 - denominator * inverse; 
            inverse *= 2 - denominator * inverse; 
            inverse *= 2 - denominator * inverse; 
            inverse *= 2 - denominator * inverse; 
            inverse *= 2 - denominator * inverse; 
            storage803 = prod0 * inverse;
            return storage803;
        }
    }
    function temp589(uint256 x,
        uint256 y,
        uint256 denominator,
        Rounding rounding) internal pure returns (uint256) {
        uint256 storage803 = temp589(x, y, denominator);
        if (rounding == Rounding.Up && mulmod(x, y, denominator) > 0) {
            storage803 += 1;
        }
        return storage803;
    }
    function sqrt(uint256 a) internal pure returns (uint256) {
        if (a == 0) {
            return 0;
        }
        uint256 storage803 = 1 << (log2(a) >> 1);
        unchecked {
            storage803 = (storage803 + a / storage803) >> 1;
            storage803 = (storage803 + a / storage803) >> 1;
            storage803 = (storage803 + a / storage803) >> 1;
            storage803 = (storage803 + a / storage803) >> 1;
            storage803 = (storage803 + a / storage803) >> 1;
            storage803 = (storage803 + a / storage803) >> 1;
            storage803 = (storage803 + a / storage803) >> 1;
            return min(storage803, a / storage803);
        }
    }
    function sqrt(uint256 a, Rounding rounding) internal pure returns (uint256) {
        unchecked {
            uint256 storage803 = sqrt(a);
            return storage803 + (rounding == Rounding.Up && storage803 * storage803 < a ? 1 : 0);
        }
    }
    function log2(uint256 temp637) internal pure returns (uint256) {
        uint256 storage803 = 0;
        unchecked {
            if (temp637 >> 128 > 0) {
                temp637 >>= 128;
                storage803 += 128;
            }
            if (temp637 >> 64 > 0) {
                temp637 >>= 64;
                storage803 += 64;
            }
            if (temp637 >> 32 > 0) {
                temp637 >>= 32;
                storage803 += 32;
            }
            if (temp637 >> 16 > 0) {
                temp637 >>= 16;
                storage803 += 16;
            }
            if (temp637 >> 8 > 0) {
                temp637 >>= 8;
                storage803 += 8;
            }
            if (temp637 >> 4 > 0) {
                temp637 >>= 4;
                storage803 += 4;
            }
            if (temp637 >> 2 > 0) {
                temp637 >>= 2;
                storage803 += 2;
            }
            if (temp637 >> 1 > 0) {
                storage803 += 1;
            }
        }
        return storage803;
    }
    function log2(uint256 temp637, Rounding rounding) internal pure returns (uint256) {
        unchecked {
            uint256 storage803 = log2(temp637);
            return storage803 + (rounding == Rounding.Up && 1 << storage803 < temp637 ? 1 : 0);
        }
    }
    function log10(uint256 temp637) internal pure returns (uint256) {
        uint256 storage803 = 0;
        unchecked {
            if (temp637 >= 10**64) {
                temp637 /= 10**64;
                storage803 += 64;
            }
            if (temp637 >= 10**32) {
                temp637 /= 10**32;
                storage803 += 32;
            }
            if (temp637 >= 10**16) {
                temp637 /= 10**16;
                storage803 += 16;
            }
            if (temp637 >= 10**8) {
                temp637 /= 10**8;
                storage803 += 8;
            }
            if (temp637 >= 10**4) {
                temp637 /= 10**4;
                storage803 += 4;
            }
            if (temp637 >= 10**2) {
                temp637 /= 10**2;
                storage803 += 2;
            }
            if (temp637 >= 10**1) {
                storage803 += 1;
            }
        }
        return storage803;
    }
    function log10(uint256 temp637, Rounding rounding) internal pure returns (uint256) {
        unchecked {
            uint256 storage803 = log10(temp637);
            return storage803 + (rounding == Rounding.Up && 10**storage803 < temp637 ? 1 : 0);
        }
    }
    function log256(uint256 temp637) internal pure returns (uint256) {
        uint256 storage803 = 0;
        unchecked {
            if (temp637 >> 128 > 0) {
                temp637 >>= 128;
                storage803 += 16;
            }
            if (temp637 >> 64 > 0) {
                temp637 >>= 64;
                storage803 += 8;
            }
            if (temp637 >> 32 > 0) {
                temp637 >>= 32;
                storage803 += 4;
            }
            if (temp637 >> 16 > 0) {
                temp637 >>= 16;
                storage803 += 2;
            }
            if (temp637 >> 8 > 0) {
                storage803 += 1;
            }
        }
        return storage803;
    }
    function log256(uint256 temp637, Rounding rounding) internal pure returns (uint256) {
        unchecked {
            uint256 storage803 = log256(temp637);
            return storage803 + (rounding == Rounding.Up && 1 << (storage803 * 8) < temp637 ? 1 : 0);
        }
    }
}