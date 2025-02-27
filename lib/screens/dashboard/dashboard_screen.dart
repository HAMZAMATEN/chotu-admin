import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:chotu_admin/generated/assets.dart';
import 'package:chotu_admin/providers/dashboard_provider.dart';
import 'package:chotu_admin/screens/riders/widgets/ShowRiderPopupDialog.dart';
import 'package:chotu_admin/utils/app_Paddings.dart';
import 'package:chotu_admin/utils/app_text_widgets.dart';
import 'package:chotu_admin/widgets/custom_TextField.dart';

import '../../utils/app_Colors.dart';
import '../../utils/fonts_manager.dart';
import '../../widgets/custom_Button.dart';
import '../users/widgets/ShowUserPopupDialog.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 5,
        ),
        child: Column(
          children: [
            padding30,
            _buildStatsSection(),
            padding20,
            // Row(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Expanded(child: _buildAddPropertyTypesSection()),
            //     padding30,
            //     Expanded(child: _buildAddEventTypesSection()),
            //   ],
            // ),
            padding20,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildRecentlyJoinedUsersSection()),
                padding30,
                Expanded(child: _buildSocialLinksSection()),
              ],
            ),
            padding20,
          ],
        ),
      ),
    );
  }





  /// build stats section
  Widget _buildStatsSection() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildTopCard(
                  iconPath: Icons.monetization_on,

                  title: 'Revenue',
                  amount: '166,580',
                  increase: '5%'),
            ),
            padding20,
            Expanded(
              child: _buildTopCard(
                  iconPath: Icons.reorder,

                  title: 'Total Orders',
                  amount: '430',
                  increase: '2%'),
            ),
 padding20,
            Expanded(
              child: _buildTopCard(
                  iconPath: Icons.cancel,

                  title: 'Cancel Orders',
                  amount: '430',
                  increase: '2%'),
            ),

          ],
        ),
        padding10,
        Row(
          children: [
            Expanded(
              child: _buildTopCard(
                  iconPath: Icons.shopify_sharp,

                  title: 'Total Shops',
                  amount: '10',
                  increase: '2%'),
            ),
            padding20,
            Expanded(
              child: _buildTopCard(
                  iconPath: Icons.verified_user,

                  title: 'Total Rides',
                  amount: '51,580',
                  increase: '4%'),
            ),

            padding20,
            Expanded(
              child: _buildTopCard(
                iconPath: Icons.supervised_user_circle,
                  title: 'Total Users',
                  amount: '51,580',
                  increase: '4%'),
            ),


          ],
        ),
        padding10,
        Row(
          children: [



            Expanded(
              child: _buildPieChart("Revenue & Shop's Info", {
                Color(0xffFF4D4D): 'Revenue', // Give to Rent
                Colors.green: "Total Shop's", // Want to Sell
              }),
            ),
            padding20,


            Expanded(
              child: _buildPieChart("Total Rider's & User's Info", {
                Color(0xffFF4D4D): "Rider's", // Give to Rent
                Colors.green: "User's", // Want to Sell
              }),
            ),padding20,


            Expanded(
              child: _buildPieChart("Order's Info", {
                Colors.blue: "Total Order's",
                Colors.green: "Delivered Order's",
                Color(0xffFF4D4D): "Cancel Order's",
              }),
            ),
          ],
        )


      ],
    );
  }

  Widget _buildTopCard({
    required IconData iconPath,
    required String title,
    required String amount,
    required String increase,
  }) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Color(0xffD9D9D9))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 24,
                width: 24,
                child: Center(child: Icon(iconPath,
                color: Colors.green,
                )),
              ),
              padding5,
              Text(
                title,
                style: getRegularStyle(
                  color: Color(0xff1f1f1f),
                  fontSize: 16,
                ),
              ),
            ],
          ),
          padding10,
          Text(
            '$amount',
            style: getMediumStyle(color: Color(0xff1f1f1f), fontSize: 32),
          ),
          padding10,
          Row(
            children: [
              Container(
                height: 24,
                width: 24,
                child: Center(
                  child: SvgPicture.asset(
                    Assets.iconsTrendup,
                    color: Colors.green,
                  ),
                ),
              ),
              Text(
                increase,
                style: getMediumStyle(
                  color:Colors.green,
                  fontSize: 16,
                ),
              ),
              Text(
                ' in the last 1 month',
                style: getRegularStyle(
                  color: Color(0xffABABAB),
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

 /// build recently joined users section
  Widget _buildRecentlyJoinedUsersSection() {
    return Consumer<DashboardProvider>(
      builder: (context, provider, child) {
        return Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Color(
                0xffD9D9D9,
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Recently Joined Users',
                    style:
                        getMediumStyle(color: Color(0xff1f1f1f), fontSize: 20),
                  ),
                  Spacer(),
                  SizedBox(),
                  // Container(
                  //   height: 40,
                  //   padding: const EdgeInsets.symmetric(horizontal: 10),
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(8),
                  //     color: Color(0xffFAFAFA),
                  //     border: Border.all(
                  //       color: Color(0xffdddddd),
                  //       width: 1,
                  //     ),
                  //   ),
                  //   child: DropdownButtonHideUnderline(
                  //     child: DropdownButton<String>(
                  //       icon: null,
                  //       value: provider.selectedStatus,
                  //       dropdownColor: Colors.white,
                  //       isExpanded: false,
                  //       style: getMediumStyle(
                  //         fontSize: 14,
                  //         color: Color(0xff8F8F8F),
                  //       ),
                  //       items: provider.statuses.map((status) {
                  //         return DropdownMenuItem<String>(
                  //           value: status,
                  //           child: Text(
                  //             status,
                  //             style: getMediumStyle(
                  //                 color: Colors.black, fontSize: 14),
                  //           ),
                  //         );
                  //       }).toList(),
                  //       onChanged: (newValue) {
                  //         if (newValue != null) {
                  //           provider.setSelectedStatus(newValue);
                  //         }
                  //       },
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              padding20,
              UserTable(),
            ],
          ),
        );
      },
    );
  }

  /// build social links section
  Widget _buildSocialLinksSection() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Color(
            0xffD9D9D9,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Delivery Charges & Link to Play & App store',
            style: getMediumStyle(color: Color(0xff1f1f1f), fontSize: 20),
          ),
          padding20,

          CustomTextField(
              title: 'Delivery Charges',
              controller: TextEditingController(
                text: '200',
              ),
              obscureText: false,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              suffixIcon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.monetization_on_outlined
                  ,
                  color:                     Colors.green,

                  size: 20,
                ),
              ),
              hintText: ''),

          padding20,
          CustomTextField(
              title: 'Link of the app at play store',
              controller: TextEditingController(
                text: 'https://www.playstore.com/app/Saqfi',
              ),
              obscureText: false,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              suffixIcon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'copy link',
                  style: getMediumStyle(color:                     Colors.green,
                      fontSize: 14),
                ),
              ),
              hintText: ''),
          padding20,
          CustomTextField(
              title: 'Link of the app at app store',
              suffixIcon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'copy link',
                  style: getMediumStyle(color:                    Colors.green,
                      fontSize: 14),
                ),
              ),
              controller: TextEditingController(
                text: 'https://www.playstore.com/app/Saqfi',
              ),
              obscureText: false,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              hintText: ''),
          padding20,
          Row(
            children: [
              Container(
                height: 60,
                width: 150,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage(
                    Assets.imagesPlayStore,
                  ),
                  fit: BoxFit.cover,
                )),
              ),
              Container(
                height: 52,
                width: 150,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage(
                    Assets.imagesAppStore,
                  ),
                  fit: BoxFit.cover,
                )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
/// build pie chart
Widget _buildPieChart(String title, Map<Color, String> data) {
  return Container(
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xffD9D9D9))),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        padding8,
        Row(
          children: [
            Container(
              height: 150,
              width: 150,
              child: PieChart(
                PieChartData(
                  sections: data.entries
                      .map(
                        (entry) => PieChartSectionData(
                      color: entry.key,
                      titleStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                      .toList(),
                  sectionsSpace: 4,
                  centerSpaceRadius: 30,
                ),
              ),
            ),
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: data.entries.map((e) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    children: [
                      Container(
                        height: 27,
                        width: 27,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: e.key),
                      ),
                      padding5,
                      Text(
                        e.value,
                        style: getRegularStyle(
                            color: Colors.black, fontSize: 12),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ],
    ),
  );
}



class UserTable extends StatelessWidget {
  const UserTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> users = [
      {
        "name": "Eleanor Pena",
        "info": "Joined at 25/4/2024 and is a very frequent user",
        "button": "See"
      },
      {
        "name": "Wade Warren",
        "info": "Joined at 15/12/2024 and is a non frequent user",
        "button": "See"
      },
      {
        "name": "Wade Warren",
        "info": "Joined at 15/12/2024 and is a non frequent user",
        "button": "See"
      },
      {
        "name": "Wade Warren",
        "info": "Joined at 15/12/2024 and is a non frequent user",
        "button": "See"
      },
      {
        "name": "Wade Warren",
        "info": "Joined at 15/12/2024 and is a non frequent user",
        "button": "See"
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // Header Row
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                "User's Name",
                style: getMediumStyle(
                    color: const Color(0xffABABAB), fontSize: 12),
              ),
            ),
            padding15,
            Expanded(
              flex: 3,
              child: Text(
                "Joining Date and User Frequency",
                style: getMediumStyle(
                    color: const Color(0xffABABAB), fontSize: 12),
              ),
            ),
            padding15,
            Expanded(
              child: Center(
                child: Text(
                  "Info",
                  style: getMediumStyle(
                      color: const Color(0xffABABAB), fontSize: 12),
                ),
              ),
            ),
          ],
        ),
        padding3,

        const Divider(
          color: Color(0xffF1F1F1),
          thickness: 1,
        ),
        // Custom divider

        padding3,
        // User Rows
        ListView.separated(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: users.length,
          separatorBuilder: (context, index) => const Divider(
            color: Color(0xffF1F1F1),
            thickness: 1,
          ),
          itemBuilder: (context, index) {
            final user = users[index];
            return Padding(
              padding: EdgeInsets.only(top: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      user["name"]!,
                      style: getRegularStyle(
                          color: const Color(0xff1F1F1F), fontSize: 14),
                    ),
                  ),
                  padding15,
                  Expanded(
                    flex: 3,
                    child: Text(
                      user["info"]!,
                      style: getRegularStyle(
                          color: const Color(0xff1F1F1F), fontSize: 14),
                    ),
                  ),
                  padding15,
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        showUserProfileDialog(context);
                      },
                      child: Center(
                        child: Container(
                          height: 40,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.green,
                          ),
                          child: Center(
                            child: Text(
                              'See More',
                              style: getMediumStyle(
                                  color: AppColors.whiteColor, fontSize: 10),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
