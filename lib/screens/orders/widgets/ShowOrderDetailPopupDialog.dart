import 'package:cached_network_image/cached_network_image.dart';
import 'package:chotu_admin/generated/assets.dart';
import 'package:chotu_admin/utils/app_Colors.dart';
import 'package:flutter/material.dart';

import '../../../model/all_orders_model.dart';
import '../../../utils/app_text_widgets.dart';

void showOrderDetails(BuildContext context, Order order) {
  showDialog(
    context: context,
    builder: (context) {
      final store = order.stores?.first;
      final products = order.products ?? [];

      return Dialog(
        insetPadding: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          width: 600,
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Store Info
              if (store != null) ...[
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
                          imageUrl: '${store.fImg}',
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
                        Text(store?.name ?? "",
                            style: getBoldStyle(
                                fontSize: 18, color: AppColors.textColor)),
                        Text(store.address ?? '',
                            style: getRegularStyle(
                                fontSize: 14, color: AppColors.textColor)),
                      ],
                    ),
                  ],
                ),
                const Divider(height: 30),
              ],

              // Product List
              ListView.builder(
                shrinkWrap: true,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final item = products[index];
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
                                    fontSize: 14, color: AppColors.textColor),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          'Rs. ${double.parse(product?.discountPrice ?? "0") * (item?.quantity ?? 0)}',
                          style: getBoldStyle(
                              fontSize: 14, color: AppColors.textColor),
                        )
                      ],
                    ),
                  );
                },
              ),

              const Divider(height: 30),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close'),
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}
