import 'package:chotu_admin/providers/additional_settings_provider.dart';
import 'package:chotu_admin/utils/app_Colors.dart';
import 'package:chotu_admin/utils/app_text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  TextEditingController aboutUsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<AdditionalSettingsProvider>(
          builder: (context,provider,child) {
            if(provider.aboutUs != null){
              aboutUsController.text = provider.aboutUs!;
            }
            if(provider.aboutUs == null){
              return Center(child: CircularProgressIndicator(color: AppColors.primaryColor,));
            }
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'About Us',
                      style: getBoldStyle(
                          fontSize: 24,
                          color: Colors.black
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Last Updated : ${provider.aboutUsLastUpdate}',
                      style: getMediumStyle(
                          fontSize: 16,
                          color: Colors.grey
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.only(left: 20, top: 20, bottom: 10, right: 20),
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
                      child: TextField(
                        controller: aboutUsController,
                        maxLines: 13,
                        maxLength: 3000,
                        style: getMediumStyle(fontSize: 16, color: Colors.black,),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Write about your company here...',
                          hintStyle: getRegularStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ),
                    ),
                    // Add more content here as needed
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () async {
                          await provider.updateAdditionalSettingContent(
                              content: aboutUsController.text,
                              isAboutUs: true);
                        },
                        child: Container(
                          width: 120,
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
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
                    ),
                  ],
                ),
              ),
            );
          }
      ),
    );
  }
}
