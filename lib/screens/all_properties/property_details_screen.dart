import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:chotu_admin/screens/all_properties/widgets/build_property_detail_right_section.dart';
import 'package:chotu_admin/screens/all_properties/widgets/build_property_detail_left_section.dart';

import '../../generated/assets.dart';
import '../../utils/app_Colors.dart';
import '../../utils/app_Paddings.dart';
import '../../utils/app_text_widgets.dart';
import '../../utils/fonts_manager.dart';
import '../../widgets/custom_Button.dart';

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
