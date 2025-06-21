class APIConstants {
  static String baseUrl = "https://burakvpn.raibs.co/";

  /// Admin constants
  static String adminLogin = baseUrl + "api";

  /// store constants
  static String addStore = baseUrl + "api/store";
  static String getAllStores = baseUrl + "api/stores";
  static String updateStoreStatus = baseUrl + "api/update/store/status/";
  static String searchStore = baseUrl + "api/store/search/";
  static String updateStore = baseUrl + "api/update/store/";
  static String getStoreAnalytics = baseUrl + "api/store/analytics/";


  /// categories constants
  static String getAllCategories = baseUrl + "api/store/categories";
  static String updateCategoryStatus = baseUrl + "api/update/category/status/";
  static String deleteCategory = baseUrl + "api/delete/category/";
  static String addCategory = baseUrl + "api/store/add/category";

  /// Users constants
  static String getAllUsers = baseUrl + "api/all/users";
  static String searchUsers = baseUrl + "api/user/search";

  static String updateUserStatus = baseUrl + "api/update/user/status/";

  /// RIDER constants
  static String getAllRiders = baseUrl + "api/all/riders";
  static String searchRiders = baseUrl + "api/rider/search";
  static String updateRiderStatus = baseUrl + "api/update/rider/status/";
  static String removeRider = baseUrl + "api/remove/rider/";

  /// Products Constants
  static String getAllProducts = baseUrl + "api/get/all/products";
  static String getProductByStoreId = baseUrl + "api/get/products/by/store/";

  /// DashboardAnalytics
  static String getDashboardAnalytics = baseUrl + "api/dashboardAnalytics";

  /// OrderAnalytics
  static String getOrdersAnalytics = baseUrl + "api/order/analytics";

  /// All orders
  static String getAllOrders = baseUrl + "api/orders";


  /// ===============> Additional Settings <===============

  /// these settings have same endpoints, just difference is the get & put request
  static String getPrivacyPolicy = baseUrl + "api/pages/privacy-policy";
  static String getAboutUs = baseUrl + "api/pages/about-us";
  static String getTermsAndConditions = baseUrl + "api/pages/terms-and-conditions";
  static String updateAdditionalSettings = baseUrl + "api/pages/";

  /// getting FAQs
  static String getAllFaqs = baseUrl + "api/faqs";
  static String addFaq = baseUrl + "api/faqs";
  static String updateFaq = baseUrl + "api/faqs/";
  static String deleteFaq = baseUrl + "api/faqs/";


  /// getting Contact-Us
  static String getContactUs = baseUrl + "api/contact-info";
  static String updateContactUs = baseUrl + "api/contact-info";
}

