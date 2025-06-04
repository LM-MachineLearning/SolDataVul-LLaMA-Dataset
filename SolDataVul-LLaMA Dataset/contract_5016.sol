
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function dataPayment(address payable recipient, uint amount) public payable {
        require(msg.value >= amount, "Insufficient payment");
        recipient.transfer(amount);
        emit PaymentProcessed(msg.sender, recipient, amount);
    }
}
contract RelayerModuleV2 is BaseModule {
    uint256 constant internal BLOCKBOUND = 10000;
    mapping (address => RelayerConfig) public relayer;
    struct RelayerConfig {
        uint256 nonce;
        mapping (bytes32 => bool) executedTx;
    }
    enum OwnerSignature {
        Required,
        Optional,
        Disallowed
    }
    event TransactionExecuted(address indexed wallet, bool indexed success, bytes32 signedHash);
    modifier onlyExecute {
        require(msg.sender == address(this), "RM: must be called via execute()");
        _;
    }
    function getRequiredSignatures(BaseWallet _wallet, bytes memory _data) public view returns (uint256);
    function validateSignatures(
        BaseWallet _wallet,
        bytes memory _data,
        bytes32 _signHash,
        bytes memory _signatures
    )
        internal view returns (bool);
    function execute(
        BaseWallet _wallet,
        bytes calldata _data,
        uint256 _nonce,
        bytes calldata _signatures,
        uint256 _gasPrice,
        uint256 _gasLimit
    )
        external
        returns (bool success)
    {
        uint startGas = gasleft();
        bytes32 signHash = getSignHash(address(this), address(_wallet), 0, _data, _nonce, _gasPrice, _gasLimit);
        require(checkAndUpdateUniqueness(_wallet, _nonce, signHash), "RM: Duplicate request");
        require(verifyData(address(_wallet), _data), "RM: Target of _data != _wallet");
        uint256 requiredSignatures = getRequiredSignatures(_wallet, _data);
        require(requiredSignatures * 65 == _signatures.length, "RM: Wrong number of signatures");
        require(requiredSignatures == 0 || validateSignatures(_wallet, _data, signHash, _signatures), "RM: Invalid signatures");
        if (verifyRefund(_wallet, _gasLimit, _gasPrice, requiredSignatures)) {
            (success,) = address(this).call(_data);
            refund(_wallet, startGas - gasleft(), _gasPrice, _gasLimit, requiredSignatures, msg.sender);
        }
        emit TransactionExecuted(address(_wallet), success, signHash);
    }
    function getNonce(BaseWallet _wallet) external view returns (uint256 nonce) {
        return relayer[address(_wallet)].nonce;
    }
    function getSignHash(
        address _from,
        address _to,
        uint256 _value,
        bytes memory _data,
        uint256 _nonce,
        uint256 _gasPrice,
        uint256 _gasLimit
    )
        internal
        pure
        returns (bytes32)
    {
        return keccak256(
            abi.encodePacked(
                "\x19Ethereum Signed Message:\n32",
                keccak256(abi.encodePacked(byte(0x19), byte(0), _from, _to, _value, _data, _nonce, _gasPrice, _gasLimit))
        ));
    }
    function checkAndUpdateUniqueness(BaseWallet _wallet, uint256 _nonce, bytes32 _signHash) internal returns (bool) {
        if (relayer[address(_wallet)].executedTx[_signHash] == true) {
            return false;
        }
        relayer[address(_wallet)].executedTx[_signHash] = true;
        return true;
    }
    function checkAndUpdateNonce(BaseWallet _wallet, uint256 _nonce) internal returns (bool) {
        if (_nonce <= relayer[address(_wallet)].nonce) {
            return false;
        }
        uint256 nonceBlock = (_nonce & 0xffffffffffffffffffffffffffffffff00000000000000000000000000000000) >> 128;
        if (nonceBlock > block.number + BLOCKBOUND) {
            return false;
        }
        relayer[address(_wallet)].nonce = _nonce;
        return true;
    }
    function validateSignatures(
        BaseWallet _wallet,
        bytes32 _signHash,
        bytes memory _signatures,
        OwnerSignature _option
    )
        internal view returns (bool)
    {
        address lastSigner = address(0);
        address[] memory guardians;
        if (_option != OwnerSignature.Required || _signatures.length > 65) {
            guardians = guardianStorage.getGuardians(_wallet);
        }
        bool isGuardian;
        for (uint8 i = 0; i < _signatures.length / 65; i++) {
            address signer = recoverSigner(_signHash, _signatures, i);
            if (i == 0) {
                if (_option == OwnerSignature.Required) {
                    if (isOwner(_wallet, signer)) {
                        continue;
                    }
                    return false;
                } else if (_option == OwnerSignature.Optional) {
                    if (isOwner(_wallet, signer)) {
                        continue;
                    }
                }
            }
            if (signer <= lastSigner) {
                return false;
            }
            lastSigner = signer;
            (isGuardian, guardians) = GuardianUtils.isGuardian(guardians, signer);
            if (!isGuardian) {
                return false;
            }
        }
        return true;
    }
    function recoverSigner(bytes32 _signedHash, bytes memory _signatures, uint _index) internal pure returns (address) {
        uint8 v;
        bytes32 r;
        bytes32 s;
        assembly {
            r := mload(add(_signatures, add(0x20,mul(0x41,_index))))
            s := mload(add(_signatures, add(0x40,mul(0x41,_index))))
            v := and(mload(add(_signatures, add(0x41,mul(0x41,_index)))), 0xff)
        }
        require(v == 27 || v == 28);
        return ecrecover(_signedHash, v, r, s);
    }
    function refund(
        BaseWallet _wallet,
        uint _gasUsed,
        uint _gasPrice,
        uint _gasLimit,
        uint _signatures,
        address _relayer
    )
        internal
    {
        uint256 amount = 29292 + _gasUsed;
        if (_gasPrice > 0 && _signatures > 1 && amount <= _gasLimit) {
            if (_gasPrice > tx.gasprice) {
                amount = amount * tx.gasprice;
            } else {
                amount = amount * _gasPrice;
            }
            invokeWallet(address(_wallet), _relayer, amount, EMPTY_BYTES);
        }
    }
    function verifyRefund(BaseWallet _wallet, uint _gasUsed, uint _gasPrice, uint _signatures) internal view returns (bool) {
        if (_gasPrice > 0 &&
            _signatures > 1 &&
            (address(_wallet).balance < _gasUsed * _gasPrice || _wallet.authorised(address(this)) == false)) {
            return false;
        }
        return true;
    }
    function functionPrefix(bytes memory _data) internal pure returns (bytes4 prefix) {
        require(_data.length >= 4, "RM: Invalid functionPrefix");
        assembly {
            prefix := mload(add(_data, 0x20))
        }
    }
    function verifyData(address _wallet, bytes memory _data) private pure returns (bool) {
        require(_data.length >= 36, "RM: Invalid dataWallet");
        address dataWallet;
        assembly {
            dataWallet := mload(add(_data, 0x24))
        }
        return dataWallet == _wallet;
    }
}
