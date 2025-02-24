import 'package:chotu_admin/screens/riders/widgets/AddRiderAlert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:chotu_admin/providers/RealtorsProvider.dart';
import 'package:chotu_admin/utils/app_Colors.dart';
import 'package:chotu_admin/utils/app_Paddings.dart';
import 'package:chotu_admin/widgets/custom_TextField.dart';

import '../../generated/assets.dart';
import '../../utils/app_text_widgets.dart';
import 'widgets/ShowRiderPopupDialog.dart';

class AllRidersScreen extends StatelessWidget {
  const AllRidersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 5,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: CustomTextField(
                  width: MediaQuery.of(context).size.width,
                  title: '',
                  controller: TextEditingController(),
                  obscureText: false,
                  textInputAction: TextInputAction.search,
                  keyboardType: TextInputType.text,
                  hintText: 'Search riders by name, email',
                  suffixIcon: SizedBox(
                    height: 24,
                    width: 24,
                    child: Center(
                      child: SvgPicture.asset(Assets.iconsSearchnormal1),
                    ),
                  ),
                ),
              ),
              padding12,
              InkWell(
                onTap: () {
                  showAddRiderDialog(context);
                },
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.primaryColor,
                    ),
                    child: Text(
                      'Add New Rider',
                      style: getSemiBoldStyle(
                        color: AppColors.whiteColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          padding30,

          Expanded(
            child: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Color(0xffF1F1F1),
                      width: 1,
                    )),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: UserTable(),
                ),
              ),
            ),
          ),
          padding20,
        ],
      ),
    );
  }
}

class UserTable extends StatelessWidget {
  const UserTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RealtorProvider>(
      builder: (context, provider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Header Row
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    "User's Name",
                    style: getMediumStyle(
                        color: const Color(0xffABABAB), fontSize: 14),
                  ),
                ),
                padding15,
                Expanded(
                  flex: 3,
                  child: Text(
                    "Joining Date and User Frequency",
                    style: getMediumStyle(
                        color: const Color(0xffABABAB), fontSize: 14),
                  ),
                ),
                padding15,
                Expanded(
                  child: Center(
                    child: Text(
                      "Status",
                      style: getMediumStyle(
                          color: const Color(0xffABABAB), fontSize: 14),
                    ),
                  ),
                ),
                padding15,
                Expanded(
                  child: Center(
                    child: Text(
                      "Info",
                      style: getMediumStyle(
                          color: const Color(0xffABABAB), fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
            padding3,

            const Divider(
              color: Color(0xffF1F1F1),
              thickness: 1,
            ),
            // Custom divider

            padding3,
            // User Rows
            ListView.separated(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: provider.users.length,
              separatorBuilder: (context, index) => const Divider(
                color: Color(0xffF1F1F1),
                thickness: 1,
              ),
              itemBuilder: (context, index) {
                final user = provider.users[index];
                return Padding(
                  padding: EdgeInsets.only(top: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          user["name"]!,
                          style: getRegularStyle(
                              color: const Color(0xff1F1F1F), fontSize: 16),
                        ),
                      ),
                      padding15,
                      Expanded(
                        flex: 3,
                        child: Text(
                          user["info"]!,
                          style: getRegularStyle(
                              color: const Color(0xff1F1F1F), fontSize: 16),
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
                                value: user['status'],
                                dropdownColor: Colors.white,
                                isExpanded: false,
                                style: getMediumStyle(
                                  fontSize: 14,
                                  color: provider.getTextColor(user['status']),
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
                                          margin:
                                              const EdgeInsets.only(right: 10),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: provider
                                                .getStatusIndicatorColor(
                                                    status),
                                          ),
                                        ),
                                        // Status Text
                                        Text(
                                          status,
                                          style: getMediumStyle(
                                              color: Colors.black,
                                              fontSize: 14),
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
                          onTap: () {
                            showRealtorProfileDialog(context);
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
                                      color: AppColors.whiteColor,
                                      fontSize: 12),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
