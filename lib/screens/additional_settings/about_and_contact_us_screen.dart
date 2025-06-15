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
        Container(),
      ],
    );
  }

  Widget _aboutUsSection({required String title, required String description}) {
    return Consumer<AdditionalSettingsProvider>(
      builder: (context, provider, child) {
        return Row(
          children: [
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
                    padding10,
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
                                            controller:
                                                provider.aboutUsTitleController,
                                            obscureText: false,
                                            textInputAction:
                                                TextInputAction.done,
                                            keyboardType: TextInputType.text,
                                            validator: (val) {
                                              if (val == null || val.isEmpty) {
                                                return "Please add title";
                                              }
                                              return null;
                                            },
                                            hintText: ''),
                                        padding10,
                                        CustomTextField(
                                            title: 'Description',
                                            minLines: 4,
                                            maxLines: 6,
                                            controller: provider
                                                .aboutUsDescriptionController,
                                            obscureText: false,
                                            textInputAction:
                                                TextInputAction.done,
                                            keyboardType: TextInputType.text,
                                            validator: (val) {
                                              if (val == null || val.isEmpty) {
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
                                              overlayColor:
                                                  WidgetStateColor.transparent,
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 5,
                                                    horizontal: 12),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
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
                                              overlayColor:
                                                  WidgetStateColor.transparent,
                                              onTap: () {
                                                if (provider
                                                    .aboutUsKey.currentState!
                                                    .validate()) {
                                                  provider.addAboutUs(
                                                      provider
                                                          .aboutUsTitleController
                                                          .text,
                                                      provider
                                                          .aboutUsDescriptionController
                                                          .text,
                                                      context);
                                                }
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 5,
                                                    horizontal: 12),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
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
}
