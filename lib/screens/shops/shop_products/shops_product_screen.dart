import 'package:cached_network_image/cached_network_image.dart';
import 'package:chotu_admin/model/product_model.dart';
import 'package:chotu_admin/model/shop_model.dart';
import 'package:chotu_admin/providers/store_product_provider.dart';
import 'package:chotu_admin/screens/shops/widgets/addNewShopDialogBox.dart';
import 'package:chotu_admin/screens/shops/widgets/addShopProductDialogBox.dart';
import 'package:chotu_admin/screens/shops/widgets/shop_screen_card_widgets.dart';
import 'package:chotu_admin/utils/app_Colors.dart';
import 'package:chotu_admin/utils/app_Paddings.dart';
import 'package:chotu_admin/utils/app_text_widgets.dart';
import 'package:chotu_admin/widgets/custom_Button.dart';
import 'package:chotu_admin/widgets/custom_TextField.dart';
import 'package:chotu_admin/widgets/pagination_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../generated/assets.dart';

class ShopProductsScreen extends StatefulWidget {
  StoreModel storeModel;

  ShopProductsScreen({required this.storeModel});

  @override
  State<ShopProductsScreen> createState() => _ShopProductsScreenState();
}

class _ShopProductsScreenState extends State<ShopProductsScreen> {
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<StoreProductProvider>(context, listen: false)
        .getStoreProducts(widget.storeModel.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Consumer<StoreProductProvider>(builder: (context, provider, child) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                offset: const Offset(0, 0),
                color: Colors.black.withOpacity(.1),
                blurRadius: 2,
                spreadRadius: 0,
              )
            ]),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /// back icon
                    Row(
                      children: [
                        InkWell(
                            overlayColor: WidgetStatePropertyAll<Color>(
                                Colors.transparent),
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Align(
                                alignment: Alignment.topLeft,
                                child: Icon(Icons.arrow_back_ios))),
                        padding20,
                        Expanded(
                          child: Text(
                            '${widget.storeModel.name}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: getBoldStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    StoreCard(
                      store: widget.storeModel,
                    ),
                    padding30,

                    /// Status Summary Cards
                    Row(
                      children: [
                        Expanded(
                          child: _buildStatsCard(
                              'Total Products', 5, Colors.orange),
                        ),
                        padding12,
                        Expanded(
                          child: _buildStatsCard('Active', 4, Colors.green),
                        ),
                        padding12,
                        Expanded(
                          child: _buildStatsCard('DeActive', 1, Colors.red),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    /// Search Bar & add shop button
                    searchFieldWidget(context),

                    padding30,

                    /// list of products listed by shop
                    productsBodyWidget(provider, context),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget productsBodyWidget(
      StoreProductProvider provider, BuildContext context) {
    return Column(
      children: [
        if (provider.storeProductsMap[widget.storeModel.id] != null) ...[
          if (provider
              .storeProductsMap[widget.storeModel.id]![
                  provider.storeProductPagination!.currentPage]!
              .isNotEmpty) ...[
            Align(
              alignment: Alignment.topLeft,
              child: Wrap(
                spacing: 16,
                runSpacing: 16,
                alignment: WrapAlignment.start,
                runAlignment: WrapAlignment.start,
                children: List.generate(
                    provider
                        .storeProductsMap[widget.storeModel.id]![
                            provider.storeProductPagination!.currentPage]!
                        .length, (index) {
                  return _buildProductCard(
                      context,
                      provider.storeProductsMap[widget.storeModel.id]![provider
                          .storeProductPagination!.currentPage]![index]);
                }),
              ),
            ),
            if (provider.storeProductPagination != null) ...[
              SizedBox(
                height: 10,
              ),
              PaginationButton(
                pagination: provider.storeProductPagination!,
                onPrevious: () {
                  // handle going to previous page
                  provider.getStoreProducts(widget.storeModel.id!,
                      page: provider.storeProductPagination!.currentPage - 1);
                },
                onNext: () {
                  // handle going to next page
                  provider.getStoreProducts(widget.storeModel.id!,
                      page: provider.storeProductPagination!.currentPage + 1);
                },
              ),
            ]
          ] else ...[
            Container(
                width: double.infinity,
                height: 400,
                child: Center(
                  child: Text(
                    "No Products Found",
                    style: getMediumStyle(color: Colors.black, fontSize: 40),
                  ),
                )),
          ]
        ] else ...[
          shimmerProductsWidget(context),
        ],
      ],
    );
  }

  Widget searchFieldWidget(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: CustomTextField(
            width: MediaQuery.of(context).size.width,
            title: '',
            controller: TextEditingController(),
            obscureText: false,
            textInputAction: TextInputAction.search,
            keyboardType: TextInputType.text,
            hintText: 'Search Product by name',
            suffixIcon: SizedBox(
              height: 24,
              width: 24,
              child: Center(
                child: SvgPicture.asset(Assets.iconsSearchnormal1),
              ),
            ),
          ),
        ),
        padding12,
        InkWell(
          onTap: () {
            showAddShopProductDialog(context);
          },
          child: Align(
            alignment: Alignment.topRight,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.primaryColor,
              ),
              child: Text(
                'Add New Product',
                style: getSemiBoldStyle(
                  color: AppColors.whiteColor,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget shimmerProductsWidget(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.baseColor,
      highlightColor: AppColors.highlightColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// Status Summary Cards
          Row(
            children: [
              Expanded(
                child: buildStatsCard('Total Shops', 5, Colors.orange),
              ),
              padding12,
              Expanded(
                child: buildStatsCard('Active', 4, Colors.green),
              ),
              padding12,
              Expanded(
                child: buildStatsCard('DeActive', 1, Colors.red),
              ),
            ],
          ),
          const SizedBox(height: 10),

          /// Search Bar & add shop button
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: CustomTextField(
                  width: MediaQuery.of(context).size.width,
                  title: '',
                  controller: TextEditingController(),
                  obscureText: false,
                  textInputAction: TextInputAction.search,
                  keyboardType: TextInputType.text,
                  hintText: 'Search Shops by name',
                  suffixIcon: SizedBox(
                    height: 24,
                    width: 24,
                    child: Center(
                      child: SvgPicture.asset(Assets.iconsSearchnormal1),
                    ),
                  ),
                ),
              ),
              padding12,
              InkWell(
                onTap: () {
                  showAddShopDialog(context);
                },
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.primaryColor,
                    ),
                    child: Text(
                      'Add New Shop',
                      style: getSemiBoldStyle(
                        color: AppColors.whiteColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          padding30,
          // Scrollable Data Table
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.start,
            runAlignment: WrapAlignment.start,
            children: List.generate(10, (index) {
              return buildShimmerShopCardWidget(context);
            }),
          ),
        ],
      ),
    );
  }

  /// build stats card
  Widget _buildStatsCard(String title, int count, Color color) {
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

  /// build product Card
  Widget _buildProductCard(BuildContext context, ProductModel product) {
    bool isActive =
        true; // Initial status (you can fetch this from your backend)

    return FractionallySizedBox(
      widthFactor: 1 / 3.16, // Takes 1/3 of the parent width
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
            /// Product Name
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
                  'Product Name - ${product.name}',
                  style: getMediumStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),

            /// Product Image
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: CachedNetworkImageProvider('${product.img}',
                      cacheKey: '${product.img}',
                      cacheManager: CacheManager(
                        Config(
                          '${product.img}',
                          stalePeriod: Duration(days: 5),
                        ),
                      ), errorListener: (error) {
                    print(
                        "ERROR WHILE LOADING IMAGE URL : $product.img} & error : ${error}");
                  }), // Using NetworkImage directly
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
                        'Product Details',
                        style: getMediumStyle(
                            color: AppColors.textColor, fontSize: 16),
                      ),
                      Spacer(),
                      SizedBox()
                    ],
                  ),
                  padding16,
                  _buildRow(
                      title: 'Category',
                      description: '${product.category.name}'),
                  _buildRow(
                      title: 'Description',
                      description: '${product.description}'),
                  _buildRow(
                      title: 'Product Price', description: '${product.price}'),
                  _buildRow(
                      title: 'Discounted Price',
                      description: '${product.discountPrice}'),
                  _buildRow(
                      title: 'Quantity (value/unit)',
                      description: '${product.unitValue}/${product.unit}'),
                  _buildRow(
                      title: 'Brand Name', description: '${product.brand}'),
                  _buildRow(
                      title: 'Shop Name', description: '${product.store.name}'),
                  _buildRow(
                      title: 'Shop Address',
                      description: '${product.store.address}'),
                  padding16,
                  const Divider(
                    color: Color(0xffAFA9A9),
                  ),

                  // Product Status Switch
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Product Status',
                        style: getMediumStyle(
                            color: AppColors.textColor, fontSize: 16),
                      ),
                      Switch(
                        value: isActive,
                        activeColor: Colors.green,
                        onChanged: (value) {
                          _showConfirmationDialog(context, value);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Function to show confirmation dialog
  void _showConfirmationDialog(BuildContext context, bool newValue) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Action"),
          content: Text(newValue
              ? "Are you sure you want to activate this product?"
              : "Are you sure you want to deactivate this product?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                // Here you can update the product status in your backend
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Yes"),
            ),
          ],
        );
      },
    );
  }

  Widget _buildRow({required String title, required String description}) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  textAlign: TextAlign.left,
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: getRegularStyle(
                    color: const Color(0xff454545),
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            Spacer(),
            Expanded(
              child: Align(
                alignment: Alignment.topRight,
                child: Text(
                  textAlign: TextAlign.right,
                  description,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: getRegularStyle(
                    color: const Color(0xff454545),
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
        Divider(
          color: Colors.black12,
        ),
      ],
    );
  }
}

class StoreCard extends StatelessWidget {
  final StoreModel store;

  const StoreCard({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cover Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: CachedNetworkImage(
              imageUrl: store.cImg,
              fit: BoxFit.cover,
              height: 150,
              width: double.infinity,
              errorListener: (e) {},
              errorWidget: (ctx,o,s) {
                return Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                      border: Border.all(
                          color: Colors.black12
                      )
                  ),
                  child: Icon(Icons.image_not_supported_outlined,color: AppColors.primaryColor,),
                );
              },
            ),
          ),

          const SizedBox(height: 10),

          // Store Info
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                // Front Image (thumbnail)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: store.fImg,
                    height: 150,
                    fit: BoxFit.cover,
                    width: 150,
                    errorListener: (e) {},
                    errorWidget: (ctx,o,s) {
                      return Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.black12
                          )
                        ),
                        child: Icon(Icons.image_not_supported_outlined,color: AppColors.primaryColor,),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),

                // Store Name and Address
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        store.name,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            store.address,
                            style: const TextStyle(color: Colors.grey),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.location_on_outlined,
                            color: AppColors.primaryColor,
                            size: 15,
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Status ${store.status == 1 ? "Active" : "InActive"}",
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
