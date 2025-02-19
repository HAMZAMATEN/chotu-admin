import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chotu_admin/providers/additional_settings_provider.dart';

import '../../generated/assets.dart';
import '../../utils/app_Colors.dart';
import '../../utils/app_Paddings.dart';
import '../../utils/app_text_widgets.dart';
import '../../widgets/custom_Button.dart';
import '../../widgets/custom_TextField.dart';

class AboutAndContactUsScreen extends StatelessWidget {
  const AboutAndContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _aboutUs(),
        padding20,
        _contactUs(),
      ],
    );
  }

  Widget _aboutUsSection({required String title, required String description}) {
    return Consumer<AdditionalSettingsProvider>(
      builder: (context, provider, child) {
        return InkWell(
          onTap: provider.showAboutUsCheckboxes
              ? () {
                  provider.toggleAboutUsSelection({
                    "title": title,
                    "description": description,
                  });
                }
              : null,
          child: Row(
            children: [
              if (provider.showAboutUsCheckboxes)
                Checkbox(
                  activeColor: AppColors.primaryColor,
                  value: provider.selectedAboutUsContent.contains(
                    jsonEncode(
                      {
                        "title": title,
                        "description": description,
                      },
                    ),
                  ),
                  onChanged: (_) {
                    provider.toggleAboutUsSelection({
                      "title": title,
                      "description": description,
                    });

                    print(provider.selectedAboutUsContent.contains({
                      "title": title,
                      "description": description,
                    }));
                  },
                ),
              if (provider.showAboutUsCheckboxes)
                SizedBox(
                  width: 5,
                ),
              Expanded(
                child: Container(
                  padding:
                      EdgeInsets.only(left: 20, top: 20, bottom: 20, right: 70),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      width: 1,
                      color: Color(0xffE5E8EC),
                    ),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 0),
                        blurRadius: 2,
                        spreadRadius: 0,
                        color: Color(0x00000008),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // App Description
                      Text(
                        title,
                        style: getBoldStyle(
                            fontSize: 22, color: AppColors.blackColor),
                      ),
                      SizedBox(height: 10),
                      Text(
                        description,
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _contactUsSection(
      {required String title, required String description}) {
    return Consumer<AdditionalSettingsProvider>(
      builder: (context, provider, child) {
        return InkWell(
          onTap: provider.showContactUsCheckboxes
              ? () {
                  provider.toggleContactUsSelection({
                    "title": title,
                    "description": description,
                  });
                }
              : null,
          child: Row(
            children: [
              if (provider.showContactUsCheckboxes)
                Checkbox(
                  activeColor: AppColors.primaryColor,
                  value: provider.selectedContactUsContent.contains(
                    jsonEncode(
                      {
                        "title": title,
                        "description": description,
                      },
                    ),
                  ),
                  onChanged: (_) {
                    provider.toggleContactUsSelection({
                      "title": title,
                      "description": description,
                    });

                    print(provider.selectedContactUsContent.contains({
                      "title": title,
                      "description": description,
                    }));
                  },
                ),
              if (provider.showContactUsCheckboxes)
                SizedBox(
                  width: 5,
                ),
              Expanded(
                child: Container(
                  padding:
                      EdgeInsets.only(left: 20, top: 20, bottom: 20, right: 70),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      width: 1,
                      color: Color(0xffE5E8EC),
                    ),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 0),
                        blurRadius: 2,
                        spreadRadius: 0,
                        color: Color(0x00000008),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // App Description
                      Text(
                        title,
                        style: getBoldStyle(
                            fontSize: 22, color: AppColors.blackColor),
                      ),
                      SizedBox(height: 10),
                      Text(
                        description,
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showConfirmationDialog(BuildContext context,
      AdditionalSettingsProvider provider, bool isContactUs) {
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
            'Are you sure you want to delete the selected content?',
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
                if (isContactUs) {
                  provider.deleteSelectedContactUsSection(context);
                } else {
                  provider.deleteSelectedAboutUs(context);
                }
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

  Widget _aboutUs() {
    return Expanded(
      child: Consumer<AdditionalSettingsProvider>(
        builder: (context, provider, child) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              children: [
                padding30,
                Row(
                  children: [
                    Text(
                      'About Us',
                      style: getSemiBoldStyle(
                        color: AppColors.blackColor,
                        fontSize: 20,
                      ),
                    ),
                    Spacer(),
                    if (!provider.aboutUsContent.isEmpty)
                      InkWell(
                        onTap: () {
                          provider.toggleAboutUsCheckboxMode();
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: provider.showAboutUsCheckboxes
                                ? Colors.grey
                                : Colors.redAccent,
                          ),
                          child: Center(
                            child: Text(
                              provider.showAboutUsCheckboxes
                                  ? 'Cancel'
                                  : 'Delete',
                              style: getMediumStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    padding10,
                    if (!provider.showAboutUsCheckboxes)
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
                                    child: Form(
                                      key: provider.aboutUsKey,
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
                                            "Add About Us",
                                            style: getSemiBoldStyle(
                                                fontSize: 20,
                                                color: Colors.black),
                                          ),
                                          // User Information

                                          CustomTextField(
                                              title: 'Title',
                                              controller: provider
                                                  .aboutUsTitleController,
                                              obscureText: false,
                                              textInputAction:
                                                  TextInputAction.done,
                                              keyboardType: TextInputType.text,
                                              validator: (val) {
                                                if (val == null ||
                                                    val.isEmpty) {
                                                  return "Please add title";
                                                }
                                                return null;
                                              },
                                              hintText: ''),
                                          padding10,
                                          CustomTextField(
                                              title: 'Description',
                                              minLines: 4,
                                              maxLines: null,
                                              controller: provider
                                                  .aboutUsDescriptionController,
                                              obscureText: false,
                                              textInputAction:
                                                  TextInputAction.done,
                                              keyboardType: TextInputType.text,
                                              validator: (val) {
                                                if (val == null ||
                                                    val.isEmpty) {
                                                  return "Please add description";
                                                }
                                                return null;
                                              },
                                              hintText: ''),

                                          padding20,
                                          // Action Buttons

                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              InkWell(
                                                overlayColor: WidgetStateColor
                                                    .transparent,
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 5,
                                                      horizontal: 12),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
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
                                              padding10,
                                              InkWell(
                                                overlayColor: WidgetStateColor
                                                    .transparent,
                                                onTap: () {
                                                  if (provider
                                                      .aboutUsKey.currentState!
                                                      .validate()) {
                                                    provider.addAboutUsItem();
                                                    Navigator.pop(context);
                                                  }
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 5,
                                                      horizontal: 12),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    color: Colors.green,
                                                  ),
                                                  child: Text(
                                                    'Add',
                                                    style: getMediumStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
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
                    if (provider.showAboutUsCheckboxes)
                      InkWell(
                        onTap: () {
                          _showConfirmationDialog(context, provider, false);
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
                provider.aboutUsContent.isEmpty
                    ? Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .3,
                          ),
                          Center(
                            child: Text(
                              "Not Available",
                              style: getSemiBoldStyle(
                                color: AppColors.blackColor,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      )
                    : Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              padding20,
                              provider.aboutUsContent.isEmpty
                                  ? Center(
                                      child: Text(
                                        "Not Available",
                                        style: getSemiBoldStyle(
                                          color: AppColors.blackColor,
                                          fontSize: 20,
                                        ),
                                      ),
                                    )
                                  : ListView.builder(
                                      itemCount: provider.aboutUsContent.length,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 10.0),
                                          child: _aboutUsSection(
                                            title: provider
                                                .aboutUsContent[index]['title']
                                                .toString(),
                                            description: provider
                                                .aboutUsContent[index]
                                                    ['description']
                                                .toString(),
                                          ),
                                        );
                                      }),
                              padding20,
                            ],
                          ),
                        ),
                      ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _contactUs() {
    return Expanded(
      child: Consumer<AdditionalSettingsProvider>(
        builder: (context, provider, child) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              children: [
                padding30,
                Row(
                  children: [
                    Text(
                      'Contact Us',
                      style: getSemiBoldStyle(
                        color: AppColors.blackColor,
                        fontSize: 20,
                      ),
                    ),
                    Spacer(),
                    if (!provider.contactUsContent.isEmpty)
                      InkWell(
                        onTap: () {
                          provider.toggleContactUsCheckboxMode();
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: provider.showContactUsCheckboxes
                                ? Colors.grey
                                : Colors.redAccent,
                          ),
                          child: Center(
                            child: Text(
                              provider.showContactUsCheckboxes
                                  ? 'Cancel'
                                  : 'Delete',
                              style: getMediumStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    padding10,
                    if (!provider.showContactUsCheckboxes)
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
                                    child: Form(
                                      key: provider.contactUsKey,
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
                                            "Add Contact Us",
                                            style: getSemiBoldStyle(
                                                fontSize: 20,
                                                color: Colors.black),
                                          ),
                                          // User Information

                                          CustomTextField(
                                              title: 'Title',
                                              controller: provider
                                                  .contactUsTitleController,
                                              obscureText: false,
                                              textInputAction:
                                                  TextInputAction.done,
                                              keyboardType: TextInputType.text,
                                              validator: (val) {
                                                if (val == null ||
                                                    val.isEmpty) {
                                                  return "Please add title";
                                                }
                                                return null;
                                              },
                                              hintText: ''),
                                          padding10,
                                          CustomTextField(
                                              title: 'Description',
                                              minLines: 4,
                                              maxLines: 8,
                                              controller: provider
                                                  .contactUsDescriptionController,
                                              obscureText: false,
                                              textInputAction:
                                                  TextInputAction.done,
                                              keyboardType: TextInputType.text,
                                              validator: (val) {
                                                if (val == null ||
                                                    val.isEmpty) {
                                                  return "Please add description";
                                                }
                                                return null;
                                              },
                                              hintText: ''),

                                          padding20,
                                          // Action Buttons

                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              InkWell(
                                                overlayColor: WidgetStateColor
                                                    .transparent,
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 5,
                                                      horizontal: 12),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
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
                                              padding10,
                                              InkWell(
                                                overlayColor: WidgetStateColor
                                                    .transparent,
                                                onTap: () {
                                                  if (provider.contactUsKey
                                                      .currentState!
                                                      .validate()) {
                                                    provider.addContactUsItem();
                                                    Navigator.pop(context);
                                                  }
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 5,
                                                      horizontal: 12),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    color: Colors.green,
                                                  ),
                                                  child: Text(
                                                    'Add',
                                                    style: getMediumStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
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
                    if (provider.showContactUsCheckboxes)
                      InkWell(
                        onTap: () {
                          _showConfirmationDialog(context, provider, true);
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
                provider.contactUsContent.isEmpty
                    ? Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .3,
                          ),
                          Center(
                            child: Text(
                              "Not Available",
                              style: getSemiBoldStyle(
                                color: AppColors.blackColor,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      )
                    : Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              padding20,
                              ListView.builder(
                                  itemCount: provider.contactUsContent.length,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10.0),
                                      child: _contactUsSection(
                                        title: provider.contactUsContent[index]
                                                ['title']
                                            .toString(),
                                        description: provider
                                            .contactUsContent[index]
                                                ['description']
                                            .toString(),
                                      ),
                                    );
                                  }),
                              padding20,
                            ],
                          ),
                        ),
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}
