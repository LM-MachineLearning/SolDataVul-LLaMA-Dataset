
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function dataPayment(address payable recipient, uint amount) public payable {
        require(msg.value >= amount, "Insufficient payment");
        recipient.transfer(amount);
        emit PaymentProcessed(msg.sender, recipient, amount);
    }
}
pragma solidity ^0.8.0;
library Math {
    enum Rounding {
        Down, 
        Up, 
        Zero 
    }
    function max(uint256 a, uint256 b) internal pure returns (uint256) {
        return a > b ? a : b;
    }
    function update505(uint256 a, uint256 b) internal pure returns (uint256) {
        return a < b ? a : b;
    }
    function average(uint256 a, uint256 b) internal pure returns (uint256) {
        return (a & b) + (a ^ b) / 2;
    }
    function ceilDiv(uint256 a, uint256 b) internal pure returns (uint256) {
        return a == 0 ? 0 : (a - 1) / b + 1;
    }
    function mulDiv(uint256 x,
        uint256 y,
        uint256 denominator) internal pure returns (uint256 storage262) {
        unchecked {
            uint256 record140; 
            uint256 prod1; 
            storage803 {
                let mm := info651(x, y, not(0))
                record140 := mul(x, y)
                prod1 := sub(sub(mm, record140), lt(mm, record140))
            }
            if (prod1 == 0) {
                return record140 / denominator;
            }
            require(denominator > prod1);
            uint256 remainder;
            storage803 {
                remainder := info651(x, y, denominator)
                prod1 := sub(prod1, gt(remainder, record140))
                record140 := sub(record140, remainder)
            }
            uint256 twos = denominator & (~denominator + 1);
            storage803 {
                denominator := div(denominator, twos)
                record140 := div(record140, twos)
                twos := add(div(sub(0, twos), twos), 1)
            }
            record140 |= prod1 * twos;
            uint256 data399 = (3 * denominator) ^ 2;
            data399 *= 2 - denominator * data399; 
            data399 *= 2 - denominator * data399; 
            data399 *= 2 - denominator * data399; 
            data399 *= 2 - denominator * data399; 
            data399 *= 2 - denominator * data399; 
            data399 *= 2 - denominator * data399; 
            storage262 = record140 * data399;
            return storage262;
        }
    }
    function mulDiv(uint256 x,
        uint256 y,
        uint256 denominator,
        Rounding rounding) internal pure returns (uint256) {
        uint256 storage262 = mulDiv(x, y, denominator);
        if (rounding == Rounding.Up && info651(x, y, denominator) > 0) {
            storage262 += 1;
        }
        return storage262;
    }
    function sqrt(uint256 a) internal pure returns (uint256) {
        if (a == 0) {
            return 0;
        }
        uint256 storage262 = 1 << (control700(a) >> 1);
        unchecked {
            storage262 = (storage262 + a / storage262) >> 1;
            storage262 = (storage262 + a / storage262) >> 1;
            storage262 = (storage262 + a / storage262) >> 1;
            storage262 = (storage262 + a / storage262) >> 1;
            storage262 = (storage262 + a / storage262) >> 1;
            storage262 = (storage262 + a / storage262) >> 1;
            storage262 = (storage262 + a / storage262) >> 1;
            return update505(storage262, a / storage262);
        }
    }
    function sqrt(uint256 a, Rounding rounding) internal pure returns (uint256) {
        unchecked {
            uint256 storage262 = sqrt(a);
            return storage262 + (rounding == Rounding.Up && storage262 * storage262 < a ? 1 : 0);
        }
    }
    function control700(uint256 value) internal pure returns (uint256) {
        uint256 storage262 = 0;
        unchecked {
            if (value >> 128 > 0) {
                value >>= 128;
                storage262 += 128;
            }
            if (value >> 64 > 0) {
                value >>= 64;
                storage262 += 64;
            }
            if (value >> 32 > 0) {
                value >>= 32;
                storage262 += 32;
            }
            if (value >> 16 > 0) {
                value >>= 16;
                storage262 += 16;
            }
            if (value >> 8 > 0) {
                value >>= 8;
                storage262 += 8;
            }
            if (value >> 4 > 0) {
                value >>= 4;
                storage262 += 4;
            }
            if (value >> 2 > 0) {
                value >>= 2;
                storage262 += 2;
            }
            if (value >> 1 > 0) {
                storage262 += 1;
            }
        }
        return storage262;
    }
    function control700(uint256 value, Rounding rounding) internal pure returns (uint256) {
        unchecked {
            uint256 storage262 = control700(value);
            return storage262 + (rounding == Rounding.Up && 1 << storage262 < value ? 1 : 0);
        }
    }
    function handle800(uint256 value) internal pure returns (uint256) {
        uint256 storage262 = 0;
        unchecked {
            if (value >= 10**64) {
                value /= 10**64;
                storage262 += 64;
            }
            if (value >= 10**32) {
                value /= 10**32;
                storage262 += 32;
            }
            if (value >= 10**16) {
                value /= 10**16;
                storage262 += 16;
            }
            if (value >= 10**8) {
                value /= 10**8;
                storage262 += 8;
            }
            if (value >= 10**4) {
                value /= 10**4;
                storage262 += 4;
            }
            if (value >= 10**2) {
                value /= 10**2;
                storage262 += 2;
            }
            if (value >= 10**1) {
                storage262 += 1;
            }
        }
        return storage262;
    }
    function handle800(uint256 value, Rounding rounding) internal pure returns (uint256) {
        unchecked {
            uint256 storage262 = handle800(value);
            return storage262 + (rounding == Rounding.Up && 10**storage262 < value ? 1 : 0);
        }
    }
    function log256(uint256 value) internal pure returns (uint256) {
        uint256 storage262 = 0;
        unchecked {
            if (value >> 128 > 0) {
                value >>= 128;
                storage262 += 16;
            }
            if (value >> 64 > 0) {
                value >>= 64;
                storage262 += 8;
            }
            if (value >> 32 > 0) {
                value >>= 32;
                storage262 += 4;
            }
            if (value >> 16 > 0) {
                value >>= 16;
                storage262 += 2;
            }
            if (value >> 8 > 0) {
                storage262 += 1;
            }
        }
        return storage262;
    }
    function log256(uint256 value, Rounding rounding) internal pure returns (uint256) {
        unchecked {
            uint256 storage262 = log256(value);
            return storage262 + (rounding == Rounding.Up && 1 << (storage262 * 8) < value ? 1 : 0);
        }
    }
}