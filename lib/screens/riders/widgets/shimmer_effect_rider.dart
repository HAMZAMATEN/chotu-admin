
import 'package:chotu_admin/providers/riders_provider.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../providers/users_provider.dart';
import '../../../utils/app_Colors.dart';
import '../../../utils/app_Paddings.dart';
import '../../../utils/app_text_widgets.dart';

Widget shimmerRiderTile(Map<String, dynamic> user, RidersProvider provider,
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
                              color: provider.getStatusIndicatorColor("Approved"),
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