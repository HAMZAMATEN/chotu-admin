import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:chotu_admin/generated/assets.dart';
import 'package:chotu_admin/providers/side_bar_provider.dart';
import 'package:chotu_admin/screens/realtors/review_screen.dart';
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
        child: Container(
          width: 370,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Close button
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: Container(
                        height: 34,
                        width: 34,
                        child: Center(child: Image.asset(Assets.iconsCross))),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                // User Image
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(
                    Assets
                        .imagesSAQFIRemovebgPreview, // Replace with user's image URL
                  ),
                ),
                padding5,
                // User Name and Role
                Text(
                  "Hassan Ali",
                  style: getMediumStyle(fontSize: 20, color: Colors.black),
                ),
                Text(
                  "Realtor/Hostess",
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
                      )),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Realtor Information',
                        style: getBoldStyle(color: Colors.black, fontSize: 20),
                      ),
                      padding10,
                      buildInfoRow("Currently Listed Properties", "57"),
                      buildInfoRow("Sold Properties", "0"),
                      buildInfoRow("Rented Properties (Short Term)", "2,326"),
                      buildInfoRow("Rented Properties (Long Term)", "1,326"),
                      buildInfoRow("All Time Listed Properties", "3,326"),
                      Consumer<SideBarProvider>(
                        builder: (context, provider, child) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Overall Ratings",
                                  style: getRegularStyle(
                                      fontSize: 14, color: Color(0xff7D7F88)),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                    provider.setScreen(
                                      const ReviewScreen(),
                                    );
                                  },
                                  child: Text(
                                    "Check Reviews",
                                    style: getMediumStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
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
