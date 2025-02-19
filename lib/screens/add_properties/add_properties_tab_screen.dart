import 'package:flutter/material.dart';
import 'package:chotu_admin/utils/app_Paddings.dart';
import 'package:chotu_admin/utils/app_text_widgets.dart';

import '../../utils/app_Colors.dart';
import 'new_events_screen.dart';
import 'new_properties_screen.dart';

class AddPropertiesTabScreen extends StatefulWidget {
  const AddPropertiesTabScreen({super.key});

  @override
  State<AddPropertiesTabScreen> createState() => _AddPropertiesTabScreenState();
}

class _AddPropertiesTabScreenState extends State<AddPropertiesTabScreen>
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
              Text("Add Property"),
              Text("Add Event"),
            ],
          ),
          padding10,
          Expanded(
            child: TabBarView(
              controller: _tabController, // Attach the controller here
              children: [NewPropertiesScreen(), NewEventsScreen()],
            ),
          ),
        ],
      ),
    );
  }
}
