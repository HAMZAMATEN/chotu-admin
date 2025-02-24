import 'package:chotu_admin/screens/shops/widgets/addNewShopDialogBox.dart';
import 'package:chotu_admin/screens/shops/widgets/addShopProductDialogBox.dart';
import 'package:chotu_admin/utils/app_Colors.dart';
import 'package:chotu_admin/utils/app_Paddings.dart';
import 'package:chotu_admin/utils/app_text_widgets.dart';
import 'package:chotu_admin/widgets/custom_Button.dart';
import 'package:chotu_admin/widgets/custom_TextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../generated/assets.dart';

class ShopProductsScreen extends StatefulWidget {
  @override
  State<ShopProductsScreen> createState() => _ShopProductsScreenState();
}

class _ShopProductsScreenState extends State<ShopProductsScreen> {
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Padding(
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
                  InkWell(
                    overlayColor: WidgetStatePropertyAll<Color>(Colors.transparent),
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Icon(Icons.arrow_back_ios))),
                  padding30,
                  /// Status Summary Cards
                  Row(
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
                  ),
                  padding30,




                  // Scrollable Data Table

                  Wrap(
                    // alignment: WrapAlignment.center,
                    // crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 16,
                    runSpacing: 16,
                    children: List.generate(10, (index) {
                      return _buildProductCard(context);
                    }),
                  ),
                ],
              ),
            ),
          ),
        ),
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
  Widget _buildProductCard(BuildContext context) {
    bool isActive = true; // Initial status (you can fetch this from your backend)

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
                  'Product Name - iPhone 11 Pro Max',
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
                  image: NetworkImage(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT2uHNWvGuM8JNluffrpa-t7oBVbmd3YqFIlA&s'), // Replace with actual image URL
                  fit: BoxFit.cover,
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
                  _buildRow(title: 'Category', description: 'Mobile Shop'),
                  _buildRow(title: 'Product Price', description: 'Best Selling Products'),
                  _buildRow(title: 'Product Detail', description: '10'),
                  _buildRow(
                      title: 'Shop Name', description: 'Johr Town Lahore Branch'),
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
              style: getRegularStyle(
                color: const Color(0xff454545),
                fontSize: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
