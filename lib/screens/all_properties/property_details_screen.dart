import 'package:chotu_admin/screens/all_properties/widgets/build_property_detail_left_section.dart';
import 'package:chotu_admin/screens/all_properties/widgets/build_property_detail_right_section.dart';
import 'package:flutter/material.dart';

import '../../utils/app_Colors.dart';
import '../../utils/app_Paddings.dart';
import '../../utils/app_text_widgets.dart';

class PropertyDetailsScreen extends StatelessWidget {
  const PropertyDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Text(
          'Delete',
          style: getMediumStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        backgroundColor: AppColors.primaryColor,
        icon: Icon(
          Icons.delete_forever_outlined,
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Row(
          children: [
            buildPropertyDetailLeftSection(),
            padding50,
            buildPropertyDetailRightSection(context),
          ],
        ),
      ),
    );
  }
}
