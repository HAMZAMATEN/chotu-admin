import 'package:chotu_admin/model/shop_model.dart';
import 'package:chotu_admin/providers/store_provider.dart';
import 'package:chotu_admin/screens/shops/shops_product_screen.dart';
import 'package:chotu_admin/screens/shops/widgets/addNewShopDialogBox.dart';
import 'package:chotu_admin/utils/app_Paddings.dart';
import 'package:chotu_admin/utils/app_colors.dart';
import 'package:chotu_admin/utils/app_text_widgets.dart';
import 'package:chotu_admin/widgets/custom_Button.dart';
import 'package:chotu_admin/widgets/custom_TextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../generated/assets.dart';
import 'widgets/shop_screen_widgets.dart';


class ShopsScreen extends StatefulWidget {
  @override
  State<ShopsScreen> createState() => _ShopsScreenState();
}

class _ShopsScreenState extends State<ShopsScreen> {
  TextEditingController searchController = TextEditingController();

  late StoreProvider storeProvider;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<StoreProvider>(context,listen: false).getAllStores();
    Provider.of<StoreProvider>(context,listen: false).getAllCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<StoreProvider>(builder: (context, provider, child) {
          storeProvider = provider;
          if(provider.allStoresList != null ){
            provider.activeStoresLength = provider.allStoresList!.where((store)=>store.status == 1).toList().length;
            provider.inActiveStoresLength = provider.allStoresList!.where((store)=>store.status == 0).toList().length;
          }
          return Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 0),
                  color: Colors.black.withOpacity(.1),
                  blurRadius: 2,
                  spreadRadius: 0,
                )
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: (provider.allStoresList == null || provider.allCategoriesList == null)
                    ? shimmerShopWidget(context)
                    : shopBodyWidget(context),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget shopBodyWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Expanded(
              child: buildStatsCard('Total Shops',
                  storeProvider.allStoresList?.length ?? 0, Colors.orange),
            ),
            padding12,
            Expanded(
              child: buildStatsCard(
                  'Active', storeProvider.activeStoresLength, Colors.green),
            ),
            padding12,
            Expanded(
              child: buildStatsCard(
                  'InActive', storeProvider.inActiveStoresLength, Colors.red),
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
                controller: searchController,
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
                onChanged: (val){
                  setState(() {});
                }
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
        Align(
          alignment: Alignment.topLeft,
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.start,
            runAlignment: WrapAlignment.start,
            children: List.generate(storeProvider.allStoresList!.length, (index) {
              StoreModel store = storeProvider.allStoresList![index];
              if(searchController.text.isEmpty || store.name.contains(searchController.text.trim())){
                return ShopCardWidget(storeModel: store);
              }else{
                return SizedBox();
              }

            }),
          ),
        ),
      ],
    );
  }

  Widget shimmerShopWidget(BuildContext context) {
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
}
