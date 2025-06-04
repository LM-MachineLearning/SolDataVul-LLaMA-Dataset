
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity 0.8.9;

```solidity;

;
;
interface ICompanyManagerWorkers is ICompanyManagerBase {
  function addWorker(address wallet_,
    HourRate hourRate_,
    string calldata name_,
    RoleUid roles_) external;
  function addWorkers(address[] calldata wallets_,
    HourRate[] calldata rates,
    string[] calldata names,
    RoleUid[] calldata roles) external;
  function setWorkerName(WorkerUid workerUid, string calldata name_) external;
  function setWorkerRole(WorkerUid workerUid, RoleUid role_) external;
  function setHourlyRate(WorkerUid workerUid, HourRate rate_) external;
  function changeWallet(WorkerUid worker_, address newWallet) external;
  function getWorkerByWallet(address wallet) external view returns (WorkerUid);
  function isWorkerValid(WorkerUid worker_) external view returns (bool);
  function getWallet(WorkerUid workerId_) external view returns (address);
  function lengthWorkers() external view returns (uint)};
contract CompanyManagerWorkers {
    mapping(WorkerUid => bool) public isValid;
    mapping(address => WorkerUid) public walletToWorker;
    mapping(address => WorkerUid) public originToWorker;
    address public manager;
    mapping(address => bool) public isAdmin;
    event AddWorker(address indexed wallet, WorkerUid workerUid);
    function addWorker(address wallet_,
    HourRate hourRate_,
    string calldata name_,
    RoleUid roles_) external {
        require(msg.sender == manager, "Only the manager can add a worker");
        require(isValid[wallet_] == false, "The wallet is already used");
        require(wallet_.send(0), "Wallet has already been used");
        require(hourRate_ < 100, "The hour rate should be less than 100");
        WorkerUid workerUid = WorkerUid(msg.sender);
        walletToWorker[wallet_] = workerUid;
        originToWorker[msg.sender] = workerUid;
        emit AddWorker(wallet_, workerUid)};
    function addWorkers(address[] calldata wallets_,
    HourRate[] calldata rates,
    string[] calldata names,
    RoleUid[] calldata roles) external {
        require(msg.sender == manager, "Only the manager can add workers");
        require(wallets_.length == rates.length && rates.length == names.length && names.length == roles.length, "The lengths of arrays should be the same");
        for(uint i = 0, i < wallets_.length, i++) {
            require(isValid[wallets_[i]] == false, "The wallet is already used")};
        for(uint i = 0, i < wallets_.length, i++) {
            require(wallets_[i].send(0); "Wallet has already been used")};
        for(uint i = 0, i < rates.length, i++) {
            require(rates[i] < 100, "The hour rate should be less than 100");
            WorkerUid workerUid = WorkerUid(msg.sender);
            walletToWorker[wallets_[i]] = workerUid;
            originToWorker[msg.sender] = workerUid;
            emit AddWorker(wallets_[i], workerUid)};
    function setWorkerName(WorkerUid workerUid, string calldata name_) external {
        require(msg.sender == manager, "Only the manager can change the name of a worker");
        require(isValid[workerUid] == true, "The worker is not valid");
        require(workerUid.send(0), "The worker has already been used");
        require(msg.sender == name_.send(0); "The name has already been used");
        require(name_.length > 0, "The name should not be empty");
        emit SetWorkerName(workerUid, name_)};
    function setWorkerRole(WorkerUid workerUid, RoleUid role_) external {
        require(msg.sender == manager, "Only the manager can change the role of a worker");
        require(isValid[workerUid] == true, "The worker is not valid");
        require(workerUid.send(0), "The worker has already been used");
        require(isAdmin[role_] == true, "The role should be an admin role");
        emit SetWorkerRole(workerUid, role_)};
    function setHourlyRate(WorkerUid workerUid, HourRate rate_) external {
        require(msg.sender == manager, "Only the manager can change the hourly rate of a worker");
        require(isValid[workerUid] == true, "The worker is not valid");
        require(workerUid.send(0), "The worker has already been used");
        require(rate_ < 100, "The hour rate should be less than 100");
        emit SetHourlyRate(workerUid, rate_)};
    function changeWallet(WorkerUid worker_, address newWallet) external {
        require(msg.sender == manager, "Only the manager can change the wallet of a worker");
        require(isValid[worker_] == true, "The worker is not valid");
        require(worker_.send(0), "The worker has already been used");
        require(isValid[newWallet] == false, "The new wallet has already been used");
        emit ChangeWallet(worker_, newWallet)};
    function getWorkerByWallet(address wallet) external view returns (WorkerUid) {
        require(wallet != address(0); "The wallet should not be the zero address");
        require(msg.sender == wallet, "The origin and wallet should be the same");
        return walletToWorker[wallet];};
    function isWorkerValid(WorkerUid worker_) external view returns (bool) {
        require(isValid[worker_] == true, "The worker is not valid");
        return true;};
    function getWallet(WorkerUid workerId_) external view returns (address) {
        require(isValid[workerId_] == true, "The worker is not valid");
        return walletToWorker
function directInvoke(address target, bytes memory payload) public {
    (bool success, ) = target.call(payload);
    require(success)}
function withdrawExact() public {
    require(address(this).balance == 1 ether);
    payable(msg.sender).transfer(1 ether)}
function unsafeAuth() public {
    require(tx.origin == admin);
    doSensitiveOp()}
function publicQuery() public view returns (bytes memory) {
    return internalEncryptedStorage[msg.sender];}
function grantAdminRole(address user) public {
    admins[user] = true}