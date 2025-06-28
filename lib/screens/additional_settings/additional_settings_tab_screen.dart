import 'package:chotu_admin/providers/additional_settings_provider.dart';
import 'package:chotu_admin/utils/app_Colors.dart';
import 'package:flutter/material.dart';
import 'package:chotu_admin/screens/additional_settings/tab_screens/FAQS_screen.dart';
import 'package:chotu_admin/utils/app_Paddings.dart';
import 'package:chotu_admin/utils/app_text_widgets.dart';
import 'package:provider/provider.dart';

import 'tab_screens/about_us_screen.dart';
import 'tab_screens/contact_us_screen.dart';
import 'tab_screens/privacy_policy_screen.dart';
import 'tab_screens/terms_and_conditions_screen.dart';

class AddSettingsTabScreen extends StatefulWidget {
  const AddSettingsTabScreen({super.key});

  @override
  State<AddSettingsTabScreen> createState() => _AddSettingsTabScreenState();
}

class _AddSettingsTabScreenState extends State<AddSettingsTabScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    AdditionalSettingsProvider provider = Provider.of<AdditionalSettingsProvider>(context,listen: false);
    provider.getAboutUs();
    provider.getTermsAndConditions();
    provider.getPrivacyPolicy();
    provider.getAllFaqs();
    provider.getContactUs();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          padding: EdgeInsets.all(12),
          // Attach the controller here
          tabAlignment: TabAlignment.center,
          dividerColor: Colors.transparent,
          indicatorColor: AppColors.primaryColor,
          unselectedLabelStyle:
              getMediumStyle(color: Colors.black45, fontSize: 14),
          labelStyle: getSemiBoldStyle(color: Colors.black, fontSize: 18),
          tabs: const [
            Text("Privacy Policy"),
            Text("Terms & Conditions"),
            Text("About Us"),
            Text("FAQ's"),
            Text("Contact Us"),
          ],
        ),
        padding10,
        Expanded(
          child: TabBarView(
            controller: _tabController, // Attach the controller here
            children: [
              PrivacyPolicyScreen(),
              TermsAndConditionsScreen(),
              AboutUsScreen(),
              FaqsScreen(),
              ContactUsScreen(),
            ],
          ),
        ),
      ],
    );
  }
}
