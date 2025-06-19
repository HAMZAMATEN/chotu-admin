import 'package:chotu_admin/main.dart';
import 'package:chotu_admin/model/faq_item_model.dart';
import 'package:chotu_admin/utils/app_Colors.dart';
import 'package:chotu_admin/utils/app_Paddings.dart';
import 'package:chotu_admin/utils/fonts_manager.dart';
import 'package:chotu_admin/widgets/ShowConformationAlert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chotu_admin/providers/additional_settings_provider.dart';
import 'package:chotu_admin/utils/app_text_widgets.dart';
import 'package:chotu_admin/widgets/custom_Button.dart';
import 'package:chotu_admin/widgets/custom_TextField.dart';

class FaqsScreen extends StatelessWidget {
  FaqsScreen({super.key});

  late AdditionalSettingsProvider additionalSettingsProvider;
  TextEditingController questionController = TextEditingController();
  TextEditingController answerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'All FAQ\'s',
                    style: getSemiBoldStyle(
                      color: AppColors.blackColor,
                      fontSize: 20,
                    ),
                  ),
                  padding20,
                  Consumer<AdditionalSettingsProvider>(
                    builder: (context, provider, child) {
                      additionalSettingsProvider = provider;
                      if (provider.faqItems == null) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          ),
                        );
                      }
                      return ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: provider.faqItems!.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: 10.0),
                              child: _buildFAQCard(
                                faqItem: provider.faqItems![index],
                              ),
                            );
                          });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        padding20,
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add FAQ\'s',
                  style: getSemiBoldStyle(
                    color: AppColors.blackColor,
                    fontSize: 20,
                  ),
                ),
                padding20,
                _buildAddFaq(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFAQCard({required FaqItemModel faqItem}) {
    return Container(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            faqItem.question,
            style: getSemiBoldStyle(color: AppColors.blackColor, fontSize: 14),
          ),
          padding10,
          Text(
            faqItem.answer,
            style: getRegularStyle(
              fontSize: MyFonts.size14,
              color: AppColors.textColor,
            ),
          ),
          padding10,
          Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                  onPressed: () async {
                    showCustomConfirmationDialog(
                      context: navigatorKey.currentContext!,
                      message: 'Are you sure you want to delete this FAQ?',
                      cancelText: 'No',
                      confirmText: 'Delete',
                      onConfirm: () async{
                        await additionalSettingsProvider.deleteFaq(
                            faqId: faqItem.id);
                      },
                    );
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.green,
                  )))
        ],
      ),
    );
  }

  Widget _buildAddFaq() {
    return Consumer<AdditionalSettingsProvider>(
      builder: (context, provider, child) {
        return Form(
          key: provider.faqKey,
          child: Column(
            children: [
              CustomTextField(
                  title: 'Question',
                  controller: questionController,
                  obscureText: false,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  hintText: '',
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Please add question";
                    }
                    return null;
                  }),
              padding10,
              CustomTextField(
                  title: 'Answer',
                  minLines: 8,
                  maxLines: 8,
                  controller: answerController,
                  obscureText: false,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.text,
                  hintText: '',
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Please add answer";
                    }
                    return null;
                  }),
              padding30,
              CustomButton(
                width: MediaQuery.of(context).size.width * .2,
                btnColor: AppColors.btnColor,
                btnText: 'Add',
                btnTextColor: AppColors.btnTextColor,
                onPress: () async {
                  if (provider.faqKey.currentState!.validate()) {
                    Map<String, dynamic> body = {
                      'question': '${questionController.text}',
                      'answer': '${answerController.text}',
                      'is_active': '1',
                    };

                    await provider.addFaq(body: body);
                    questionController.clear();
                    answerController.clear();
                    provider.getAllFaqs();
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
