class APIConstants {
  // static String baseUrl = "https://burakvpn.raibs.co/";
  static String baseUrl = "https://chotuapp.foreversolutions.co.uk/";

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
  static String addProduct = baseUrl + "api/add/product";
  static String updateProductStatus = baseUrl + "api/update/product/status/";
  static String deleteProduct = baseUrl + "api/delete/product/";
  static String updateProduct = baseUrl + "api/update/product/";
  static String searchProduct = baseUrl + "api/product/search?";

  /// DashboardAnalytics
  static String getDashboardAnalytics = baseUrl + "api/dashboardAnalytics";

  /// Dashboard Delivery Settings
  static String getDashboardDeliverySettings =
      baseUrl + "api/delivery-settings";
  static String setDashboardDeliverySettings =
      baseUrl + "api/delivery-settings";

  /// OrderAnalytics
  static String getOrdersAnalytics = baseUrl + "api/order/analytics";

  /// All orders
  static String getAllOrders = baseUrl + "api/orders";

  /// search-order
  static String getOrderByIdOrName = baseUrl + "api/orderByIdOrName";

  /// ===============> Additional Settings <===============

  /// these settings have same endpoints, just difference is the get & put request
  static String getPrivacyPolicy = baseUrl + "api/pages/privacy-policy";
  static String getAboutUs = baseUrl + "api/pages/about-us";
  static String getTermsAndConditions =
      baseUrl + "api/pages/terms-and-conditions";
  static String updateAdditionalSettings = baseUrl + "api/pages/";

  /// getting FAQs
  static String getAllFaqs = baseUrl + "api/faqs";
  static String addFaq = baseUrl + "api/faqs";
  static String updateFaq = baseUrl + "api/faqs/";
  static String deleteFaq = baseUrl + "api/faqs/";

  /// getting Contact-Us
  static String getContactUs = baseUrl + "api/contact-info";
  static String updateContactUs = baseUrl + "api/contact-info";

  /// fetch product images
  static String uploadProductImages = baseUrl + "api/upload/bulk/images";
  static String fetchProductImages = baseUrl + "api/get/bulk/images";

  /// fetch auto complete places
  static String getAutoCompletePlaces = "https://api.locationiq.com/v1/autocomplete?";
}
