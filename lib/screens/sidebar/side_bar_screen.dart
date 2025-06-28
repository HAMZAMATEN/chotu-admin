import 'package:chotu_admin/screens/session/login_view.dart';
import 'package:chotu_admin/utils/hive_prefrences.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:chotu_admin/generated/assets.dart';
import 'package:chotu_admin/utils/app_Colors.dart';
import 'package:chotu_admin/utils/app_Paddings.dart';
import 'package:chotu_admin/utils/app_text_widgets.dart';
import 'package:chotu_admin/widgets/custom_TextField.dart';
import '../../providers/side_bar_provider.dart';

class SideBarScreen extends StatefulWidget {
  const SideBarScreen({super.key});

  @override
  State<SideBarScreen> createState() => _SideBarScreenState();
}

class _SideBarScreenState extends State<SideBarScreen> {
  @override
  void initState() {
    // TODO: implement initState

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(kDebugMode){
        Provider.of<SideBarProvider>(context, listen: false).setIndex(0);
      }else{
        Provider.of<SideBarProvider>(context, listen: false).setIndex(0);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<SideBarProvider>(
        builder: (context, provider, child) {
          return Row(
            children: [
              // Sidebar
              Expanded(
                flex: 2,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xffFFFFFF),
                    border: Border(
                      right: BorderSide(
                        width: 1,
                        color: Color(
                          0xffE3E3E3,
                        ),
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                          height: 120,
                          width: 150,
                          child: Center(
                            child: Image.asset(
                              Assets.imagesAppLogo,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          "Main Menu",
                          style: getRegularStyle(
                            color: const Color(0xffC4C4C4),
                            fontSize: 14,
                          ),
                        ),
                      ),
                      padding20,

                      /// screens
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          children: provider.sideBarItems
                              .asMap()
                              .entries
                              .map((entry) {
                            int index = entry.key; // Get the index of the item
                            Map<String, dynamic> item =
                                entry.value; // Get the actual item

                            return InkWell(
                              overlayColor:
                                  WidgetStateProperty.all(Colors.transparent),
                              hoverColor: const Color(0xffF6F6F6),
                              onTap: () {
                                provider.setIndex(index);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: provider.selectedIndex == index
                                      ? const Color(0xffF6F6F6)
                                      : Colors.transparent,
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      item['icon']!,
                                      color: provider.selectedIndex == index
                                          ? Colors.black
                                          : const Color(0xffABABAB),
                                      size: 16,
                                    ), // Use the item's icon
                                    padding15,
                                    Text(
                                      item['name']!, // Use the item's name
                                      style: getMediumStyle(
                                        color: provider.selectedIndex == index
                                            ? Colors.black
                                            : const Color(0xffABABAB),
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),

                      /// logout button
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: InkWell(
                          overlayColor:
                              WidgetStateProperty.all(Colors.transparent),
                          hoverColor: const Color(0xffF6F6F6),
                          onTap: () {
                            HivePreferences.setIsLogin(false);
                            Get.offAll(LoginView());
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.logout,
                                  color: const Color(0xffABABAB),
                                  size: 16,
                                ), // Use the item's icon
                                padding15,
                                Text(
                                  'Logout', // Use the item's name
                                  style: getMediumStyle(
                                    color: const Color(0xffABABAB),
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Main content
              Expanded(
                flex: 8,
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: AppColors.bgColor,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Sidebar item name
                            Expanded(
                              child: Text(
                                provider.sideBarItems[provider.selectedIndex]
                                        ['name']
                                    .toString(),
                                style: getSemiBoldStyle(
                                  color: const Color(0xff1F1F1F),
                                  fontSize: 24,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            padding15,
                            // Create new event with icon
                            // Row(
                            //   children: [
                            //     Icon(
                            //       Icons.add_circle_outline_sharp,
                            //       color: AppColors.primaryColor,
                            //       size: 15,
                            //     ),
                            //     const SizedBox(width: 8),
                            //     Text(
                            //       'Create new event',
                            //       style: getRegularStyle(
                            //         color: AppColors.primaryColor,
                            //         fontSize: 12,
                            //       ),
                            //     ),
                            //   ],
                            // ),

                            padding20,
                            // Add space before the search field

                            // Search field
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Container(
                                height: 60,
                              ),
                            ),
                            padding20,

                            // Profile icon
                            Container(
                                height: 46,
                                width: 46,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 1,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                child: ClipOval(
                                    child: Image.asset(
                                  Assets.imagesAppLogo,
                                  fit: BoxFit.cover,
                                ))),
                          ],
                        ),
                      ),
                      const Divider(
                        height: 0,
                        thickness: 1,
                        color: Color(0xffE3E3E3),
                      ),
                      Expanded(
                        child: provider.currentScreen,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildStatCard(String title, String value, Color color) {
    return Card(
      elevation: 4,
      child: Container(
        width: 200,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(title, style: TextStyle(fontSize: 18, color: color)),
            const SizedBox(height: 10),
            Text(value, style: const TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }
}
