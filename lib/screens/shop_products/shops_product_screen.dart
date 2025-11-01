import 'package:cached_network_image/cached_network_image.dart';
import 'package:chotu_admin/model/product_model.dart';
import 'package:chotu_admin/model/shop_model.dart';
import 'package:chotu_admin/providers/store_product_provider.dart';
import 'package:chotu_admin/providers/store_provider.dart';
// import 'package:chotu_admin/screens/shops/shop_products/addShopProductDialogBox.dart';
import 'package:chotu_admin/screens/shops/widgets/shop_screen_card_widgets.dart';
import 'package:chotu_admin/screens/shops/widgets/update_shop_dialogue.dart';
import 'package:chotu_admin/utils/app_Colors.dart';
import 'package:chotu_admin/utils/app_Paddings.dart';
import 'package:chotu_admin/utils/app_text_widgets.dart';
import 'package:chotu_admin/utils/functions.dart';
import 'package:chotu_admin/widgets/ShowConformationAlert.dart';
import 'package:chotu_admin/widgets/custom_TextField.dart';
import 'package:chotu_admin/widgets/pagination_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../generated/assets.dart';
import 'widgets/add_shop_product_dialog_box.dart';
import 'widgets/update_shop_product_dialog_box.dart';

class ShopProductsScreen extends StatefulWidget {
  StoreModel storemodel;

  ShopProductsScreen({required this.storemodel});

  @override
  State<ShopProductsScreen> createState() => _ShopProductsScreenState();
}

class _ShopProductsScreenState extends State<ShopProductsScreen> {
  TextEditingController searchController = TextEditingController();

  late StoreModel store;
  late StoreProductProvider storeProductProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      store = widget.storemodel;
    });

    /// this function will fetch shop's products as well as its analytics
    Provider.of<StoreProductProvider>(context, listen: false)
        .getStoreProducts(storeId: widget.storemodel.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Consumer2<StoreProductProvider, StoreProvider>(
        builder: (context, provider, provide2, child) {
          storeProductProvider = provider;
          StoreModel? newStore;
          if ((provide2
                  .pageViseStoresMap?[provide2.storePagination!.currentPage]) ==
              null) {
            return CircularProgressIndicator(
              color: AppColors.primaryColor,
            );
          }
          if (provide2.pageViseStoresMap != null) {
            if ((provide2.pageViseStoresMap![
                    provide2.storePagination!.currentPage]) !=
                null) {
              newStore = (provide2.pageViseStoresMap![
                      provide2.storePagination!.currentPage])!
                  .where((store) => store.id == widget.storemodel.id)
                  .firstOrNull;
            }
          }
          if (newStore != null) {
            store = newStore;
          }

          if (newStore == null) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            );
          }

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
                              '${store.name}',
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
                        store: store,
                        onEdit: () {
                          showDialog(
                            context: context,
                            builder: (context) => Container(
                                child: UpdateShopDialogue(store: store)),
                          );
                        },
                      ),
                      padding30,

                      /// Status Summary Cards
                      productStatsRow(),
                      padding10,

                      /// Search Bar & add shop button
                      searchFieldWidget(context),

                      padding30,

                      /// list of products listed by shop
                      ///  or Search Products

                      if (provider.searchedProducts == null) ...[
                        productsBodyWidget(provider, context),
                      ] else ...[
                        if (provider.searchedProducts == []) ...[
                          Container(
                              width: double.infinity,
                              height: 200,
                              child: Center(
                                child: Text(
                                  "No Products Found",
                                  style: getMediumStyle(
                                      color: Colors.black, fontSize: 40),
                                ),
                              )),
                        ] else ...[
                          searchedProductsBodyWidget(provider, context),
                        ],
                      ],
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget productStatsRow() {
    if (storeProductProvider.storeAnalyticsModelMap[widget.storemodel.id] !=
        null) {
      return Row(
        children: [
          Expanded(
            child: _buildStatsCard(
                'Total Products',
                storeProductProvider
                    .storeAnalyticsModelMap[widget.storemodel.id]!.total,
                Colors.orange),
          ),
          padding12,
          Expanded(
            child: _buildStatsCard(
                'Active',
                storeProductProvider
                    .storeAnalyticsModelMap[widget.storemodel.id]!.active,
                Colors.green),
          ),
          padding12,
          Expanded(
            child: _buildStatsCard(
                'DeActive',
                storeProductProvider
                    .storeAnalyticsModelMap[widget.storemodel.id]!.nonActive,
                Colors.red),
          ),
        ],
      );
    } else {
      return Shimmer.fromColors(
        baseColor: AppColors.baseColor,
        highlightColor: AppColors.highlightColor,
        child: Row(
          children: [
            Expanded(
              child: _buildStatsCard('Total Products', 5, Colors.orange),
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
      );
    }
  }

  Widget searchedProductsBodyWidget(
      StoreProductProvider provider, BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.start,
            runAlignment: WrapAlignment.start,
            children: List.generate(provider.searchedProducts!.length, (index) {
              return _buildProductCard(
                  context, provider.searchedProducts![index]);
            }),
          ),
        ),
      ],
    );
  }

  Widget productsBodyWidget(
      StoreProductProvider provider, BuildContext context) {
    return Column(
      children: [
        if (provider.storeProductsMap[store.id] != null) ...[
          if (provider
              .storeProductsMap[store.id]![
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
                        .storeProductsMap[store.id]![
                            provider.storeProductPagination!.currentPage]!
                        .length, (index) {
                  return _buildProductCard(
                      context,
                      provider.storeProductsMap[store.id]![provider
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
                  provider.getStoreProducts(
                      storeId: store.id!,
                      page: provider.storeProductPagination!.currentPage - 1);
                },
                onNext: () {
                  // handle going to next page
                  provider.getStoreProducts(
                      storeId: store.id!,
                      page: provider.storeProductPagination!.currentPage + 1);
                },
              ),
              padding30,
            ]
          ] else ...[
            Container(
                width: double.infinity,
                height: 200,
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
            controller: searchController,
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
            onFieldSubmitted: (val) async {
              if (val.isNotEmpty) {
                await storeProductProvider.searchProductByName(
                  searchText: val,
                  storeId: store.id!.toString(),
                );
              }
            },
            prefixIcon: storeProductProvider.searchedProducts != null
                ? Tooltip(
                    message: 'Clear Search',
                    child: InkWell(
                      onTap: () async {
                        FocusScope.of(context).unfocus();
                        searchController.clear();
                        storeProductProvider.clearSearchProductsList();
                      },
                      child: SizedBox(
                        height: 24,
                        width: 24,
                        child: Center(
                          child: Icon(
                            Icons.cancel_outlined,
                            color: Colors.black,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                  )
                : null,
          ),
        ),
        padding12,
          InkWell(
            onTap: () {
              showAddShopProductDialog(context, store);
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
        padding12,
        InkWell(
          onTap: () {
            storeProductProvider.pickAndUploadExcel(context, store);
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
                'Upload Product Sheet .xlxs',
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
                  // showAddShopDialog(context);
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
    bool isActive = product.status == 1;

    return InkWell(
      onTap: () {
        showUpdateShopProductDialog(context, product);
      },
      child: FractionallySizedBox(
        widthFactor: 1 / 3.16,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 700,
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 0),
                  blurRadius: 7,
                  spreadRadius: 0,
                  color: Colors.black.withOpacity(.25),
                ),
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
                        style: getMediumStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        maxLines: 1,
                      ),
                    ),
                  ),

                  /// Product Image
                  Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(
                          '${product.img}',
                          cacheKey: '${product.img}',
                          cacheManager: CacheManager(
                            Config(
                              '${product.img}',
                              stalePeriod: const Duration(days: 5),
                            ),
                          ),
                        ),
                        fit: BoxFit.contain,
                        onError: (error, stackTrace) {
                          print(
                              "ERROR WHILE LOADING IMAGE URL : ${product.img} & error : $error");
                        },
                      ),
                      gradient: const LinearGradient(
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Status Switch
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Product Status',
                              style: getMediumStyle(
                                color: AppColors.textColor,
                                fontSize: 16,
                              ),
                            ),
                            Switch(
                              value: isActive,
                              activeColor: Colors.green,
                              onChanged: (value) async {
                                await showCustomConfirmationDialog(
                                  context: context,
                                  message: value
                                      ? "Are you sure you want to activate this product?"
                                      : "Are you sure you want to deactivate this product?",
                                  onConfirm: () async {
                                    await storeProductProvider
                                        .updateProductStatus(
                                      product: product,
                                    );
                                    await storeProductProvider
                                        .getStoreAnalytics(
                                      storeId: widget.storemodel.id!,
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                        padding10,
                        Row(
                          children: [
                            Text(
                              'Product Details',
                              style: getMediumStyle(
                                  color: AppColors.textColor, fontSize: 16),
                            ),
                            const Spacer(),
                            const SizedBox()
                          ],
                        ),
                        padding16,
                        _buildRow(
                            title: 'Category',
                            description: '${product.category.name}'),
                        Tooltip(
                          message: product.description,
                          // constraints: BoxConstraints(maxWidth: 250),
                          decoration: BoxDecoration(
                            color: Colors.black87,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          textStyle: getRegularStyle(color: Colors.white,fontSize: 11),
                          preferBelow: false,
                          child: _buildRow(
                              title: 'Description',
                              description: '${product.description}'),
                        ),
                        _buildRow(
                            title: 'Product Price',
                            description: '${product.price}'),
                        _buildRow(
                            title: 'Discounted Price',
                            description: '${product.discountPrice}'),
                        _buildRow(
                            title: 'Quantity (value/unit)',
                            description:
                                '${product.unitValue}/${product.unit}'),
                        _buildRow(
                            title: 'Brand Name',
                            description: '${product.brand}'),
                        _buildRow(
                            title: 'Shop Name',
                            description: '${product.store.name}'),
                        _buildRow(
                            title: 'Shop Address',
                            description: '${product.store.address}'),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            ///  Delete Icon - Top Right
            Positioned(
              top: 10,
              right: 10,
              child: InkWell(
                onTap: () async {
                  await showCustomConfirmationDialog(
                    context: context,
                    message: "Are you sure you want to delete this product?",
                    onConfirm: () async {
                      await storeProductProvider.deleteProduct(
                          product: product);
                      await storeProductProvider.getStoreAnalytics(
                          storeId: widget.storemodel.id!);
                    },
                  );
                },
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.delete_outline, color: Colors.red),
                ),
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
                  textAlign: TextAlign.justify,
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
  final VoidCallback? onEdit; // Optional callback for edit action

  const StoreCard({
    Key? key,
    required this.store,
    this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cover Image with Edit Button
          Stack(
            children: [
              InkWell(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
                onTap: () {
                  AppFunctions.openImageInNewTab(store.cImg);
                },
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(12)),
                  child: CachedNetworkImage(
                    imageUrl: store.cImg,
                    fit: BoxFit.cover,
                    height: 250,
                    width: double.infinity,
                    errorListener: (e) {},
                    errorWidget: (ctx, o, s) {
                      return Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(12)),
                          border: Border.all(color: Colors.black12),
                        ),
                        child: Icon(
                          Icons.image_not_supported_outlined,
                          color: AppColors.primaryColor,
                        ),
                      );
                    },
                  ),
                ),
              ),

              // Edit Button (top-right)
              Positioned(
                top: 8,
                right: 8,
                child: InkWell(
                  onTap: onEdit,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(Icons.edit,
                        color: AppColors.primaryColor, size: 18),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Store Info
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                // Front Image
                InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    AppFunctions.openImageInNewTab(store.fImg);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      imageUrl: store.fImg,
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover,
                      errorListener: (e) {},
                      errorWidget: (ctx, o, s) {
                        return Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.black12),
                          ),
                          child: Icon(
                            Icons.image_not_supported_outlined,
                            color: AppColors.primaryColor,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Name, Address, Status
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
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(width: 5),
                          InkWell(
                            onTap: () {
                              AppFunctions.openGoogleMapsAtCoordinates(
                                  store.latitude, store.longitude);
                            },
                            child: Icon(
                              Icons.location_on_outlined,
                              color: AppColors.primaryColor,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: 'Status: ',
                                style: getRegularStyle(color: Colors.grey)),
                            TextSpan(
                              text:
                                  "${store.status == 1 ? "Active" : "Inactive"}",
                              style: getMediumStyle(
                                  color: (store.status) == 1
                                      ? AppColors.primaryColor
                                      : Colors.red),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Consumer<StoreProvider>(
                          builder: (context, provider, child) {
                        return RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text: 'Category: ',
                                  style: getRegularStyle(color: Colors.grey)),
                              TextSpan(
                                text:
                                    "${provider.allCategoriesList?.where((cat) => cat.id == store.categoryId).firstOrNull?.name ?? "Not Defined"}",
                                style: getMediumStyle(
                                    color: AppColors.primaryColor),
                              ),
                            ],
                          ),
                        );
                      }),
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
