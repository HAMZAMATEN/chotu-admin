import 'package:chotu_admin/providers/users_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:chotu_admin/providers/RealtorsProvider.dart';
import 'package:chotu_admin/providers/add_properties_provider.dart';
import 'package:chotu_admin/providers/additional_settings_provider.dart';
import 'package:chotu_admin/providers/dashboard_provider.dart';
import 'package:chotu_admin/providers/landing_page_provider.dart';
import 'package:chotu_admin/providers/side_bar_provider.dart';
import 'package:chotu_admin/screens/sidebar/side_bar_screen.dart';





void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key})
  ;

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
      ],

      child: MaterialApp(
        title: 'CHOTU ADMIN',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          useMaterial3: true,
          fontFamily: 'Quicksand',
        ),
        builder: EasyLoading.init(),
        home: SideBarScreen(),
        // home: LandingPageView(),
      ),
    );
  }
}
