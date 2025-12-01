import 'package:chotu_admin/model/user_model.dart';
import 'package:chotu_admin/providers/users_provider.dart';
import 'package:chotu_admin/screens/users/widgets/ShowUserPopupDialog.dart';
import 'package:chotu_admin/utils/app_Paddings.dart';
import 'package:chotu_admin/utils/app_text_widgets.dart';
import 'package:chotu_admin/utils/toast_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utils/app_colors.dart';
import '../../../widgets/ShowConformationAlert.dart';

class UserListTile extends StatefulWidget {
  UserModel userModel;

  UserListTile({super.key, required this.userModel});

  @override
  State<UserListTile> createState() => _UserListTileState();
}

class _UserListTileState extends State<UserListTile> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            widget.userModel.name ?? "",
            style:
                getRegularStyle(color: const Color(0xff1F1F1F), fontSize: 16),
          ),
        ),
        padding15,
        Expanded(
          flex: 3,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                textAlign: TextAlign.start,
                widget.userModel.email ?? "",
                style: getRegularStyle(
                    color: const Color(0xff1F1F1F), fontSize: 16),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                textAlign: TextAlign.start,
                widget.userModel.mobileNo ?? "",
                style: getRegularStyle(
                    color: const Color(0xff1F1F1F), fontSize: 16),
              ),
            ],
          ),
        ),
        padding15,
        Expanded(
          child: Center(
            child: Consumer<UsersProvider>(builder: (context, provider, child) {
              return Container(
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: provider.getStatusColor(widget.userModel.status ?? 0),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    icon: null,
                    value: provider.statuses[widget.userModel.status ?? 0],
                    dropdownColor: Colors.white,
                    isExpanded: false,
                    style: getMediumStyle(
                      fontSize: 14,
                      color:
                          provider.getTextColor(widget.userModel.status ?? 0),
                    ),
                    items: provider.statuses.map((status) {
                      return DropdownMenuItem<String>(
                        value: status,
                        child: Row(
                          children: [
                            // Circle Indicator
                            Container(
                              height: 10,
                              width: 10,
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: provider.getStatusIndicatorColor(status),
                              ),
                            ),
                            // Status Text
                            Text(
                              status,
                              style: getMediumStyle(
                                  color: Colors.black, fontSize: 14),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (newValue) async {
                      print("old val ::: ${widget.userModel.status}");

                      String oldVal =
                          widget.userModel.status == 1 ? "Approved" : "Blocked";

                      if (oldVal != newValue) {
                        showCustomConfirmationDialog(
                            context: context,
                            message:
                                "Do you really want to change status\nfrom $oldVal to $newValue?",
                            onConfirm: () async {
                              if (newValue != null) {
                                print("NEW CHANGED VALUE IS ${newValue}");
                                if ((newValue == "Approved" &&
                                        widget.userModel.status == 1) ||
                                    (newValue == "Blocked" &&
                                        widget.userModel.status == 0)) {
                                  // do nothing if the status are already set
                                } else {
                                  ShowToastDialog.showLoader("Please wait");
                                  await provider
                                      .updateUserStatus(widget.userModel);
                                }
                              }
                            },
                            confirmText: "Yes, change it!");
                      }
                    },
                  ),
                ),
              );
            }),
          ),
        ),
        padding15,
        Expanded(
          child: InkWell(
            onTap: () {
              showUserProfileDialog(widget.userModel, context);
            },
            child: Center(
              child: Container(
                height: 40,
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.primaryColor.withOpacity(.7),
                ),
                child: Center(
                  child: Text(
                    'See More',
                    style: getMediumStyle(
                        color: AppColors.whiteColor, fontSize: 12),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Widget shimmerUserTile(Map<String, dynamic> user, UsersProvider provider,
    int index, BuildContext context) {
  return Shimmer.fromColors(
    baseColor: AppColors.baseColor,
    highlightColor: AppColors.highlightColor,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            user["name"]!,
            style:
                getRegularStyle(color: const Color(0xff1F1F1F), fontSize: 16),
          ),
        ),
        padding15,
        Expanded(
          flex: 3,
          child: Text(
            user["info"]!,
            style:
                getRegularStyle(color: const Color(0xff1F1F1F), fontSize: 16),
          ),
        ),
        padding15,
        Expanded(
          child: Center(
            child: Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: provider.getStatusColor(user['status']),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  icon: null,
                  value: "Approved",
                  dropdownColor: Colors.white,
                  isExpanded: false,
                  style: getMediumStyle(
                    fontSize: 14,
                    color: Colors.green.withOpacity(0.4),
                  ),
                  items: provider.statuses.map((status) {
                    return DropdownMenuItem<String>(
                      value: status,
                      child: Row(
                        children: [
                          // Circle Indicator
                          Container(
                            height: 10,
                            width: 10,
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color:
                                  provider.getStatusIndicatorColor("Approved"),
                            ),
                          ),
                          // Status Text
                          Text(
                            status,
                            style: getMediumStyle(
                                color: Colors.black, fontSize: 14),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    if (newValue != null) {
                      provider.updateStatus(index, newValue);
                    }
                  },
                ),
              ),
            ),
          ),
        ),
        padding15,
        Expanded(
          child: InkWell(
            child: Center(
              child: Container(
                height: 40,
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.primaryColor.withOpacity(.7),
                ),
                child: Center(
                  child: Text(
                    'See More',
                    style: getMediumStyle(
                        color: AppColors.whiteColor, fontSize: 12),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
