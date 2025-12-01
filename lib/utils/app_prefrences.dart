import 'package:chotu_admin/main.dart';

class AppPreferences {


  static Future<void> setIsLogin(bool val) async{
    await sp.setBool("isLogin", val);
  }

  static Future<bool> getIsLogin() async{
   return await sp.getBool("isLogin") ?? false;
  }


  static void setAuthToken(String val) async{
    await sp.setString("authToken", val);
  }

  static Future<void> clearAuthToken() async{
    await sp.remove('authToken');
}

  static Future<String?> getAuthToken() async{
    return await sp.getString("authToken");
  }


}