import 'package:chotu_admin/model/category_model.dart';
import 'package:chotu_admin/model/shop_model.dart';
import 'package:chotu_admin/providers/store_provider.dart';
import 'package:chotu_admin/screens/shops/shops_product_screen.dart';
import 'package:chotu_admin/screens/shops/widgets/addNewShopDialogBox.dart';
import 'package:chotu_admin/utils/app_Colors.dart';
import 'package:chotu_admin/utils/app_Paddings.dart';
import 'package:chotu_admin/utils/app_text_widgets.dart';
import 'package:chotu_admin/utils/toast_dialogue.dart';
import 'package:chotu_admin/widgets/custom_Button.dart';
import 'package:chotu_admin/widgets/custom_TextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ShopCardWidget extends StatefulWidget {
  StoreModel storeModel;

  ShopCardWidget({super.key, required this.storeModel});

  @override
  State<ShopCardWidget> createState() => _ShopCardWidgetState();
}

class _ShopCardWidgetState extends State<ShopCardWidget> {
  late StoreProvider storeProvider;

  @override
  Widget build(BuildContext context) {
    return Consumer<StoreProvider>(builder: (context, provider, child) {
      storeProvider = provider;
      CategoryModel? storeCatModel;
      if (provider.allCategoriesList != null) {
        storeCatModel = provider.allCategoriesList!
            .where((cat) => cat.id == widget.storeModel.categoryId)
            .firstOrNull;
      }

      return FractionallySizedBox(
        widthFactor: 1 / 3.16, // Takes 1/3 of the parent width
        child: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return ShopProductsScreen();
            }));
          },
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 0),
                  blurRadius: 7,
                  spreadRadius: 0,
                  color: Colors.black.withOpacity(.25)),
            ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 51,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(
                        '${widget.storeModel.cImg}',
                        cacheKey: '${widget.storeModel.cImg}',
                        cacheManager: CacheManager(
                          Config(
                            '${widget.storeModel.cImg}',
                            stalePeriod: Duration(days: 5),
                          ),
                        ),
                      ), // Using NetworkImage directly
                      fit: BoxFit.cover,
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.topRight,
                      colors: [
                        Color(0xff45CF8D),
                        Color(0xff046938),
                      ],
                    ),
                  ),
                  child: Center(
                      child: Text(
                    '${widget.storeModel.name} - ${widget.storeModel.id}',
                    style: getMediumStyle(color: Colors.white, fontSize: 16),
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Shop Details',
                            style: getMediumStyle(
                                color: AppColors.textColor, fontSize: 16),
                          ),
                          Spacer(),
                          SizedBox()
                        ],
                      ),
                      padding16,
                      buildRow(
                          title: 'Category',
                          description: '${storeCatModel?.name ?? 'Unknown'}'),
                      // buildRow(title: 'Total Products', description: '${widget.storeModel}'),
                      // buildRow(title: 'Total Orders ', description: '10'),
                      // buildRow(title: 'Delivered Orders', description: '5'),
                      buildRow(
                          title: 'Shop Location',
                          description: '${widget.storeModel.address}'),
                      padding16,
                      const Divider(
                        color: Color(0xffAFA9A9),
                      ),
                      InkWell(
                        splashColor: Colors.greenAccent,
                        onTap: () async {
                          await showConfirmDialog(context, widget.storeModel.status, () async{
                            ShowToastDialog.showLoader('Please Wait');
                            await provider.updateStoreStatus(widget.storeModel);
                          });
                        },
                        child: Tooltip(
                          preferBelow: true,
                          margin: EdgeInsets.only(left: 20),
                          message: "Update store status",
                          child: buildRow(
                            title: 'Shop Status',
                            description:
                                '${widget.storeModel.status == 1 ? 'Active' : 'InActive'}',
                            style: getBoldStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ).copyWith(
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.blue),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

Widget buildShimmerShopCardWidget(BuildContext context) {
  return FractionallySizedBox(
    widthFactor: 1 / 3.16, // Takes 1/3 of the parent width
    child: InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return ShopProductsScreen();
        }));
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
              offset: const Offset(0, 0),
              blurRadius: 7,
              spreadRadius: 0,
              color: Colors.black.withOpacity(.25)),
        ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 51,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                  colors: [
                    Color(0xff45CF8D),
                    Color(0xff046938),
                  ],
                ),
              ),
              child: Center(
                  child: Text(
                'Shop Name - xxxxx',
                style: getMediumStyle(color: Colors.white, fontSize: 16),
              )),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Shop Details',
                        style: getMediumStyle(
                            color: AppColors.textColor, fontSize: 16),
                      ),
                      Spacer(),
                      SizedBox()
                    ],
                  ),
                  padding16,
                  buildRow(title: 'Category', description: 'Mobile Shop'),
                  buildRow(title: 'Total Products', description: '7'),
                  buildRow(title: 'Total Orders ', description: '10'),
                  buildRow(title: 'Delivered Orders', description: '5'),
                  buildRow(
                      title: 'Shop Location', description: 'Johr Town Lahore'),
                  padding16,
                  const Divider(
                    color: Color(0xffAFA9A9),
                  ),
                  buildRow(title: 'Shop Status', description: 'Active'),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

/// build stats card
Widget buildStatsCard(String title, int count, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: const Color(0xfff5f5f5),
    ),
    child: Row(
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const Spacer(),
        Text(
          count.toString(),
          style: TextStyle(
            color: color,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

Widget buildRow(
    {required String title, required String description, TextStyle? style}) {
  return Row(
    children: [
      Expanded(
        child: Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: getRegularStyle(
            color: const Color(0xff454545),
            fontSize: 14,
          ),
        ),
      ),
      padding12,
      Expanded(
        child: Align(
          alignment: Alignment.topRight,
          child: Text(
            description,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: style ??
                getRegularStyle(
                  color: const Color(0xff454545),
                  fontSize: 14,
                ),
          ),
        ),
      ),
    ],
  );
}

Future<void> showConfirmDialog(
    BuildContext context, int currentStatus, VoidCallback onConfirm) async {
  await showDialog(
    barrierColor: Colors.black12,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: Text(
          "Update Status",
          style: getBoldStyle(color: Colors.black, fontSize: 16),
        ),
        content: Text(
          "Are you sure you want to update the store's status to ${currentStatus == 0 ? 'Active' : 'InActive'}",
          style: getMediumStyle(color: Colors.black, fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Close dialog
            child: Text(
              "Cancel",
              style: getBoldStyle(color: Colors.black, fontSize: 14),
            ),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context); // Close dialog
              onConfirm(); // Execute confirmation action
            },
            child: Text(
              "Update",
              style: getBoldStyle(color: Colors.black, fontSize: 14),
            ),
          ),
        ],
      );
    },
  );
}
