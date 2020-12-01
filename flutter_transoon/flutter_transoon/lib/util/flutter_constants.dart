//Base url
const String BASE_URL = "https://transoon.azurewebsites.net/api/";
const String USER_URL = BASE_URL + "users/";
const String HASH_TAG_URL = BASE_URL + "hash-tags/";
const String TRANSACTION_QUEUE_URL = BASE_URL + "transaction-queues/";
const String LANGUAGE_URL = BASE_URL + "languages/";
const String PAYMENT_URL = BASE_URL + "payments/";
const String TRANSACTION_URL = BASE_URL + "transactions/";
const String TRANSACTION_QUEUE_ID = BASE_URL + "transaction-queues?";

//Hashtag
const String GET_HASH_TAG =
    BASE_URL + 'hash-tags?search=nam&sort=name-desc&limit=10&offset=20'; //GET
const String GET_HASH_TAG_COUNT =
    HASH_TAG_URL + 'count?search=nam&sort=name-desc&limit=10&offset=20'; //GET
const String CREATE_HASH_TAG = BASE_URL + 'hash-tags'; //POST
const String GET_HASH_TAG_BY_ID =
    HASH_TAG_URL + "1"; //POST (with 1 is hashTagId)
const String DELETE_HASH_TAG_BY_ID =
    HASH_TAG_URL + "1"; //DELETE (with 1 is hashTagId)

// Get by Id hoac delete: HASH_TAG_URL+hashTagId;
//User
const String GOOGLE_AUTHENTICATE_CONSUMER =
    BASE_URL + "Users/Authenticate-google-consumer"; //POST
const String CUSTOMER_AUTHENTICATE = USER_URL + "authenticate/customer"; //POST
const String TRANSOONER_AUTHENTICATE =
    USER_URL + "authenticate/transooner"; //POST
const String GET_LIST_USER = BASE_URL +
    "users?state=active&language=1&search=nam&sort=name-desc&limit=10&offset=20"; //GET
const String GET_USER_COUNT = USER_URL +
    "count?state=active&language=1&search=nam&sort=name-desc&limit=10&offset=20"; //GET
const String UPDATE_BASIC_INFO = USER_URL + '1/basic'; //POST (with 1 is userId)
const String UPDATE_BALANCE_INFO =
    USER_URL + '1/balance'; //POST (with 1 is userId)
const String UPDATE_STATUS_INFO =
    USER_URL + '1/status'; //POST (with 1 is userId)
const String ADD_FAVORITE = USER_URL + "favorite"; //POST
const String DELETE_FAVORITE = USER_URL + "favorite"; //DELETE
const String GET_USER_BY_ID = USER_URL + "5"; //POST (with 5 is userId)
const String DELETE_USER_BY_ID = USER_URL + "5"; //DELETE (with 5 is userId)
const String GET_LIST_ACTIVE_TRANSOONER =
    BASE_URL + "users?state=active&role=transooner";

//Payment
const String CREATE_PAYMENT = BASE_URL + 'payments'; //POST
const String GET_PAYMENT = BASE_URL +
    'payments?user=232&status=topup&sort=cre-date-asc&limit=10&offset=0'; //GET
const String GET_PAYMENT_COUNT = PAYMENT_URL +
    'count?user=12&status=topup&sort=cre-date-asc&limit=10&offset=0'; //GET

//Transaction
const String REQUEST_TO_TRANSOONER =
    TRANSACTION_URL + 'request-to-transooner'; //POST
const String GET_TRANSACTION_BY_USER_ID = BASE_URL + 'transactions?'; //GET
const String GET_TRANSACTION_COUNT = TRANSACTION_URL +
    'count?user=12&hashtag=12&language=22&sort=cre-date-asc&limit=12&offset=0&status=canceled'; //GET
const String UPDATE_REQUEST = TRANSACTION_URL; //PUT
const String GET_TRANSACTION_BY_ID =
    TRANSACTION_URL + '1'; //PUT (with 1 is transactionId)
const String FEED_BACK = TRANSACTION_URL + 'feedback';

//Notification

const String GET_NOTIFICATION = BASE_URL + 'notifications'; //POST

//Constant value

const int WORD_PRICE = 500;
