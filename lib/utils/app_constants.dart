import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class AppConstants {
  static CacheManager getCacheManger(String key) {
    return CacheManager(Config(key, stalePeriod: Duration(days: 5)));
  }
  static bool isArabic = false;
  static String currentAddress = '';


  static String authToken = '';
  static String googleMapApiKey = '';

}
