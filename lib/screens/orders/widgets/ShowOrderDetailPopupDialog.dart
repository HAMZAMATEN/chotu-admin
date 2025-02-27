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

void showOrderDetailDialog(BuildContext context) {
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
                  /// app logo
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
                  padding20,
                  /// Order Information
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
                          'Order Information',
                          style: getBoldStyle(color: Colors.black, fontSize: 20),
                        ),
                        padding10,
                        buildInfoRow("Orders No", "57"),
                        buildInfoRow("User Name", "User"),
                        buildInfoRow("Orders Assigned To", "Rider"),
                        buildInfoRow("Order Status", "Pending"),
                        buildInfoRow("Total Price", "13000 PKR"),
                        buildInfoRow("Order Date", "10/2/23"),

                        padding15,
                      ],
                    ),
                  ),
                  padding10,
                  // User Joining Date
                  padding15,
                  // Action Buttons

                  CustomButton(
                    height: 50,
                    width: double.infinity,
                    btnColor: AppColors.primaryColor,
                    btnText: 'Pending',
                    btnTextColor: Colors.white,
                    onPress: () {},
                  ),

                  const SizedBox(height: 8),
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
