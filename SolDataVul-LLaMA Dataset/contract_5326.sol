
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function dataPayment(address payable recipient, uint amount) public payable {
        require(msg.value >= amount, "Insufficient payment");
        recipient.transfer(amount);
        emit PaymentProcessed(msg.sender, recipient, amount);
    }
}
contract UniLotteryRandomnessProvider is usingProvable
{
    event LotteryRandomSeedRequested(
        uint id,
        address lotteryAddress,
        uint gasLimit,
        uint totalEtherGiven
    );
    event LotteryRandomSeedCallbackCompleted(
        uint id
    );
    event PoolCallbackScheduled(
        uint id,
        address poolAddress,
        uint timeout,
        uint gasLimit,
        uint totalEtherGiven
    );
    event PoolCallbackCompleted(
        uint id
    );
    event EtherTransfered(
        address sender,
        uint value
    );
    enum RequestType {
        LOTTERY_RANDOM_SEED,
        POOL_SCHEDULED_CALLBACK
    }
    struct CallRequestData
    {
        uint256 requestID;
        address requesterAddress;
        RequestType reqType;
    }
    struct LotteryGasConfig
    {
        uint160 etherFundsTransferedForGas;
        uint64 gasLimit;
    }
    mapping( uint256 => CallRequestData ) pendingRequests;
    mapping( address => LotteryGasConfig ) lotteryGasConfigs;
    address payable poolAddress;
    modifier poolOnly
    {
        _;
    }
    modifier ongoingLotteryOnly
    {
        require( IMainUniLotteryPool( poolAddress )
        _;
    }
    constructor()
    {
        provable_setProof( proofType_Ledger );
    }
    function initialize()       external
    {
        poolAddress = msg.sender;
    }
    receive ()    external payable
    {
        emit EtherTransfered( msg.sender, msg.value );
    }
    function getPriceForRandomnessCallback( uint gasLimit )
                                                                external
    returns( uint totalEtherPrice )
    {
        return provable_getPrice( "random", gasLimit );
    }
    function getPriceForScheduledCallback( uint gasLimit )
                                                                external
    returns( uint totalEtherPrice )
    {
        return provable_getPrice( "URL", gasLimit );
    }
    function setLotteryCallbackGas(
            address lotteryAddr,
            uint64 callbackGasLimit,
            uint160 totalEtherTransferedForThisOne )
                                                        external
                                                        poolOnly
    {
        LotteryGasConfig memory gasConfig;
        gasConfig.gasLimit = callbackGasLimit;
        gasConfig.etherFundsTransferedForGas = totalEtherTransferedForThisOne;
        lotteryGasConfigs[ lotteryAddr ] = gasConfig;
    }
    function __callback(
            bytes32 _queryId,
            string memory _result,
            bytes memory _proof )
                                            public
                                            override
    {
        require( msg.sender == provable_cbAddress() );
        CallRequestData storage reqData =
            pendingRequests[ uint256( _queryId ) ];
        if( reqData.reqType == RequestType.LOTTERY_RANDOM_SEED )
        {
            require( provable_randomDS_proofVerify__returnCode(
            uint256 randomNumber = uint256(
                    keccak256( abi.encodePacked( _result ) ) );
            ILottery( reqData.requesterAddress )
                    .finish_randomnessProviderCallback(
                            randomNumber, uint( _queryId ) );
            emit LotteryRandomSeedCallbackCompleted( uint( _queryId ) );
        }
        else if( reqData.reqType == RequestType.POOL_SCHEDULED_CALLBACK )
        {
            IMainUniLotteryPool( poolAddress )
                    .scheduledCallback( uint( _queryId ) );
            emit PoolCallbackCompleted( uint( _queryId ) );
        }
        delete pendingRequests[ uint256( _queryId ) ];
    }
    function requestRandomSeedForLotteryFinish()
                                                    external
                                                    ongoingLotteryOnly
    returns( uint256 requestId )
    {
        uint transactionPrice = provable_getPrice( "random",
                    lotteryGasConfigs[ msg.sender ].gasLimit );
        if( transactionPrice >
            lotteryGasConfigs[ msg.sender ].etherFundsTransferedForGas )
        {
            if( address(this).balance >= transactionPrice )
            {
                bool response = IMainUniLotteryPool( poolAddress )
                .onLotteryCallbackPriceExceedingGivenFunds(
                    msg.sender,
                    transactionPrice,
                    lotteryGasConfigs[msg.sender].etherFundsTransferedForGas
                );
                require( response);
            }
            else {
                require( false);
            }
        }
        uint256 QUERY_EXECUTION_DELAY = 0;
        uint256 GAS_FOR_CALLBACK = lotteryGasConfigs[ msg.sender ].gasLimit;
        uint256 NUM_RANDOM_BYTES_REQUESTED = 8;
        uint256 queryId = uint256( provable_newRandomDSQuery(
            QUERY_EXECUTION_DELAY,
            NUM_RANDOM_BYTES_REQUESTED,
            GAS_FOR_CALLBACK
        ) );
        CallRequestData memory requestData;
        requestData.requestID = queryId;
        requestData.reqType = RequestType.LOTTERY_RANDOM_SEED;
        requestData.requesterAddress = msg.sender;
        pendingRequests[ queryId ] = requestData;
        emit LotteryRandomSeedRequested(
            queryId, msg.sender,
            lotteryGasConfigs[ msg.sender ].gasLimit,
            lotteryGasConfigs[ msg.sender ].etherFundsTransferedForGas
        );
        delete lotteryGasConfigs[ msg.sender ];
        return queryId;
    }
    function schedulePoolCallback(
                uint timeout,
                uint gasLimit,
                uint etherFundsTransferedForGas )
                                                    external
                                                    poolOnly
    returns( uint256 requestId )
    {
        uint queryId = uint(
                provable_query( timeout, "URL", "", gasLimit )
        );
        CallRequestData memory requestData;
        requestData.requestID = queryId;
        requestData.reqType = RequestType.POOL_SCHEDULED_CALLBACK;
        requestData.requesterAddress = msg.sender;
        pendingRequests[ queryId ] = requestData;
        emit PoolCallbackScheduled( queryId, poolAddress, timeout, gasLimit,
                                    etherFundsTransferedForGas );
        return queryId;
    }
    function sendFundsToPool( uint etherAmount )
                                                        external
                                                        poolOnly
    {
        poolAddress.transfer( etherAmount );
    }
    function setGasPrice( uint _gasPrice )
                                                        external
                                                        poolOnly
    {
        provable_setCustomGasPrice( _gasPrice );
    }
}
