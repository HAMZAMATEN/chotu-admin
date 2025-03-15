import 'package:chotu_admin/main.dart';

class HivePreferences {


  static setIsLogin(bool val){
    sessionBox.put('isLogin', val);
  }

  static getIsLogin(){
    sessionBox.get('isLogin');
  }


  static setAuthToken(String val){
    sessionBox.put('authToken', val);
  }

  static getAuthToken(){
    sessionBox.get('authToken');
  }



}