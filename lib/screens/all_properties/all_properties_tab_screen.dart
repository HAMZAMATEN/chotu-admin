import 'package:chotu_admin/screens/all_properties/all_events_screen.dart';
import 'package:chotu_admin/utils/app_Paddings.dart';
import 'package:chotu_admin/utils/app_text_widgets.dart';
import 'package:flutter/material.dart';

import '../../utils/app_Colors.dart';
import 'all_properties_screen.dart';

class AllPropertiesTabScreen extends StatefulWidget {
  const AllPropertiesTabScreen({super.key});

  @override
  State<AllPropertiesTabScreen> createState() => _AllPropertiesTabScreenState();
}

class _AllPropertiesTabScreenState extends State<AllPropertiesTabScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(30),
      child: Column(
        children: [
          TabBar(
            controller: _tabController,
            // Attach the controller here
            tabAlignment: TabAlignment.center,
            dividerColor: Colors.transparent,
            indicatorColor: AppColors.primaryColor,
            unselectedLabelStyle:
                getMediumStyle(color: Colors.black45, fontSize: 14),
            labelStyle: getSemiBoldStyle(color: Colors.black, fontSize: 18),
            tabs: const [
              Text("All Properties"),
              Text("All Events"),
            ],
          ),
          padding10,
          Expanded(
            child: TabBarView(
              controller: _tabController, // Attach the controller here
              children: [
                AllPropertiesScreen(),
                AllEventsScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
