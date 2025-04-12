class APIConstants {

  static String baseUrl = "https://chotuapp.deeptech.pk/";

// Admin constants
  static String adminLogin = baseUrl + "api";

  // store constants
  static String getAllStores = baseUrl + "api/stores";
  static String updateStoreStatus = baseUrl + "api/update/store/status/";

  // categories constants
  static String getAllCategories = baseUrl + "api/store/categories";
  static String updateCategoryStatus = baseUrl + "api/update/category/status/";
  static String deleteCategory = baseUrl + "api/delete/category/";
  static String addCategory = baseUrl + "api/store/add/category";


  // Users constants
  static String getAllUsers = baseUrl + "api/all/users";
  static String updateUserStatus = baseUrl + "api/update/user/status/";

}