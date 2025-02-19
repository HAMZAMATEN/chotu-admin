import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:chotu_admin/providers/additional_settings_provider.dart';
import 'package:chotu_admin/utils/app_text_widgets.dart';
import 'package:chotu_admin/widgets/custom_Button.dart';
import 'package:chotu_admin/widgets/custom_TextField.dart';

import '../../utils/app_Colors.dart';
import '../../utils/app_Paddings.dart';
import '../../utils/fonts_manager.dart';

class FaqsScreen extends StatelessWidget {
  const FaqsScreen({super.key});

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
                      return ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: provider.faqItems.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: 10.0),
                              child: _buildFAQCard(
                                  question: provider.faqItems[index].question,
                                  answer: provider.faqItems[index].answer),
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

  Widget _buildFAQCard({required String question, required String answer}) {
    return Container(
      padding: EdgeInsets.only(left: 20, top: 20, bottom: 20, right: 70),
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
            question,
            style: getSemiBoldStyle(color: AppColors.blackColor, fontSize: 14),
          ),
          padding10,
          Text(
            answer,
            style: getRegularStyle(
              fontSize: MyFonts.size14,
              color: AppColors.textColor,
            ),
          ),
          padding10,
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
                  controller: provider.questionController,
                  obscureText: false,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  hintText: '',
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Please add question";
                    }
                    return "";
                  }),
              padding10,
              CustomTextField(
                  title: 'Answer',
                  minLines: 8,
                  maxLines: 8,
                  controller: provider.answerController,
                  obscureText: false,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.text,
                  hintText: '',
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Please add answer";
                    }
                    return "";
                  }),
              padding30,
              CustomButton(
                width: MediaQuery
                    .of(context)
                    .size
                    .width * .2,
                btnColor: AppColors.btnColor,
                btnText: 'Add',
                btnTextColor: AppColors.btnTextColor,
                onPress: () {
                  if (provider.faqKey.currentState!.validate()) {}
                },),
            ],
          ),
        );
      },
    );
  }
}
