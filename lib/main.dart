import 'package:chotu_admin/providers/add_properties_provider.dart';
import 'package:chotu_admin/providers/additional_settings_provider.dart';
import 'package:chotu_admin/providers/api_services_provider.dart';
import 'package:chotu_admin/providers/categories_provider.dart';
import 'package:chotu_admin/providers/dashboard_provider.dart';
import 'package:chotu_admin/providers/landing_page_provider.dart';
import 'package:chotu_admin/providers/orders_provider.dart';
import 'package:chotu_admin/providers/riders_provider.dart';
import 'package:chotu_admin/providers/session_provider.dart';
import 'package:chotu_admin/providers/side_bar_provider.dart';
import 'package:chotu_admin/providers/users_provider.dart';
import 'package:chotu_admin/screens/all_product_images/all_product_images.dart';
import 'package:chotu_admin/screens/sidebar/side_bar_screen.dart';
import 'package:chotu_admin/utils/app_Colors.dart';
import 'package:chotu_admin/utils/app_constants.dart';
import 'package:chotu_admin/utils/app_prefrences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'providers/store_product_provider.dart';
import 'providers/store_provider.dart';
import 'screens/session/login_view.dart';

// flutter run -d chrome --web-browser-flag="--disable-web-security" --web-browser-flag="--disable-site-isolation-trials"

late final SharedPreferences sp;
final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sp = await SharedPreferences.getInstance();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: 'AIzaSyDf_azDXM69RG_ryRAaHJrgooVq3UX_K4U',
      appId: '1:493629751703:web:bc61fa8061fa20ba17c4d2',
      messagingSenderId: '493629751703',
      projectId: 'chotu-admin-app',
      authDomain: 'chotu-admin-app.firebaseapp.com',
      storageBucket: 'chotu-admin-app.firebasestorage.app',
      measurementId: 'G-EYKW61YSSP',
    ),
  );

  setUrlStrategy(PathUrlStrategy());
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SideBarProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => DashboardProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CategoriesProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => RidersProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => UsersProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => AddPropertiesProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => AdditionalSettingsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => LandingPageProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => SessionProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ApiServicesProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => StoreProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrdersProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => StoreProductProvider(),
        ),
      ],
      child: GetMaterialApp(
        title: 'CHOTU-ADMIN',
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          useMaterial3: true,
          fontFamily: 'Quicksand',
        ),
        builder: EasyLoading.init(),
        // home: SideBarScreen(),
        initialRoute: '/LoadingScreen',
        home: LoadingScreen(),
      ),
    );
  }
}

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      /// Added a 4 Seconds delay , to make it look better
      Future.delayed(Duration(seconds: 4), () {
        getIsLogin();
      });
    });
  }

  Future<void> getIsLogin() async {
    bool isLogin = await AppPreferences.getIsLogin();
    if (isLogin == true) {
      String? storedToken = await AppPreferences.getAuthToken();
      if (storedToken != null) {
        AppConstants.authToken = storedToken;
        debugPrint("AUTH TOKEN IS ${AppConstants.authToken}");
      } else {
        Get.offAll(() => LoginView());
        // Get.offAll(() => AllProductImagesScreen());
      }
      Get.offAll(() => SideBarScreen());
      // Get.offAll(() => AllProductImagesScreen());
    } else {
      Get.offAll(() => LoginView());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          height: 100,
          width: 100,
          child: Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
