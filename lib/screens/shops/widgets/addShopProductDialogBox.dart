import 'package:chotu_admin/utils/app_Colors.dart';
import 'package:chotu_admin/utils/app_Paddings.dart';
import 'package:chotu_admin/utils/app_text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../generated/assets.dart';
import '../../../widgets/custom_TextField.dart';

class AddShopProductDialog extends StatefulWidget {
  @override
  _AddShopProductDialogState createState() => _AddShopProductDialogState();
}

class _AddShopProductDialogState extends State<AddShopProductDialog> {
  final _formKey = GlobalKey<FormState>();

  /// Controllers for input fields
  final _shopNameController = TextEditingController();
  final _categoryController = TextEditingController();
  final _productPriceController = TextEditingController();
  final _productDescriptionController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Add rider logic goes here
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product added successfully!')),
      );
      Navigator.of(context).pop(); // Close the dialog
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color(0xffffffff),
      title: Row(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              icon: SizedBox(
                  height: 34,
                  width: 34,
                  child: Center(child: Image.asset(Assets.iconsCross))),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Text(
            'Add Product',
            style: getBoldStyle(
              color: AppColors.textColor,
              fontSize: 20,
            ),
          ),
        ],
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * .5,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// Shop Image Container
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      width: 1,
                      color: AppColors.textFieldBorderColor,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Center(
                      child: SvgPicture.asset(
                        Assets.iconsMageUsersFill,
                      ),
                    ),
                  ),
                ),
                padding20,
                /// Shop Name and Shop Category Text-Fields
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: CustomTextField(
                          title: 'Product Name',
                          controller: _shopNameController,
                          obscureText: false,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          hintText: '',
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return "Please enter product name";
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: CustomTextField(
                          title: 'Product Category',
                          controller: _categoryController,
                          obscureText: false,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          hintText: '',
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return "Please enter product category";
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20), // More spacing between rows
                /// phone Number and Address Text-Fields
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: CustomTextField(
                          title: 'Product Price',
                          controller: _productPriceController,
                          obscureText: true,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          hintText: '',
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return "Please enter product price";
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: CustomTextField(
                            title: 'Product Description',
                            controller: _productDescriptionController,
                            obscureText: false,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.phone,
                            hintText: '',
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Please enter Product Description";
                              }
                              return null;
                            }),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

              ],
            ),
          ),
        ),
      ),
      /// actions
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            'Cancel',
            style: getRegularStyle(
              color: AppColors.textColor,
            ),
          ),
        ),
        InkWell(
          onTap: _submitForm,
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.primaryColor),
            child: Text(
              'Add Product',
              style: getMediumStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

void showAddShopProductDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => Container(child: AddShopProductDialog()),
  );
}
