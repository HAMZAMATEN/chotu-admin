import 'package:chotu_admin/model/category_model.dart';
import 'package:chotu_admin/model/user_model.dart';
import 'package:chotu_admin/providers/categories_provider.dart';
import 'package:chotu_admin/providers/users_provider.dart';
import 'package:chotu_admin/utils/toast_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:chotu_admin/screens/users/widgets/ShowUserPopupDialog.dart';
import 'package:chotu_admin/utils/app_Paddings.dart';
import 'package:chotu_admin/utils/app_text_widgets.dart';
import 'package:chotu_admin/widgets/custom_TextField.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utils/app_colors.dart';
import '../../../widgets/ShowConformationAlert.dart';

class CategoryListTile extends StatefulWidget {
  CategoryModel categoryModel;

  CategoryListTile({super.key, required this.categoryModel});

  @override
  State<CategoryListTile> createState() => _CategoryListTileState();
}

class _CategoryListTileState extends State<CategoryListTile> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            widget.categoryModel.id.toString(),
            style:
                getRegularStyle(color: const Color(0xff1F1F1F), fontSize: 16),
          ),
        ),
        padding15,
        Expanded(
          flex: 2,
          child: Text(
            widget.categoryModel?.name??"",
            style:
                getRegularStyle(color: const Color(0xff1F1F1F), fontSize: 16),
          ),
        ),
        padding15,
        Expanded(
          flex: 2,
          child: Center(
            child: Consumer<CategoriesProvider>(
                builder: (context, provider, child) {
              return Container(
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: provider.getStatusColor(widget.categoryModel?.status??0),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    icon: null,
                    value: provider.statuses[widget.categoryModel?.status??0],
                    dropdownColor: Colors.white,
                    isExpanded: false,
                    style: getMediumStyle(
                      fontSize: 14,
                      color: provider.getTextColor(widget.categoryModel?.status??0),
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
                      if (newValue != null) {
                        print("old val ::: ${widget.categoryModel.status}");
                        print("new val ::: ${newValue}");

                        String oldVal = widget.categoryModel.status == 1
                            ? "Approved"
                            : "Blocked";

                        print("old:::$oldVal");
                        print("new:::$newValue");

                        if (oldVal != newValue) {
                          showCustomConfirmationDialog(
                              context: context,
                              message:
                                  "Do you really want to change status\nfrom $oldVal to $newValue?",
                              onConfirm: () async {
                                if (newValue != null) {
                                  print("NEW CHANGED VALUE IS ${newValue}");
                                  if ((newValue == "Approved" &&
                                          widget.categoryModel.status == 1) ||
                                      (newValue == "Blocked" &&
                                          widget.categoryModel.status == 0)) {
                                    // do nothing if the status are already set
                                  } else {
                                    ShowToastDialog.showLoader("Please wait");

                                    await provider.updateCategoryStatus(
                                        widget.categoryModel);
                                  }
                                }
                              },
                              confirmText: "Yes, change it!");
                        }
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
          flex: 2,
          child: Center(
            child: Consumer<CategoriesProvider>(
              builder: (context, provider, child) {
                return InkWell(
                  overlayColor: WidgetStatePropertyAll(Colors.transparent),
                  onTap: () async {
                    showCustomConfirmationDialog(
                        context: context,
                        message: "Do you really want to delete this category?",
                        onConfirm: () async {
                          await provider.deleteCategory(widget.categoryModel);
                        },
                        confirmText: "Yes, delete it!");
                  },
                  child: Container(
                    height: 40,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.red.withOpacity(0.4),
                    ),
                    child: Center(
                      child: Text(
                        'Delete',
                        style: getMediumStyle(
                          color: AppColors.textColor,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

Widget shimmerCategoryTile(Map<String, dynamic> category,
    CategoriesProvider provider, int index, BuildContext context) {
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
            category["index"]!.toString(),
            style:
                getRegularStyle(color: const Color(0xff1F1F1F), fontSize: 16),
          ),
        ),
        padding15,
        Expanded(
          flex: 2,
          child: Text(
            category["name"]!,
            style:
                getRegularStyle(color: const Color(0xff1F1F1F), fontSize: 16),
          ),
        ),
        padding15,
        Expanded(
          flex: 2,
          child: Center(
            child: Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: provider.getStatusColor(category['status']),
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
          flex: 2,
          child: Center(
            child: Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.red.withOpacity(0.4),
              ),
              child: Center(
                child: Text('Delete'),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
