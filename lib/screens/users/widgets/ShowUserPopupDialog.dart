import 'package:chotu_admin/model/user_model.dart';
import 'package:chotu_admin/widgets/cache_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:chotu_admin/generated/assets.dart';
import 'package:chotu_admin/utils/app_Colors.dart';
import 'package:chotu_admin/utils/app_Paddings.dart';
import 'package:chotu_admin/utils/app_text_widgets.dart';
import 'package:chotu_admin/widgets/custom_Button.dart';

void showUserProfileDialog(UserModel user, BuildContext context) {
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
            child: SingleChildScrollView(
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
                      child: CacheImageWidget(imageUrl: user.profileImage),
                    ),
                  ),
                  padding5,
                  // User Name and Role
                  Text(
                    "${user.name}",
                    style: getMediumStyle(fontSize: 20, color: Colors.black),
                  ),
                  Text(
                    "${user.email}",
                    style: getRegularStyle(
                      fontSize: 15,
                      color: Color(0xffB5B8BC),
                    ),
                  ),
                  Text(
                    "${user.fullAddress}",
                    textAlign: TextAlign.center,
                    style: getRegularStyle(
                      fontSize: 15,
                      color: Color(0xffB5B8BC),
                    ),
                  ),
                  padding20,
                  // User Information
                  // Container(
                  //   decoration: BoxDecoration(
                  //       color: Color(0xffFDFDFD),
                  //       borderRadius: BorderRadius.circular(12),
                  //       boxShadow: [
                  //         BoxShadow(
                  //             color: Colors.black.withOpacity(0.2),
                  //             blurRadius: 4,
                  //             spreadRadius: 0,
                  //             offset: Offset(0, 4)),
                  //       ],
                  //       border: Border.all(
                  //         width: 1,
                  //         color: Colors.white,
                  //       )),
                  //   padding: const EdgeInsets.all(16),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       // Text(
                  //       //   'User\'s Information',
                  //       //   style: getBoldStyle(color: Colors.black, fontSize: 20),
                  //       // ),
                  //       // padding10,
                  //       // buildInfoRow("All Orders", "57"),
                  //       // buildInfoRow("Completed Orders", "50"),
                  //       // buildInfoRow("Canceled Orders", "5"),
                  //       // buildInfoRow("Active Orders", "2"),
                  //       // Padding(
                  //       //   padding: const EdgeInsets.symmetric(vertical: 4),
                  //       //   child: Row(
                  //       //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       //     children: [
                  //       //       Text(
                  //       //         'Overall History',
                  //       //         style: getRegularStyle(
                  //       //             fontSize: 14, color: const Color(0xff7D7F88)),
                  //       //       ),
                  //       //       InkWell(
                  //       //         onTap: () {
                  //       //           Navigator.pop(context);
                  //       //           context.read<SideBarProvider>().setScreen(
                  //       //                 const OrderHistoryScreen(),
                  //       //               );
                  //       //         },
                  //       //         child: Text(
                  //       //           'Check Now',
                  //       //           style: getSemiBoldStyle(
                  //       //             color: AppColors.primaryColor,
                  //       //             fontSize: 14,
                  //       //           ).copyWith(
                  //       //             decorationColor: AppColors.primaryColor,
                  //       //             decoration: TextDecoration.underline,
                  //       //           ),
                  //       //         ),
                  //       //       ),
                  //       //     ],
                  //       //   ),
                  //       // ),
                  //       /// top-up balance
                  //       // Padding(
                  //       //   padding: const EdgeInsets.symmetric(vertical: 4),
                  //       //   child: Row(
                  //       //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       //     children: [
                  //       //       Text(
                  //       //         'Top-Up Balance',
                  //       //         style: getRegularStyle(
                  //       //             fontSize: 14, color: const Color(0xff7D7F88)),
                  //       //       ),
                  //       //       InkWell(
                  //       //         onTap: () {
                  //       //           showTopUpDialog(context);
                  //       //
                  //       //         },
                  //       //         child: Text(
                  //       //           '200 (Add)',
                  //       //           style: getSemiBoldStyle(
                  //       //             color: AppColors.primaryColor,
                  //       //             fontSize: 14,
                  //       //           ).copyWith(
                  //       //             decorationColor: AppColors.primaryColor,
                  //       //             decoration: TextDecoration.underline,
                  //       //           ),
                  //       //         ),
                  //       //       ),
                  //       //     ],
                  //       //   ),
                  //       // ),
                  //     ],
                  //   ),
                  // ),
                  // padding10,
                  // User Joining Date
                  // Text(
                  //   "Joined at 14/12/2024 and is a frequent poster",
                  //   style: getMediumStyle(
                  //     color: Colors.black,
                  //     fontSize: 15,
                  //   ),
                  //   textAlign: TextAlign.center,
                  // ),
                  // padding15,
                  // Action Buttons
                  CustomButton(
                    height: 50,
                    width: double.infinity,
                    btnColor: user.status == 1 ? AppColors.primaryColor : Colors.red,
                    btnText: 'Status : ${user.status == 1 ? "Approved" : "Blocked"}',
                    btnTextColor: Colors.white,
                    onPress: (){},
                  ),
                    padding20,
                  CustomButton(
                    height: 50,
                    width: double.infinity,
                    btnColor: AppColors.primaryColor,
                    btnText: 'Close',
                    btnTextColor: Colors.white,
                    onPress: () {
                      Navigator.pop(context);
                    },
                  ),

                  const SizedBox(height: 8),
                  // TextButton(
                  //   onPressed: () {},
                  //   child: Text(
                  //     "Ban Profile",
                  //     style: getMediumStyle(
                  //       color: Colors.black,
                  //       fontSize: 17,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

/// show top up dialog
void showTopUpDialog(BuildContext context) {
  TextEditingController amountController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          "Add Balance",
          style: getMediumStyle(fontSize: 20, color: Colors.black),
        ),
        content: TextField(
          controller: amountController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: "Enter amount",
            border: OutlineInputBorder(),
          ),
          style: getRegularStyle(
            fontSize: 15,
            color: Color(0xffB5B8BC),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Cancel",
              style: getMediumStyle(
                color: Colors.black,
                fontSize: 15,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              String enteredAmount = amountController.text.trim();
              if (enteredAmount.isNotEmpty) {
                print("Amount added: $enteredAmount");
                Navigator.pop(context);
              }
            },
            child: Text(
              "Add",
              style: getMediumStyle(
                color: Colors.black,
                fontSize: 15,
              ),
            ),
          ),
        ],
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




