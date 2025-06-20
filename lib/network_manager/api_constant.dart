class ApiConstant{

static const baseUrl="https://loyaltyapistaging.pipelinedns.com/api";

static const String baseImageUrl = "https://loyaltyapistaging.pipelinedns.com";

static const login="$baseUrl/authentication/partner/login";
static const sendOtp="$baseUrl/authentication/send-otp";
static const refreshToken="$baseUrl/authentication/refresh-token";

static const resetPassword="$baseUrl/authentication/partner/reset-password";
static const getToken="$baseUrl/authentication/token";
static const signUp="$baseUrl/customer";
static  getPartnerId(int id)=>"$baseUrl/partner/$id";
static const getSubscription="$baseUrl/subscription";
static const getSubscriptionMembership="/subscription/membership";
static  getFaq(int entityType)=>"/content/faqs?entityType=$entityType";
static  getGuides(int entityType)=>"/content/guides?entityType=$entityType";
static  getTermsAndConditions(int entityType)=>"/content/termsandconditions?entityType=$entityType";
static const getOffers="$baseUrl/offer";
static  getOffersById(int id)=>"$baseUrl/offer/$id";
static  const offerCategories="$baseUrl/offer/categories";
static const validateWashQr="$baseUrl/worker/validate-wash-qr";
static const notificationUrl="$baseUrl/notification";



static const uploadProfileImage="$baseUrl/partner/upload-profile-picture";
static const uploadProfile="$baseUrl/partner/update-profile";
//static  rewardedCustomerById(int offerId)=>"$baseUrl/offer/rewarded-customers?offerId=$offerId";
static const rewardedCustomer ="$baseUrl/offer/rewarded-customers";
static  getCustomerId(int id)=>"$baseUrl/customer/$id";
static const validateOfferQr="$baseUrl/offer/validate-offer-qr";
static const approvalStatus="$baseUrl/offer/approval-status";
static const String notification = "$baseUrl/notification/0";









}