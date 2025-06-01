import 'package:cached_network_image/cached_network_image.dart';
import 'package:chotu_admin/generated/assets.dart';
import 'package:chotu_admin/utils/app_Colors.dart';
import 'package:chotu_admin/utils/app_Paddings.dart';
import 'package:flutter/material.dart';

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
          child: SingleChildScrollView(
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

                const Divider(height: 30),
                for (final storeData in stores) ...[
                  Row(
                    children: [
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: CachedNetworkImage(
                            imageUrl: '${storeData.store?.fImg ?? ""}',
                            errorListener: (e) {},
                            errorWidget: (c, i, b) {
                              return Image.asset(Assets.imagesAppLogo);
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(storeData.store?.name ?? "",
                              style: getBoldStyle(
                                  fontSize: 18, color: AppColors.textColor)),
                          Text(storeData.store?.address ?? '',
                              style: getRegularStyle(
                                  fontSize: 14, color: AppColors.textColor)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Products for this store
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: storeData.products?.length ?? 0,
                    itemBuilder: (context, index) {
                      final item = storeData.products![index];
                      final product = item.product;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Row(
                          children: [
                            Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: CachedNetworkImage(
                                  imageUrl: '${product?.img ?? ""}',
                                  errorListener: (e) {},
                                  errorWidget: (c, i, b) {
                                    return Image.asset(Assets.imagesAppLogo);
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(product?.name ?? "",
                                      style: getBoldStyle(
                                          fontSize: 16,
                                          color: AppColors.textColor)),
                                  Text(
                                      '${product?.unitValue ?? 0} ${product?.unit ?? ""}'),
                                  Text(
                                    'Qty: ${item.quantity} x Rs. ${double.parse(product?.discountPrice ?? "0")}',
                                    style: getRegularStyle(
                                        fontSize: 14,
                                        color: AppColors.textColor),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              'Rs. ${double.parse(product?.discountPrice ?? "0") * (item.quantity ?? 0)}',
                              style: getBoldStyle(
                                  fontSize: 14, color: AppColors.textColor),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                  const Divider(height: 30),
                ],

                Align(
                  alignment: Alignment.centerRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('Subtotal: Rs. 200',
                          style: getRegularStyle(
                              fontSize: 14, color: AppColors.textColor)),
                      const SizedBox(height: 4),
                      // If you want to add other billing details like tax or delivery fee:
                      // Text('Tax: Rs. 0.00'),
                      // Text('Delivery: Rs. 0.00'),
                      // Divider(height: 20),
                      Text('Total: Rs. 200',
                          style: getBoldStyle(
                              fontSize: 16, color: AppColors.textColor)),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      );
    },
  );
}
