import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class AppConstants {
  static CacheManager getCacheManger(String key) {
    return CacheManager(Config(key, stalePeriod: Duration(days: 5)));
  }
  static bool isArabic = false;
  static String currentAddress = '';


  static String authToken = '';
  static String googleMapApiKey = 'AIzaSyC2fWxeerzaACQnhahbU85T83o4fTTOszw';
  static String kLocationKey = 'pk.07fc9737209a057a3e05aa92de3e2994';

}
