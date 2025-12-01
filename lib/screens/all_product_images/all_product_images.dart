import 'package:chotu_admin/generated/assets.dart';
import 'package:chotu_admin/providers/all_product_image/all_product_image_provider.dart';
import 'package:chotu_admin/utils/app_Colors.dart';
import 'package:chotu_admin/utils/app_Paddings.dart';
import 'package:chotu_admin/widgets/custom_Button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../widgets/custom_TextField.dart';

class AllProductImagesScreen extends StatelessWidget {
  const AllProductImagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => AllProductImageProvider(),
      child: Consumer<AllProductImageProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Center(
                        child: Text(
                          "Images",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 32),
                        ),
                      ),
                      Spacer(),
                      CustomButton(
                        width: 100,
                        height: 48,
                        btnColor: AppColors.btnColor,
                        btnText: "Upload",
                        btnTextColor: AppColors.btnTextColor,
                        onPress: () {
                          provider.pickMultipleImagesFromGallery();
                        },
                      ),
                      padding16,
                      CustomTextField(
                          width: 300,
                          title: '',
                          controller: TextEditingController(),
                          obscureText: false,
                          textInputAction: TextInputAction.search,
                          keyboardType: TextInputType.text,
                          hintText: 'Search images by name',
                          onChanged: (val) async {}),
                    ],
                  ),
                  SizedBox(height: 20),
                  Expanded(child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return _imageCard(
                          imageUrl: "https://example.com/image_$index.jpg",
                          onImageTap: () {
                            // Handle image tap action
                          },
                        );
                      }),),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _imageCard({
    required String imageUrl,
    required VoidCallback onImageTap, // image click action
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderColor),
        color: const Color(0xfff5f5f5),
      ),
      child: Row(
        children: [

          /// ---- IMAGE WITH TAP ----
          InkWell(
            onTap: onImageTap,
            child: Container(
              height: 80,
              width: 100,
              child: Image.asset(
                Assets.imagesImageNoImage,
                fit: BoxFit.cover,
              ),
            ),
          ),

          padding16,

          /// ---- IMAGE URL TEXT ----
          Expanded(
            child: SelectableText(
              imageUrl,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.textColor,
              ),
            ),
          ),

          padding16,

          /// ---- COPY BUTTON ----
          InkWell(
            onTap: () {
              Clipboard.setData(ClipboardData(text: imageUrl));
            },
            borderRadius: BorderRadius.circular(4),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.greyColor,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                "Copy",
                style: TextStyle(
                  color: AppColors.textColor,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          padding16,
        ],
      ),
    );
  }

}
