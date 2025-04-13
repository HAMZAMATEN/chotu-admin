import 'package:chotu_admin/providers/riders_provider.dart';
import 'package:chotu_admin/screens/riders/ShiftDetailScreen.dart';
import 'package:chotu_admin/widgets/ShowConformationAlert.dart';
import 'package:chotu_admin/widgets/cache_image_widget.dart';
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

import '../../../model/all_riders_model.dart';
import 'add_edit_rider_alert.dart';

void showRealtorProfileDialog(BuildContext context, Rider rider) {
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
          width: 420,
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
                      child: rider.profileImage != null
                          ? CacheImageWidget(imageUrl: rider.profileImage ?? "")
                          : const Image(
                              image: AssetImage(
                              Assets
                                  .imagesAppLogo, // Replace with user's image URL
                            )),
                    ),
                  ),
                  padding5,
                  // User Name and Role
                  Text(
                    rider.name.toString(),
                    style: getMediumStyle(fontSize: 20, color: Colors.black),
                  ),
                  padding12,
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
                          style:
                              getBoldStyle(color: Colors.black, fontSize: 20),
                        ),
                        padding10,
                        buildInfoRow("Email", rider.email ?? ""),
                        buildInfoRow("Phone Number", rider.mobileNo ?? ""),
                        buildInfoRow("CNIC", rider.nic ?? ""),

                        if (rider.city != null)
                          buildInfoRow("City", rider.city ?? ""),
                        if (rider.fullAddress != null)
                          buildInfoRow("Full Address", rider.fullAddress ?? ""),
                        if (rider.flatHouseNo != null)
                          buildInfoRow(
                              "Flat/House No", rider.flatHouseNo ?? ""),
                        if (rider.flatSocity != null)
                          buildInfoRow("Flat/Society", rider.flatSocity ?? ""),
                        if (rider.floor != null)
                          buildInfoRow("Floor", rider.floor ?? ""),

                        padding10,
                        // Container(
                        //   height: 25,
                        //   child: RatingBar.builder(
                        //     initialRating: 4,
                        //     minRating: 1,
                        //     direction: Axis.horizontal,
                        //     allowHalfRating: false,
                        //     unratedColor: Color(0xffd4d4d4),
                        //     itemCount: 5,
                        //     itemSize: 20,
                        //     itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                        //     itemBuilder: (context, _) => SvgPicture.asset(
                        //       Assets.iconsStar,
                        //       color: Color(0xffFFC700),
                        //     ),
                        //     onRatingUpdate: (rating) {},
                        //   ),
                        // ),
                        // padding15,
                      ],
                    ),
                  ),
                  // padding10,
                  // // User Joining Date
                  // Text(
                  //   "Joined at 14/12/2024 and is a frequent poster",
                  //   style: getMediumStyle(
                  //     color: Colors.black,
                  //     fontSize: 15,
                  //   ),
                  //   textAlign: TextAlign.center,
                  // ),
                  padding12,
                  // Action Buttons

                  CustomButton(
                    height: 50,
                    width: double.infinity,
                    btnColor: AppColors.primaryColor,
                    btnText: 'Update Profile',
                    btnTextColor: Colors.white,
                    onPress: () {
                      Provider.of<RidersProvider>(context, listen: false)
                          .getRiderUpdateData(rider);
                      Navigator.pop(context);
                      showAddEditRiderDialog(
                        context,
                        isEdit: true,
                        id: rider.id.toString(),
                      );
                    },
                  ),

                  const SizedBox(height: 8),
                  CustomButton(
                    height: 50,
                    width: double.infinity,
                    btnColor: Colors.transparent,
                    btnText: 'Remove Profile',
                    btnTextColor: AppColors.textColor,
                    onPress: () {
                      showCustomConfirmationDialog(
                          context: context,
                          message: "Do you really want to remove the rider?",
                          onConfirm: () {
                            Provider.of<RidersProvider>(context, listen: false)
                                .removeRiderFromDataBase(
                              context,
                              rider.id.toString(),
                            );
                          },
                          confirmText: "Yes, remove it!");
                    },
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
        Expanded(
          child: Text(
            title,
            style: getRegularStyle(fontSize: 14, color: Color(0xff7D7F88)),
          ),
        ),
        padding12,
        Expanded(
          flex: 2,
          child: Align(
            alignment: Alignment.topRight,
            child: Text(
              value,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: getSemiBoldStyle(
                color: Colors.black,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
