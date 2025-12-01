import 'package:cached_network_image/cached_network_image.dart';
import 'package:chotu_admin/generated/assets.dart';
import 'package:chotu_admin/providers/all_product_image/all_product_image_provider.dart';
import 'package:chotu_admin/utils/app_Colors.dart';
import 'package:chotu_admin/utils/app_Paddings.dart';
import 'package:chotu_admin/utils/functions.dart';
import 'package:chotu_admin/widgets/custom_Button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

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
                        controller: provider.searchController,
                        obscureText: false,
                        textInputAction: TextInputAction.search,
                        keyboardType: TextInputType.text,
                        hintText: 'Search images by name',
                        onChanged: (val) async {
                          provider.searchImages();
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: provider.allProductImagesModel == null
                        ? ListView.builder(
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return _imageCardShimmer();
                            })
                        : provider.searchController.text.isNotEmpty &&
                                provider.filteredList.isEmpty
                            ? Center(
                                child: Text(
                                  "No images available",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textColor,
                                    fontSize: 32,
                                  ),
                                ),
                              )
                            : provider.searchController.text.isNotEmpty &&
                                    provider.filteredList.isNotEmpty
                                ? ListView.builder(
                                    itemCount: provider.filteredList.length,
                                    itemBuilder: (context, index) {
                                      return _imageCard(
                                        imageUrl: provider.filteredList[index],
                                        onImageTap: () {
                                          // Handle image tap action
                                        },
                                      );
                                    })
                                : provider.allProductImagesModel != null &&
                                        provider.allProductImagesModel!.data!
                                            .urls.isEmpty
                                    ? Center(
                                        child: Text(
                                          "No images available",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.textColor,
                                            fontSize: 32,
                                          ),
                                        ),
                                      )
                                    : ListView.builder(
                                        itemCount: provider
                                                .allProductImagesModel
                                                ?.data
                                                ?.urls
                                                .length ??
                                            10,
                                        itemBuilder: (context, index) {
                                          return _imageCard(
                                            imageUrl: provider
                                                    .allProductImagesModel
                                                    ?.data
                                                    ?.urls[index] ??
                                                "https://example.com/image_$index.jpg",
                                            onImageTap: () {
                                              // Handle image tap action
                                            },
                                          );
                                        }),
                  ),
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
    return Center(
      child: Container(
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
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[200]!,
                      child: Icon(
                        Icons.image,
                        size: 50,
                      )),
                  errorWidget: (context, url, error) =>
                      Image.asset(Assets.imagesImageNoImage),
                  errorListener: (_) {},
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
                AppFunctions.showToastMessage(message: "Copied to clipboard");
              },
              borderRadius: BorderRadius.circular(4),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.btnColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  "Copy",
                  style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            padding16,
          ],
        ),
      ),
    );
  }

  Widget _imageCardShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[200]!,
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          margin: EdgeInsets.only(bottom: 8),
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.borderColor),
            color: const Color(0xfff5f5f5),
          ),
          child: Row(
            children: [
              /// ---- IMAGE WITH TAP ----
              Container(
                height: 80,
                width: 100,
                color: Colors.white,
              ),

              padding16,

              /// ---- IMAGE URL TEXT ----
              Expanded(
                child: SelectableText(
                  "https://example.com/image_url_placeholder.jpg",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textColor,
                  ),
                ),
              ),

              padding16,

              /// ---- COPY BUTTON ----
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.btnColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  "Copy",
                  style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 14,
                  ),
                ),
              ),
              padding16,
            ],
          ),
        ),
      ),
    );
  }
}
