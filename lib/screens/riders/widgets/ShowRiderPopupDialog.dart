import 'package:chotu_admin/screens/riders/ShiftDetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:chotu_admin/generated/assets.dart';
import 'package:chotu_admin/providers/side_bar_provider.dart';
import 'package:chotu_admin/screens/riders/review_screen.dart';
import 'package:chotu_admin/utils/app_Colors.dart';
import 'package:chotu_admin/utils/app_Paddings.dart';
import 'package:chotu_admin/utils/app_text_widgets.dart';
import 'package:chotu_admin/widgets/custom_Button.dart';

void showRealtorProfileDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true, // Allows closing the dialog by tapping outside
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: SizedBox(
          width: 370,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Close button
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: SizedBox(
                          height: 34,
                          width: 34,
                          child: Center(child: Image.asset(Assets.iconsCross))),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  // User Image
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.textFieldBorderColor,
                      ),
                      borderRadius: BorderRadius.circular(
                        50,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        50,
                      ),
                      child: const Image(
                          image: AssetImage(
                        Assets.imagesAppLogo, // Replace with user's image URL
                      )),
                    ),
                  ),
                  padding5,
                  // User Name and Role
                  Text(
                    "John Doe",
                    style: getMediumStyle(fontSize: 20, color: Colors.black),
                  ),
                  Text(
                    "Rider",
                    style: getRegularStyle(
                      fontSize: 15,
                      color: Color(0xffB5B8BC),
                    ),
                  ),
                  padding20,
                  // User Information
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xffFDFDFD),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 4,
                            spreadRadius: 0,
                            offset: Offset(0, 4)),
                      ],
                      border: Border.all(
                        width: 1,
                        color: Colors.white,
                      ),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Rider Information',
                          style: getBoldStyle(color: Colors.black, fontSize: 20),
                        ),
                        padding10,
                        buildInfoRow("Orders Assigned", "57"),
                        buildInfoRow("Orders Completed", "57"),
                        buildInfoRow("Order Pending", "0"),
                        buildInfoRow("Behaviour", "90%"),
                        buildInfoRow("Shift Work", "100%"),
                        buildInfoRow("Total Earnings", "13000 PKR"),
                        // Consumer<SideBarProvider>(
                        //   builder: (context, provider, child) {
                        //     return Padding(
                        //       padding: const EdgeInsets.symmetric(vertical: 4),
                        //       child: Row(
                        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //         children: [
                        //           Text(
                        //             "Overall Ratings",
                        //             style: getRegularStyle(
                        //                 fontSize: 14, color: Color(0xff7D7F88)),
                        //           ),
                        //           InkWell(
                        //             onTap: () {
                        //               Navigator.pop(context);
                        //               provider.setScreen(
                        //                 const ReviewScreen(),
                        //               );
                        //             },
                        //             child: Text(
                        //               "Check Reviews",
                        //               style: getMediumStyle(
                        //                 color: Colors.black,
                        //                 fontSize: 14,
                        //               ),
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //     );
                        //   },
                        // ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Shift Details',
                                style: getRegularStyle(
                                    fontSize: 14, color: const Color(0xff7D7F88)),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                  context.read<SideBarProvider>().setScreen(
                                    const ShiftDetailScreen(),
                                  );
                                },
                                child: Text(
                                  'Check Now',
                                  style: getSemiBoldStyle(
                                    color: AppColors.primaryColor,
                                    fontSize: 14,
                                  ).copyWith(
                                    decorationColor: AppColors.primaryColor,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        padding10,
                        Container(
                          height: 25,
                          child: RatingBar.builder(
                            initialRating: 4,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: false,
                            unratedColor: Color(0xffd4d4d4),
                            itemCount: 5,
                            itemSize: 20,
                            itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                            itemBuilder: (context, _) => SvgPicture.asset(
                              Assets.iconsStar,
                              color: Color(0xffFFC700),
                            ),
                            onRatingUpdate: (rating) {},
                          ),
                        ),
                        padding15,
                      ],
                    ),
                  ),
                  padding10,
                  // User Joining Date
                  Text(
                    "Joined at 14/12/2024 and is a frequent poster",
                    style: getMediumStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  padding15,
                  // Action Buttons

                  CustomButton(
                    height: 50,
                    width: double.infinity,
                    btnColor: AppColors.primaryColor,
                    btnText: 'Contact',
                    btnTextColor: Colors.white,
                    onPress: () {},
                  ),

                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Ban Profile",
                      style: getMediumStyle(
                        color: Colors.black,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

Widget buildInfoRow(String title, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: getRegularStyle(fontSize: 14, color: Color(0xff7D7F88)),
        ),
        Text(
          value,
          style: getMediumStyle(
            color: Colors.black,
            fontSize: 14,
          ),
        ),
      ],
    ),
  );
}
