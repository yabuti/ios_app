class RemoteUrls {
  // Change this to your local server for testing
  // static const String rootUrl = "http://10.0.2.2:8000/"; // For Android Emulator
  // static const String rootUrl = "http://localhost:8000/"; // For iOS Simulator
  static const String rootUrl = "https://blackdiamondcar.com/"; // Production
  static const String baseUrl = '${rootUrl}api/';

  // ------------------- GENERAL -------------------
  static const String websiteSetup = '${baseUrl}website-setup';
  static const String homeUrl = baseUrl;

  // ------------------- AUTH -------------------
  static const String login = '${baseUrl}store-login';
  static const String register = '${baseUrl}store-register';
  static const String otpVerify = '${baseUrl}user-verification';
  static const String forgotOtpVerify = '${baseUrl}verify-forget-password-otp';
  static const String forgotPassword = '${baseUrl}send-forget-password';
  static const String setResetPassword = '${baseUrl}store-reset-password';
  static const String updatePassword = '${baseUrl}user/change-password';
  static const String logout = '${baseUrl}user/logout';

  // ------------------- LISTINGS -------------------
  static const String allCarList = '${baseUrl}listings';
  static String carDetails(String id) => '${baseUrl}listing/$id';

  // ------------------- WISHLIST -------------------
  static const String wishLists = '${baseUrl}user/wishlists';
  static String addWishLists(String id) => '${baseUrl}user/wishlists/add/$id';
  static String removeWishLists(String id) =>
      '${baseUrl}user/wishlists/remove/$id';

  // ------------------- BOOKINGS -------------------
  static const String bookingHistory = '${baseUrl}user/booking-history';
  static String bookingHistoryDetails(String id) =>
      '${baseUrl}user/booking-details/$id';
  static String bookingHistoryCancel(String id) =>
      '${baseUrl}user/booking-cancel-by-user/$id';
  static String startRide(String id) => '${baseUrl}user/ride-start-by-user/$id';

  // ------------------- DASHBOARD -------------------
  static String getTransactions = '${baseUrl}user/transactions';
  static String getUserDashboard = '${baseUrl}user/dashboard';
  static String getUserWithdraw = '${baseUrl}user/withdraw';
  static String getUserBookingRequest = '${baseUrl}user/booking-requests';

  // ------------------- CARS -------------------
  static String getUserCarList = '${baseUrl}user/car';
  static String createCar = '${baseUrl}user/car';
  static String getEditCarData(String id) => '${baseUrl}user/car/$id/edit';
  static String updateBasicCar(String id) => '${baseUrl}user/car/$id';
  static String keyFeatureUpdateCar(String id) =>
      '${baseUrl}user/car-key-feature/$id';
  static String featureUpdateCar(String id) => '${baseUrl}user/car-feature/$id';
  static String addressUpdateCar(String id) => '${baseUrl}user/car-address/$id';
  static String galleryUpdateCar(String id) =>
      '${baseUrl}user/video-images/$id';
  static String deleteCar(String id) => '${baseUrl}user/car/$id';
  static String getCarCreateData = '${baseUrl}user/car/create';

  // ------------------- KYC -------------------
  static String getKycInfo = '${baseUrl}user/kyc';
  static String submitKycInfo = '${baseUrl}user/kyc-submit';

  // ------------------- REVIEWS -------------------
  static String getAllReview = '${baseUrl}user/reviews';
  static String storeReview = '${baseUrl}user/reviews';

  // ------------------- STATIC PAGES -------------------
  static String getTermsCondition = '${baseUrl}terms-conditions';
  static String getPrivacyPolicy = '${baseUrl}privacy-policy';

  // ------------------- PROFILE -------------------
  static String getProfileData = '${baseUrl}user/edit';
  static String updateProfile = '${baseUrl}user/update';

  // ------------------- FILTERS -------------------
  static String getSearchAttribute = '${baseUrl}listings-filter-option';
  static String getCity(String id) => '${baseUrl}cities-by-country/$id';

  // ------------------- DEALERS -------------------
  static String dealerDetails(String userName) => '${baseUrl}dealer/$userName';
  static String contactDealer(String carId) =>
      '${baseUrl}send-message-to-dealer/$carId';
  static String contactMessage = '${baseUrl}store-contact-message';
  static String allDealer = '${baseUrl}dealers';
  static String getDealerCity = '${baseUrl}get-dealer-city';

  // ------------------- COMPARE -------------------
  static String compareList = '${baseUrl}user/comparelist';
  static String addCompareList = '${baseUrl}user/comparelist';
  static String removeCompareList(String id) =>
      '${baseUrl}user/comparelist/$id';

  // ------------------- SUBSCRIPTION -------------------
  static String subscriptionPlanList = '${baseUrl}user/pricing-plan';
  static String freePlanEnroll(String id) => '${baseUrl}user/free-enroll/$id';
  static String paymentInfo = '${baseUrl}user/payment-info';
  static String payWithStripe(String id) =>
      '${baseUrl}user/pay-via-stripe';
  static String payWithBank(String id) => '${baseUrl}user/pay-via-bank';
  static String payWithRazorpay(String id) =>
      '${rootUrl}user/razorpay-webview/$id';
  static String payWithFlutterWave(String id) =>
      '${rootUrl}user/flutterwave-webview/$id';
  static String payWithPayStack(String id) =>
      '${rootUrl}user/paystack-webview/$id';
  static String payWithMollie(String id) => '${rootUrl}user/mollie-webview/$id';
  static String payWithInstamojo(String id) =>
      '${rootUrl}user/instamojo-webview/$id';
  static String payWithPaypal(String id) =>
      '${rootUrl}pay-with-paypal-webview/$id';
  static const String transactionList = "/transaction/list";
  // ------------------- PRE-ORDER (DELIVERY & SPARE PARTS) -------------------
  static String preOrder = '${baseUrl}preorder/submit';
  static String sparePartCategories = '${baseUrl}spare-parts/categories';

  // ------------------- IMAGE HELPER -------------------
  static String imageUrl(String imageUrl) {
    if (imageUrl.startsWith("http")) return imageUrl;
    return rootUrl + imageUrl;
  }
}
