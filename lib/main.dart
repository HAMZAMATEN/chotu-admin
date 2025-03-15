import 'package:chotu_admin/firebase_options.dart';
import 'package:chotu_admin/providers/api_services_provider.dart';
import 'package:chotu_admin/providers/session_provider.dart';
import 'package:chotu_admin/providers/users_provider.dart';
import 'package:chotu_admin/utils/app_constants.dart';
import 'package:chotu_admin/utils/hive_prefrences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:chotu_admin/providers/RealtorsProvider.dart';
import 'package:chotu_admin/providers/add_properties_provider.dart';
import 'package:chotu_admin/providers/additional_settings_provider.dart';
import 'package:chotu_admin/providers/dashboard_provider.dart';
import 'package:chotu_admin/providers/landing_page_provider.dart';
import 'package:chotu_admin/providers/side_bar_provider.dart';
import 'package:chotu_admin/screens/sidebar/side_bar_screen.dart';

import 'screens/session/login_view.dart';

late Box sessionBox;
final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  sessionBox = await Hive.openBox('session');
  runApp(const MyApp());
}
// git remote set-url origin https://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@github.com/HAMZAMATEN/chotu-admin.git

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool alreadyLogin = false;
  bool sessionLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sessionFunction();
  }

  updateLoading(bool val) {
    sessionLoading = val;
    setState(() {});
  }

  sessionFunction() {
    if (HivePreferences.getIsLogin() == null ||
        HivePreferences.getIsLogin() == false) {
      alreadyLogin = false;
      updateLoading(false);
    } else if (HivePreferences.getIsLogin() == true) {
      alreadyLogin = true;
      AppConstants.authToken = HivePreferences.getAuthToken();
      updateLoading(false);
    } else {
      alreadyLogin = false;
      updateLoading(false);
    }
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
          create: (_) => RealtorProvider(),
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
        initialRoute: '/',
        home: (sessionLoading == true)
            ? Scaffold(
                backgroundColor: Colors.white,
                body: Center(
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                  ),
                ),
              )
            : (alreadyLogin == true)
                ? SideBarScreen()
                : LoginView() ,
      ),
    );
  }
}
