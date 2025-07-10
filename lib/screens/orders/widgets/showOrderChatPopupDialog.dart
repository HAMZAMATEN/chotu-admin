import 'package:cached_network_image/cached_network_image.dart';
import 'package:chotu_admin/generated/assets.dart';
import 'package:chotu_admin/utils/app_Colors.dart';
import 'package:chotu_admin/utils/app_Paddings.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../model/all_orders_model.dart';
import '../../../utils/app_text_widgets.dart';

void showOrderChatPopupDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {

      return Dialog(
        insetPadding: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          width: 600,
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Loop through each store
              Align(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.cancel_outlined,
                        color: AppColors.textColor,
                      ),
                    ),
                    padding6,
                    Text(
                      "Order Chat",
                      style: getBoldStyle(
                        color: AppColors.textColor,
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
              ),

              const Divider(height: 18),
              /// Chat Messages
              Container(
                height: 370,

                child: ListView(
                  children: [
                    _buildChatBubble(
                        message:
                        "Hi ! Send me order details?",
                        time: "20 June 2025 9:15 AM",
                        isUser: true,
                        sender: "Hamza",
                        backgroundColor:  Color(0xff45CF8D),
                        textColor:  AppColors.whiteColor,
                        context: context

                    ),
                    _buildChatBubble(
                        message:
                        "Yes, it's been completed. I’ll send you the details shortly.",
                        time: "20 June 2025 9:17 AM",
                        isUser: false,
                        sender: "Zain",
                        backgroundColor: AppColors.whiteColor,
                        textColor: AppColors.blackColor,
                        context: context

                    ),
                    _buildChatBubble(
                        message:
                        "Hi there !",
                        time: "20 June 2025 9:20 AM",
                        isUser: true,
                        sender: "Hamza",
                        backgroundColor:  Color(0xff45CF8D),
                        textColor: AppColors.whiteColor,
                        context: context

                    ),


                    _buildChatBubble(
                        message:
                        "Hi there ??",
                        time: "20 June 2025 9:20 AM",
                        isUser: true,
                        sender: "Hamza",
                        backgroundColor:  Color(0xff45CF8D),
                        textColor: AppColors.whiteColor,

                        context: context

                    ),
                    _buildChatBubble(
                        message:
                        "Yes",
                        time: "20 June 2025 9:17 AM",
                        isUser: false,
                        sender: "Zain",
                        backgroundColor: AppColors.whiteColor,
                        textColor: AppColors.blackColor,
                        context: context

                    ),


                  ],
                ),
              ),
              padding12,



            ],
          ),
        ),
      );
    },
  );
}
/// build chat bubble
Widget _buildChatBubble({
  required BuildContext context,
  required String message,
  required String time,
  required bool isUser,
  required String sender,
  required Color backgroundColor,
  Color textColor = Colors.white,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8),
    alignment: isUser ? Alignment.centerLeft : Alignment.centerRight,


    child: Column(
      crossAxisAlignment:
      isUser ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [


        Row(
          mainAxisAlignment:
          isUser ? MainAxisAlignment.start : MainAxisAlignment.end,
          children: [

            /// sender icon or image
            if (isUser)
              CircleAvatar(radius: 14,backgroundColor: AppColors.blackColor, child: Icon(Icons.person,color: AppColors.whiteColor,)),
            padding8,
            /// message and time
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.45,
              ),
              child: IntrinsicWidth(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color:AppColors.blackColor.withOpacity(0.1),
                        offset: const Offset(0, 2),
                        blurRadius: 2.0,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        message,
                        style: getRegularStyle(
                          color: textColor,
                          fontSize: 12,
                        ),
                      ),
                      padding6,
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          time,
                          style: getMediumStyle(fontSize: 10, color: Colors.black54),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            padding8,
            if (!isUser)
              CircleAvatar(radius: 14,backgroundColor: AppColors.blackColor, child:  Icon(Icons.person,color: AppColors.whiteColor,)),
          ],
        ),

      ],
    ),
  );
}