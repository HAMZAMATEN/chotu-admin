import 'package:cached_network_image/cached_network_image.dart';
import 'package:chotu_admin/generated/assets.dart';
import 'package:chotu_admin/utils/app_Colors.dart';
import 'package:chotu_admin/utils/app_Paddings.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../model/all_orders_model.dart';
import '../../../utils/app_text_widgets.dart';

void showOrderDetails(BuildContext context, Order order) {
  showDialog(
    context: context,
    builder: (context) {
      final stores = order.stores ?? [];

      return Dialog(
        insetPadding: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          width: 600,
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Loop through each store
              Align(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.cancel_outlined,
                        color: AppColors.textColor,
                      ),
                    ),
                    padding6,
                    Text(
                      "Orders Detail",
                      style: getBoldStyle(
                        color: AppColors.textColor,
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
              ),

              const Divider(height: 18),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),
                      for (final storeData in stores) ...[
                        // Store Header
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 12),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor.withOpacity(.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.primaryColor),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: CachedNetworkImage(
                                    imageUrl: '${storeData.store?.fImg ?? ""}',
                                    errorListener: (e) {},
                                    errorWidget: (c, i, b) {
                                      return Image.asset(Assets.imagesAppLogo);
                                    },
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(FontAwesomeIcons.shop,
                                            size: 18, color: AppColors.primaryColor),
                                        const SizedBox(width: 12),
                                        Text(
                                          storeData.store?.name ?? "",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: getBoldStyle(
                                            fontSize: 18,
                                            color: AppColors.primaryColor,
                                          ).copyWith(fontWeight: FontWeight.w800),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      storeData.store?.address ?? '',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: getRegularStyle(
                                        fontSize: 14,
                                        color: Colors.grey[700]!,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Product List
                        if (storeData.products != null &&
                            storeData.products!.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: storeData.products!.length,
                              itemBuilder: (context, index) {
                                final item = storeData.products![index];
                                final product = item.product;

                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: Row(
                                    children: [
                                      // Product Image
                                      Container(
                                        height: 60,
                                        width: 60,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: CachedNetworkImage(
                                            imageUrl: '${product?.img ?? ""}',
                                            errorListener: (e) {},
                                            errorWidget: (c, i, b) {
                                              return Image.asset(
                                                  Assets.imagesAppLogo);
                                            },
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),

                                      const SizedBox(width: 12),

                                      // Product Details
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              product?.name ?? "",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: getBoldStyle(
                                                fontSize: 16,
                                                color: AppColors.textColor,
                                              ),
                                            ),
                                            Text(
                                              '${product?.unitValue ?? 0} ${product?.unit ?? ""}',
                                              style: getRegularStyle(
                                                  fontSize: 13,
                                                  color:
                                                      AppColors.lightTextColor),
                                            ),
                                            Text(
                                              'Qty: ${item.quantity} x Rs. ${double.parse(product?.discountPrice ?? "0").toStringAsFixed(0)}',
                                              style: getRegularStyle(
                                                fontSize: 14,
                                                color: AppColors.textColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      // Product Total
                                      Text(
                                        'Rs. ${(double.parse(product?.discountPrice ?? "0") * (item.quantity ?? 0)).toStringAsFixed(0)}',
                                        style: getBoldStyle(
                                          fontSize: 14,
                                          color: AppColors.textColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),

                        const SizedBox(height: 8),

                        // Divider between stores
                        Divider(
                          color: Colors.grey.shade400,
                          thickness: 1.2,
                          indent: 12,
                          endIndent: 12,
                        ),

                        const SizedBox(height: 12),
                      ],
                    ],
                  ),
                ),
              ),

              const Divider(height: 30),

              Align(
                alignment: Alignment.centerRight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                        'Subtotal: ${order.billingDetails?.currency ?? "PKR"} ${order.billingDetails?.subtotal ?? "0"}',
                        style: getRegularStyle(
                            fontSize: 14, color: AppColors.textColor)),
                    const SizedBox(height: 4),
                    Text(
                        'Tax: ${order.billingDetails?.currency ?? "PKR"} ${order.billingDetails?.tax ?? "0"}',
                        style: getRegularStyle(
                            fontSize: 14, color: AppColors.textColor)),
                    const SizedBox(height: 4),
                    Text(
                        'Delivery Fee: ${order.billingDetails?.currency ?? "PKR"} ${order.billingDetails?.deliveryFee ?? "0"}',
                        style: getRegularStyle(
                            fontSize: 14, color: AppColors.textColor)),
                    const SizedBox(height: 4),
                    Text(
                        'Total: ${order.billingDetails?.currency ?? "PKR"} ${order.billingDetails?.total ?? "0"}',
                        style: getBoldStyle(
                            fontSize: 16, color: AppColors.textColor)),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
