import 'package:chotu_admin/main.dart';

class HivePreferences {


  static setIsLogin(bool val){
    sessionBox.put('isLogin', val);
  }

  static getIsLogin(){
   return sessionBox.get('isLogin');
  }


  static setAuthToken(String val){
    sessionBox.put('authToken', val);
  }

  static getAuthToken(){
   return sessionBox.get('authToken');
  }


}