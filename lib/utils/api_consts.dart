class APIConstants {

  static String baseUrl = "https://chotuapp.deeptech.pk/";

// Admin constants
  static String adminLogin = baseUrl + "api";

  // store constants
  static String getAllStores = baseUrl + "api/stores";
  static String updateStoreStatus = baseUrl + "api/update/store/status/";

  // categories constants
  static String getAllCategories = baseUrl + "api/store/categories";

  // Users constants
  static String getAllUsers = baseUrl + "api/all/users";
  static String updateUserStatus = baseUrl + "api/update/user/status/";

  // RIDER constants
  static String getAllRiders = baseUrl + "api/all/riders";
  static String updateRiderStatus = baseUrl + "api/update/rider/status/";

}