import 'dart:convert';

import 'package:chotu_admin/generated/assets.dart';
import 'package:chotu_admin/utils/app_Colors.dart';
import 'package:chotu_admin/utils/app_Paddings.dart';
import 'package:chotu_admin/utils/app_text_widgets.dart';
import 'package:chotu_admin/widgets/custom_TextField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:chotu_admin/providers/additional_settings_provider.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  late AdditionalSettingsProvider additionalSettingsProvider;
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController workingTimeController = TextEditingController();
  List<TextEditingController> controllersList = [];




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<AdditionalSettingsProvider>(
        builder: (context, provider, child) {
          additionalSettingsProvider = provider;
          if (provider.contactUsMap == null) {
            return Center(
              child: Container(
                height: 100,
                width: 100,
                child: Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            );
          }
          final entries = provider.contactUsMap?.entries.toList() ?? [];
          if(entries.isNotEmpty){
            phoneNumberController.text = provider.contactUsMap!['phone_number'];
            addressController.text = provider.contactUsMap!['address'];
            workingTimeController.text = provider.contactUsMap!['working_hours'];
            emailController.text = provider.contactUsMap!['email'];
            controllersList = [
              emailController,
              phoneNumberController,
              workingTimeController,
              addressController,
            ];
          }
          else{
            emailController.text = '';
            addressController.text = '';
            phoneNumberController.text = '';
            workingTimeController.text = '';
          }

          return Container(
            margin: EdgeInsets.symmetric(horizontal: 30.0),
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
                    InkWell(
                      onTap: () async{
                        Map<String,dynamic> body = {
                          "phone_number":"${phoneNumberController.text}",
                          "address":"${addressController.text}",
                          "working_hours":"${workingTimeController.text}",
                          'email': "${emailController.text}",
                        };
                        await provider.updateContactUs(body: body);
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
                            'Update',
                            style: getMediumStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        padding20,
                        ListView.builder(
                          itemCount: entries.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final entry = entries[index];
                            return _contactUsSection(
                              title: entry.key.toString(),
                              description: entry.value.toString(),
                              controller: controllersList[index],
                            );
                          },
                        ),
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

  Widget _contactUsSection({
    required String title,
    required String description,
    required TextEditingController controller,
  }) {
    return Consumer<AdditionalSettingsProvider>(
      builder: (context, provider, child) {
        return Container(
          margin: EdgeInsets.only(bottom: 10),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding:
                      EdgeInsets.only(left: 20, top: 20, bottom: 20, right: 70),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(width: 1, color: Color(0xffE5E8EC)),
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
                      Text(
                        title.capitalize!.toString(),
                        style: getBoldStyle(
                            fontSize: 22, color: AppColors.blackColor),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: controller,
                        style:
                            getMediumStyle(fontSize: 18, color: Colors.black),
                        readOnly: false,
                        maxLines: null,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none,
                          fillColor: Colors.transparent,
                          filled: true,
                        ),
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
}
