import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:chotu_admin/generated/assets.dart';
import 'package:chotu_admin/providers/dashboard_provider.dart';
import 'package:chotu_admin/screens/realtors/widgets/ShowRealtorPopupDialog.dart';
import 'package:chotu_admin/utils/app_Paddings.dart';
import 'package:chotu_admin/utils/app_text_widgets.dart';
import 'package:chotu_admin/widgets/custom_TextField.dart';

import '../../utils/app_Colors.dart';
import '../../utils/fonts_manager.dart';
import '../../widgets/custom_Button.dart';
import '../users/widgets/ShowUserPopupDialog.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 5,
        ),
        child: Column(
          children: [
            padding30,
            _buildTopSection(),
            padding20,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildAddPropertyTypesSection()),
                padding30,
                Expanded(child: _buildAddEventTypesSection()),
              ],
            ),
            padding20,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildLatestRequestSection()),
                padding30,
                Expanded(child: _buildSocialLinksSection()),
              ],
            ),
            padding20,
          ],
        ),
      ),
    );
  }

  Widget _buildAddPropertyTypesSection() {
    return Consumer<DashboardProvider>(
      builder: (context, provider, child) {
        return Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Color(0xffD9D9D9),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Property Types',
                    style:
                        getMediumStyle(color: Color(0xff1f1f1f), fontSize: 20),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      provider.togglePropertyCheckboxMode();
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: provider.showPropertyCheckboxes
                            ? Colors.grey
                            : Colors.redAccent,
                      ),
                      child: Center(
                        child: Text(
                          provider.showPropertyCheckboxes ? 'Cancel' : 'Delete',
                          style: getMediumStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  padding10,
                  if (!provider.showPropertyCheckboxes)
                    InkWell(
                      onTap: () {
                        showAdaptiveDialog(
                          context: context,
                          barrierDismissible: true,
                          // Allows closing the dialog by tapping outside
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
                                              child: Center(
                                                  child: Image.asset(
                                                      Assets.iconsCross))),
                                          onPressed: () =>
                                              Navigator.pop(context),
                                        ),
                                      ),
                                      // User Image
                                      padding5,
                                      // User Name and Role
                                      Text(
                                        "Add Property Type",
                                        style: getSemiBoldStyle(
                                            fontSize: 20, color: Colors.black),
                                      ),
                                      // User Information

                                      CustomTextField(
                                          title: '',
                                          controller: provider
                                              .addPropertyTypeController,
                                          obscureText: false,
                                          textInputAction: TextInputAction.done,
                                          keyboardType: TextInputType.text,
                                          hintText: 'Property Type'),

                                      padding20,
                                      // Action Buttons

                                      CustomButton(
                                        height: 50,
                                        width: double.infinity,
                                        btnColor: Colors.green,
                                        btnText: 'Add',
                                        btnTextColor: Colors.white,
                                        onPress: () {
                                          if (provider.addPropertyTypeController
                                              .text.isNotEmpty) {
                                            provider.addProperty(
                                                provider
                                                    .addPropertyTypeController
                                                    .text,
                                                context);
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.green,
                        ),
                        child: Center(
                          child: Text(
                            'Add New',
                            style: getMediumStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  SizedBox(width: 5),
                  if (provider.showPropertyCheckboxes)
                    InkWell(
                      onTap: () {
                        _showConfirmationDialog(context, provider);
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.blueAccent,
                        ),
                        child: Center(
                          child: Text(
                            'Confirm',
                            style: getMediumStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(height: 20),
              Wrap(
                spacing: 10.0,
                runSpacing: 8.0,
                children: provider.propertyTypes
                    .map((e) => _buildPropertyTypeButton(e, provider))
                    .toList(),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPropertyTypeButton(String label, DashboardProvider provider) {
    return GestureDetector(
      onTap: provider.showPropertyCheckboxes
          ? () {
              provider.togglePropertySelection(label);
            }
          : null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (provider.showPropertyCheckboxes)
            Checkbox(
              activeColor: AppColors.primaryColor,
              value: provider.selectedPropertyTypes.contains(label),
              onChanged: (_) {
                provider.togglePropertySelection(label);
              },
            ),
          Container(
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(width: 1.5, color: AppColors.transparentColor),
            ),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Text(
              label,
              style: getSemiBoldStyle(
                color: Colors.white,
                fontSize: MyFonts.size12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showConfirmationDialog(
      BuildContext context, DashboardProvider provider) {
    showAdaptiveDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
              child: Text(
            'Confirm Deletion',
            style: getSemiBoldStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          )),
          content: Text(
            'Are you sure you want to delete the selected properties?',
            style: getMediumStyle(color: Colors.black),
          ),
          actions: [
            InkWell(
              overlayColor: WidgetStateColor.transparent,
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey,
                ),
                child: Text(
                  'Cancel',
                  style: getMediumStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            InkWell(
              overlayColor: WidgetStateColor.transparent,
              onTap: () {
                provider.deleteSelectedProperties(context);
                Navigator.pop(context);
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8), color: Colors.red),
                child: Text(
                  'Confirm',
                  style: getMediumStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildAddEventTypesSection() {
    return Consumer<DashboardProvider>(
      builder: (context, provider, child) {
        return Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Color(0xffD9D9D9),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Event Types',
                    style:
                        getMediumStyle(color: Color(0xff1f1f1f), fontSize: 20),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      provider.toggleEventCheckboxMode();
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: provider.showEventCheckboxes
                            ? Colors.grey
                            : Colors.redAccent,
                      ),
                      child: Center(
                        child: Text(
                          provider.showEventCheckboxes ? 'Cancel' : 'Delete',
                          style: getMediumStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  padding10,
                  if (!provider.showEventCheckboxes)
                    InkWell(
                      onTap: () {
                        showAdaptiveDialog(
                          context: context,
                          barrierDismissible: true,
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
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: IconButton(
                                          icon: Container(
                                            height: 34,
                                            width: 34,
                                            child: Center(
                                              child: Image.asset(
                                                Assets.iconsCross,
                                              ),
                                            ),
                                          ),
                                          onPressed: () =>
                                              Navigator.pop(context),
                                        ),
                                      ),
                                      padding5,
                                      Text(
                                        "Add Event Type",
                                        style: getSemiBoldStyle(
                                            fontSize: 20, color: Colors.black),
                                      ),
                                      CustomTextField(
                                        title: '',
                                        controller:
                                            provider.addEventTypeController,
                                        obscureText: false,
                                        textInputAction: TextInputAction.done,
                                        keyboardType: TextInputType.text,
                                        hintText: 'Event Type',
                                      ),
                                      padding20,
                                      CustomButton(
                                        height: 50,
                                        width: double.infinity,
                                        btnColor: Colors.green,
                                        btnText: 'Add',
                                        btnTextColor: Colors.white,
                                        onPress: () {
                                          if (provider.addEventTypeController
                                              .text.isNotEmpty) {
                                            provider.addEvent(
                                                provider.addEventTypeController
                                                    .text,
                                                context);
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.green,
                        ),
                        child: Center(
                          child: Text(
                            'Add New',
                            style: getMediumStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  SizedBox(width: 5),
                  if (provider.showEventCheckboxes)
                    InkWell(
                      onTap: () {
                        _showEventConfirmationDialog(context, provider);
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.blueAccent,
                        ),
                        child: Center(
                          child: Text(
                            'Confirm',
                            style: getMediumStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(height: 20),
              Wrap(
                spacing: 10.0,
                runSpacing: 8.0,
                children: provider.eventTypes
                    .map((e) => _buildEventTypeButton(e, provider))
                    .toList(),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEventTypeButton(String label, DashboardProvider provider) {
    return GestureDetector(
      onTap: provider.showEventCheckboxes
          ? () {
              provider.toggleEventSelection(label);
            }
          : null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (provider.showEventCheckboxes)
            Checkbox(
              activeColor: AppColors.primaryColor,
              value: provider.selectedEventTypes.contains(label),
              onChanged: (_) {
                provider.toggleEventSelection(label);
              },
            ),
          Container(
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(width: 1.5, color: AppColors.transparentColor),
            ),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Text(
              label,
              style: getSemiBoldStyle(
                color: Colors.white,
                fontSize: MyFonts.size12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showEventConfirmationDialog(
      BuildContext context, DashboardProvider provider) {
    showAdaptiveDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
              child: Text(
            'Confirm Deletion',
            style: getSemiBoldStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          )),
          content: Text(
            'Are you sure you want to delete the selected events?',
            style: getMediumStyle(color: Colors.black),
          ),
          actions: [
            InkWell(
              overlayColor: WidgetStateColor.transparent,
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey,
                ),
                child: Text(
                  'Cancel',
                  style: getMediumStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            InkWell(
              overlayColor: WidgetStateColor.transparent,
              onTap: () {
                provider.deleteSelectedEvents(context);
                Navigator.pop(context);
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8), color: Colors.red),
                child: Text(
                  'Confirm',
                  style: getMediumStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTopSection() {
    return Row(
      children: [
        Expanded(
          child: _buildTopCard(
              imgPath: Assets.iconsRevenue,
              title: 'Revenue',
              amount: '166,580',
              increase: '5%'),
        ),
        padding30,
        Expanded(
          child: _buildTopCard(
              imgPath: Assets.iconsProduct,
              title: 'Product Sold',
              amount: '5,679',
              increase: '2%'),
        ),
        padding30,
        Expanded(
          child: _buildTopCard(
              imgPath: Assets.iconsCustomer,
              title: 'Customers',
              amount: '51,580',
              increase: '4%'),
        ),
      ],
    );
  }

  Widget _buildTopCard({
    required String imgPath,
    required String title,
    required String amount,
    required String increase,
  }) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Color(0xffD9D9D9))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 24,
                width: 24,
                child: Center(child: Image.asset(imgPath)),
              ),
              padding5,
              Text(
                title,
                style: getRegularStyle(
                  color: Color(0xff1f1f1f),
                  fontSize: 16,
                ),
              ),
            ],
          ),
          padding10,
          Text(
            '$amount YER',
            style: getMediumStyle(color: Color(0xff1f1f1f), fontSize: 32),
          ),
          padding10,
          Row(
            children: [
              Container(
                height: 24,
                width: 24,
                child: Center(
                  child: SvgPicture.asset(
                    Assets.iconsTrendup,
                  ),
                ),
              ),
              Text(
                increase,
                style: getMediumStyle(
                  color: Color(0xffFF4D4D),
                  fontSize: 16,
                ),
              ),
              Text(
                ' in the last 1 month',
                style: getRegularStyle(
                  color: Color(0xffABABAB),
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLatestRequestSection() {
    return Consumer<DashboardProvider>(
      builder: (context, provider, child) {
        return Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Color(
                0xffD9D9D9,
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Latest Requests',
                    style:
                        getMediumStyle(color: Color(0xff1f1f1f), fontSize: 20),
                  ),
                  Spacer(),
                  Container(
                    height: 40,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0xffFAFAFA),
                      border: Border.all(
                        color: Color(0xffdddddd),
                        width: 1,
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        icon: null,
                        value: provider.selectedStatus,
                        dropdownColor: Colors.white,
                        isExpanded: false,
                        style: getMediumStyle(
                          fontSize: 14,
                          color: Color(0xff8F8F8F),
                        ),
                        items: provider.statuses.map((status) {
                          return DropdownMenuItem<String>(
                            value: status,
                            child: Text(
                              status,
                              style: getMediumStyle(
                                  color: Colors.black, fontSize: 14),
                            ),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          if (newValue != null) {
                            provider.setSelectedStatus(newValue);
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
              padding20,
              UserTable(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSocialLinksSection() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Color(
            0xffD9D9D9,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Link to Play & App store',
            style: getMediumStyle(color: Color(0xff1f1f1f), fontSize: 20),
          ),
          padding20,
          CustomTextField(
              title: 'Link of the app at play store',
              controller: TextEditingController(
                text: 'https://www.playstore.com/app/Saqfi',
              ),
              obscureText: false,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              suffixIcon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'copy link',
                  style: getMediumStyle(color: Color(0xffEA4649), fontSize: 14),
                ),
              ),
              hintText: ''),
          padding20,
          CustomTextField(
              title: 'Link of the app at app store',
              suffixIcon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'copy link',
                  style: getMediumStyle(color: Color(0xffEA4649), fontSize: 14),
                ),
              ),
              controller: TextEditingController(
                text: 'https://www.playstore.com/app/Saqfi',
              ),
              obscureText: false,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              hintText: ''),
          padding20,
          Row(
            children: [
              Container(
                height: 60,
                width: 150,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage(
                    Assets.imagesPlayStore,
                  ),
                  fit: BoxFit.cover,
                )),
              ),
              Container(
                height: 52,
                width: 150,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage(
                    Assets.imagesAppStore,
                  ),
                  fit: BoxFit.cover,
                )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class UserTable extends StatelessWidget {
  const UserTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> users = [
      {
        "name": "Eleanor Pena",
        "info": "Joined at 25/4/2024 and is a very frequent user",
        "button": "See"
      },
      {
        "name": "Wade Warren",
        "info": "Joined at 15/12/2024 and is a non frequent user",
        "button": "See"
      },
      {
        "name": "Wade Warren",
        "info": "Joined at 15/12/2024 and is a non frequent user",
        "button": "See"
      },
      {
        "name": "Wade Warren",
        "info": "Joined at 15/12/2024 and is a non frequent user",
        "button": "See"
      },
      {
        "name": "Wade Warren",
        "info": "Joined at 15/12/2024 and is a non frequent user",
        "button": "See"
      },
    ];

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
                    color: const Color(0xffABABAB), fontSize: 12),
              ),
            ),
            padding15,
            Expanded(
              flex: 3,
              child: Text(
                "Joining Date and User Frequency",
                style: getMediumStyle(
                    color: const Color(0xffABABAB), fontSize: 12),
              ),
            ),
            padding15,
            Expanded(
              child: Center(
                child: Text(
                  "Info",
                  style: getMediumStyle(
                      color: const Color(0xffABABAB), fontSize: 12),
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
          itemCount: users.length,
          separatorBuilder: (context, index) => const Divider(
            color: Color(0xffF1F1F1),
            thickness: 1,
          ),
          itemBuilder: (context, index) {
            final user = users[index];
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
                          color: const Color(0xff1F1F1F), fontSize: 14),
                    ),
                  ),
                  padding15,
                  Expanded(
                    flex: 3,
                    child: Text(
                      user["info"]!,
                      style: getRegularStyle(
                          color: const Color(0xff1F1F1F), fontSize: 14),
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
                                  color: AppColors.whiteColor, fontSize: 10),
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
  }
}
