import 'dart:convert';

import 'package:chotu_admin/model/product_model.dart';
import 'package:chotu_admin/model/shop_model.dart';
import 'package:chotu_admin/providers/store_product_provider.dart';
import 'package:chotu_admin/providers/store_provider.dart';
import 'package:chotu_admin/utils/app_Colors.dart';
import 'package:chotu_admin/utils/app_Paddings.dart';
import 'package:chotu_admin/utils/app_text_widgets.dart';
import 'package:chotu_admin/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../generated/assets.dart';
import '../../../../widgets/custom_TextField.dart';

class UpdateShopProductDialog extends StatefulWidget {
  final ProductModel productModel;

  const UpdateShopProductDialog({super.key, required this.productModel});

  @override
  _UpdateShopProductDialogState createState() =>
      _UpdateShopProductDialogState();
}

class _UpdateShopProductDialogState extends State<UpdateShopProductDialog> {
  final _formKey = GlobalKey<FormState>();

  /// Controllers for input fields
  TextEditingController nameController = TextEditingController();
  TextEditingController brandNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController discountPriceController = TextEditingController();
  TextEditingController unitController = TextEditingController();
  TextEditingController unitValueController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController categoryController = TextEditingController();

  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<StoreProductProvider>();
      provider.productCategoryId = widget.productModel.category.id;
      categoryController.text = widget.productModel.category.name!;
      nameController.text = widget.productModel.name;
      brandNameController.text = widget.productModel.brand;
      priceController.text = widget.productModel.price;
      discountPriceController.text = widget.productModel.discountPrice;
      unitController.text = widget.productModel.unit;
      unitValueController.text = widget.productModel.unitValue;
      descriptionController.text = widget.productModel.description;
      // provider.productImageMap = {
      //   'image': base64Decode(widget.productModel.img).first,
      //   'name': widget.productModel.name,
      // };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StoreProductProvider>(builder: (context, provider, child) {
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
                  InkWell(
                    borderRadius: BorderRadius.circular(100),
                    onTap: () async {
                      await provider.pickProductImage(context);
                    },
                    child: Container(
                      height: 140,
                      width: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          width: 1.3,
                          color: AppColors.textFieldBorderColor,
                        ),
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: provider.productImageMap != null
                              ? Image.memory(
                                  provider.productImageMap!['image'],
                                  fit: BoxFit.cover,
                                )
                              : Image.network(
                                  '${widget.productModel.img}',
                                  fit: BoxFit.cover,
                                )
                          // Center(
                          //         child: Column(
                          //           mainAxisAlignment: MainAxisAlignment.center,
                          //           children: [
                          //             SvgPicture.asset(
                          //               Assets.iconsMageUsersFill,
                          //             ),
                          //             Text(
                          //               'jpg,png or jpeg',
                          //               style: getLightStyle(
                          //                   color: Colors.black54, fontSize: 14),
                          //             )
                          //           ],
                          //         ),
                          //       ),
                          ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  /// Product Category Section
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: CustomTextField(
                            title: 'Product Category',
                            enabled: false,
                            controller: categoryController,
                            obscureText: false,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            hintText: 'Select from drop down button',
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Please select product's category";
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      Consumer<StoreProvider>(
                          builder: (context, provider2, chil) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Container(
                            margin: EdgeInsets.only(top: 24),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors.textFieldBorderColor),
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white),
                            child: provider2.allCategoriesList == null
                                ? Text("No Categories Found")
                                : DropdownButton(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    borderRadius: BorderRadius.circular(25),
                                    hint: Text("Select"),
                                    items: provider2.allCategoriesList!
                                        .map((e) => DropdownMenuItem(
                                              child: Text(e.name ?? ""),
                                              value: e.name,
                                            ))
                                        .toList()
                                        .where((e) => e.enabled == true)
                                        .toList(),
                                    onChanged: (val) {
                                      if (val != null) {
                                        categoryController.text = val;
                                        provider.updateProductCategoryId(
                                            provider2.allCategoriesList!
                                                .where((e) => e.name == val)
                                                .first
                                                .id!);
                                      }
                                    },
                                  ),
                          ),
                        );
                      }),
                    ],
                  ),
                  const SizedBox(height: 20),

                  /// Product Name and Brand Text-Fields
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: CustomTextField(
                            title: 'Product Name',
                            controller: nameController,
                            obscureText: false,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            hintText: "Biotin 5000mcg",
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Please enter product's name";
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
                            title: "Product's Brand",
                            controller: brandNameController,
                            obscureText: false,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            hintText: 'Nutrifactor Pakistan Ltd',
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Please enter product's brand name";
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20), // More spacing between rows

                  /// price and discounted price Text-Fields
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: CustomTextField(
                              title: "Product's Price(Rs)",
                              controller: priceController,
                              obscureText: false,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
                              hintText: '2000',
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return "Please enter product's price";
                                }
                                return null;
                              },
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ]),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: CustomTextField(
                              title: "Product's Discounted Price(Rs)",
                              controller: discountPriceController,
                              obscureText: false,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
                              hintText: "1800",
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return "Please enter product's discounted price";
                                }
                                return null;
                              },
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ]),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  /// unit and unit value Text-Fields
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: CustomTextField(
                            title: "Product's Unit",
                            controller: unitController,
                            obscureText: false,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            hintText: 'gram,kg,liter,pcs etc.',
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Please enter product's unit";
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
                            title: "Product's Unit Value",
                            controller: unitValueController,
                            obscureText: false,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.phone,
                            hintText: '1,5,10 etc.',
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Please enter product's unit value";
                              }
                              return null;
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  /// products Description
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: CustomTextField(
                      title: "Product's Description",
                      minLines: 5,
                      controller: descriptionController,
                      obscureText: false,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.text,
                      hintText: 'Write some description about your product',
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "Please enter product's description";
                        }
                        return null;
                      },
                    ),
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
            onTap: () async {
              // if (provider.productImageMap == null) {
              //   AppFunctions.showToastMessage(
              //       message: "Select Product's Image");
              //   return;
              // }
              if (provider.productCategoryId == null) {
                AppFunctions.showToastMessage(
                    message: "Select Product's Category");
                return;
              }
              if (_formKey.currentState!.validate()) {
                if (double.parse(priceController.text) <
                    double.parse(discountPriceController.text)) {
                  AppFunctions.showToastMessage(
                      message:
                          'Discounted price must be less than actual price');
                  return;
                } else {

                  Map<String, dynamic> body = {
                    'id':'${widget.productModel.id}',
                    'name': '${nameController.text}',
                    'category_id': '${provider.productCategoryId!}',
                    'brand': '${brandNameController.text}',
                    'price': '${priceController.text}',
                    'discount_price': '${discountPriceController.text}',
                    'unit': '${unitController.text}',
                    'unit_value': '${unitValueController.text}',
                    'description': '${descriptionController.text}',
                    'store_id': '${widget.productModel.store.id}',
                  };
                  await provider.updateProductInDataBase(body, context);
                  await provider.getStoreProducts(
                      storeId: widget.productModel.store.id!);

                  nameController.clear();
                  brandNameController.clear();
                  priceController.clear();
                  discountPriceController.clear();
                  unitController.clear();
                  unitValueController.clear();
                  descriptionController.clear();
                }
              }
            },
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.primaryColor),
              child: Text(
                'Update Product',
                style: getMediumStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}

void showUpdateShopProductDialog(
    BuildContext context, ProductModel productModel) {
  showDialog(
    context: context,
    builder: (context) => Container(
        child: UpdateShopProductDialog(
      productModel: productModel,
    )),
  );
}
