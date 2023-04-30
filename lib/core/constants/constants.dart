
const String mapApiKey = "AIzaSyDo8Uub1ANmUDFyLcHNg108NrQawJWLwXw";

//hive boxes
const String userBox = "user_box";
const String profileUserBox = "profile_user_box";
const String jobListTypesBox = "job_list_box";
const String jobCartBox = "job_cart_box";
//
String baseUrl({flavor = "dev"}) => flavor == "production"
    ? 'https://admin.bassured.com/web-api/customer/'
    : 'https://$flavor-assured.imark.com.np/web-api/customer';

String productionBaseUrl() => 'https://admin.bassured.com/web-api/customer/';

String imageBaseUrlProduction() => 'https://minio.imark.com.np/assured-live';

String imageBaseUrlQA() => 'https://minio.imark.com.np/assured-dev';

String devBaseUrl({flavor = "dev"}) =>
    'https://dev-assured.imark.com.np/web-api/customer';

String imageBaseUrl({flavor = "dev"}) =>
    'https://minio.imark.com.np/assured-dev';

const String path = "/customer";
const String serverConfigUrl = '/settings';
const String requestOtpUrl = '$path/otp/validate/mobile';
const String resendOtpUrl = '$path/resend/otp';
const String validateOtpUrl = '$path/otp/validate';
const String signupUrl = '$path/register';
const String loginUrl = '/auths';
const String logoutUrl = '$path/logout';
const String forgetPasswordUrl = "$path/forget/password";
const String resetPasswordUrl = "$path/reset/password";
const String changePasswordUrl = "$path/change/password";
const String searchServiceTypeUrl = "/public/service-type/search";
const String getBookingHistoryUrl = "/job-request/history";
const String profileUrl = "/customer/profile";

const String getDeleteUserAccountUrl = "$path/delete/account";
const String getBlockedUserAccountUrl = "$path/block";

const String fingerPrintLoginUrl = '/auths/device';
const String updateDeviceTokenUrl = '$path/device-token';

//notifications
const String notificationUrl = "/notification/search";
const String unreadNotificationCountUrl = "/notification/unread/count";
const String markAllNotificationsReadUrl = "/notification/mark_all_read";

//Url
const String passwordPolicyUrl =
    '/public/configs/search/detail/f808c1c93fa544bc8950ce709995a183';

String notificationDetailUrl(String? id) => "/notification/search/detail/${id}";

String getAddressListUrl(String id) => "/master/search/address/$id";
const String addressSearchUrl = "";

String getBookingHistoryUrlById(String? id) => "/job-request/search/detail/$id";

String serviceSubTypeUrl(String? id) =>
    "/public/service_sub_type/service_type/$id";

String updateProfileUrl(String? id) => "/customer/$id";
const String updateAddress = "/customer/address";

String getJObByServiceTypeUrl(String id) => '/public/jobs/service-type/$id';

String serviceProviderProfileUrl(String? id) => '/service-provider/$id';

// String getJObByServiceSubTypeUrl(
//         ServiceSubType serviceSubType, String filter) =>
//     '/public/jobs/${serviceSubType.serviceTypeId}/sub-type/${serviceSubType.id}/${filter}';
//
// String getAllServiceTypesAndTheirAllJobsUrl(
//         ServiceSubType serviceSubType, String subscriptionType) =>
//     '/public/jobs/service-types/${serviceSubType.serviceTypeId}/$subscriptionType';
// '/public/jobs/${serviceSubType.serviceTypeId}/sub-type/${serviceSubType.id}/${filter}';

String cancelJobRequestUrl(String? id) => '/job-request/cancel/$id';
const String checkDiscountUrl = '/job-request/check/discount';

// String ImageUrlWrapper(String? docPath, {String path = "service-sub-type"}) =>
//     '${GetIt.I<AppConfig>().getImageBaseUrl()}/$path/$docPath';
// const String getAdsUrl = '/public/advertisement_banner/search';
//job request
const String jobRequestUrl = '/job-request';

String serviceTypeDetailsUrl(String id) =>
    '/public/service-type/search/detail/$id';

// payments
String completePaymentUrl = "/transaction/job-request/payment";

String failurePaymentUrl = "/transaction/payment/failure";

String promoCodeUrl(String? serviceType, String? code) =>
    "/promo/validate/$serviceType/$code";
const String ratingUrl = "/rating";
const String referalUrl = "/referral";
const String esewaCallbackUrl = "/transaction/job-request/payment";

String getPingDetailsUrl(String? jobRequestId, String? jobId) =>
    "/job-request/$jobRequestId/jobs/$jobId/alert";

// Local storage
const String roleKey = "user_role";
const String tokenKey = 'access_token';
const String userSessionCleared = "session_clear";
const String userKey = 'user_key';
const String fcmTokenKey = 'fcm_token';
const String notificationCountKey = 'notification_count';
const String isAuthenticatedKey = 'isAuthenticated';
const String configurationKey = 'key_configuration';
const String isConfiguredKey = 'key_is_configured';
const String rememberedMeKey = "key_remember_me";
const String rememberedPasswordKey = "key_remember_pass";
const String rememberedUserNameKey = "key_remember_username";
const String fingerPrint_token = 'device_token';
const String fingerPrintKey = "key_finger_print";
const String firstTimeLoginKey = "key_first_time_login";
const String languageKey = 'key_language';
const String keyGuestSession = 'keyGuestSession';
const String keyUserProfile = 'keyUserProfile';

////// Notification Key

const String redirect_key_promo = "PROMO_CODE";

// APi Key Constants

const String PENDING_STATUS = "PEN";

//payment
const String TXN_MODE_CASH = "CAS";
const String TXN_MODE_ESEWA = "ESW";

//adddress
const String TXT_GENDER_MALE = "MAL";
const String TXT_GENDER_FEMALE = "FEM";
const String TXT_GENDER_OTHER = "OTH";
const int VALUE_GENDER_MALE = 0;
const int VALUE_GENDER_FEMALE = 1;
const int VALUE_GENDER_OTHER = 2;
const int VALUE_GENDER_DEFAULT = -1;

//select language
const String key_lang_np = "ne";
const String key_lang_en = "en";
