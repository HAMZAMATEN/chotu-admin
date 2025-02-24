import 'package:chotu_admin/screens/shops/widgets/addNewShopDialogBox.dart';
import 'package:chotu_admin/utils/app_Colors.dart';
import 'package:chotu_admin/utils/app_Paddings.dart';
import 'package:chotu_admin/utils/app_text_widgets.dart';
import 'package:chotu_admin/widgets/custom_Button.dart';
import 'package:chotu_admin/widgets/custom_TextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../generated/assets.dart';

  class ShopsScreen extends StatefulWidget {
  @override
  State<ShopsScreen> createState() => _ShopsScreenState();
}

class _ShopsScreenState extends State<ShopsScreen> {
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
              offset: const Offset(0, 0),
              color: Colors.black.withOpacity(.1),
              blurRadius: 2,
              spreadRadius: 0,
            )
          ]),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  /// Status Summary Cards
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatsCard('Total Shops', 5, Colors.orange),
                      ),
                      padding12,
                      Expanded(
                        child: _buildStatsCard('Active', 4, Colors.green),
                      ),
                      padding12,
                      Expanded(
                        child: _buildStatsCard('DeActive', 1, Colors.red),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  /// Search Bar & add shop button

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: CustomTextField(
                          width: MediaQuery.of(context).size.width,
                          title: '',
                          controller: TextEditingController(),
                          obscureText: false,
                          textInputAction: TextInputAction.search,
                          keyboardType: TextInputType.text,
                          hintText: 'Search Shops by name',
                          suffixIcon: SizedBox(
                            height: 24,
                            width: 24,
                            child: Center(
                              child: SvgPicture.asset(Assets.iconsSearchnormal1),
                            ),
                          ),
                        ),
                      ),
                      padding12,
                      InkWell(
                        onTap: () {
                          showAddShopDialog(context);
                        },
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: AppColors.primaryColor,
                            ),
                            child: Text(
                              'Add New Shop',
                              style: getSemiBoldStyle(
                                color: AppColors.whiteColor,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  padding30,




                  // Scrollable Data Table

                  Wrap(
                    // alignment: WrapAlignment.center,
                    // crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 16,
                    runSpacing: 16,
                    children: List.generate(10, (index) {
                      return _buildShopCard(context);
                    }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
/// build stats card
  Widget _buildStatsCard(String title, int count, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color(0xfff5f5f5),
      ),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const Spacer(),
          Text(
            count.toString(),
            style: TextStyle(
              color: color,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShopCard(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1 / 3.16, // Takes 1/3 of the parent width
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
              offset: const Offset(0, 0),
              blurRadius: 7,
              spreadRadius: 0,
              color: Colors.black.withOpacity(.25)),
        ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 51,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                  colors: [
                    Color(0xff45CF8D),
                    Color(0xff046938),
                  ],
                ),
              ),
              child: Center(
                  child: Text(
                    'Shop Name - xxxxx',
                    style: getMediumStyle(color: Colors.white, fontSize: 16),
                  )),
            ),
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 10.0, vertical: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Shop Details',
                        style: getMediumStyle(
                            color: AppColors.textColor, fontSize: 16),
                      ),
                      Spacer(),
                      SizedBox()
                    ],
                  ),
                  padding16,
                  _buildRow(title: 'Category', description: 'Mobile Shop'),
                  _buildRow(title: 'Total Products', description: '7'),
                  _buildRow(title: 'Total Orders ', description: '10'),
                  _buildRow(title: 'Delivered Orders', description: '5'),
                  _buildRow(title: 'Shop Location', description: 'Johr Town Lahore'),
                  padding16,
                  const Divider(
                    color: Color(0xffAFA9A9),
                  ),
                  _buildRow(title: 'Shop Status', description: 'Active'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow({required String title, required String description}) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: getRegularStyle(
              color: const Color(0xff454545),
              fontSize: 14,
            ),
          ),
        ),
        padding12,
        Expanded(
          child: Align(
            alignment: Alignment.topRight,
            child: Text(
              description,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: getRegularStyle(
                color: const Color(0xff454545),
                fontSize: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
