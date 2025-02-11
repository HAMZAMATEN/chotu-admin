import '../../../models/category.dart';
import '../../../models/shop.dart';
import '../../../utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import '../../../utility/constants.dart';
import '../../../widgets/category_image_card.dart';
import '../../../widgets/custom_dropdown.dart';
import '../../../widgets/custom_text_field.dart';
import '../provider/shop_provider.dart';

class ShopSubmitForm extends StatelessWidget {
  final Shop? shop;

  const ShopSubmitForm({super.key, this.shop});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    //TODO: should complete call setDataForUpdateCategory
    return SingleChildScrollView(
      child: Form(
        key: context.shopProvider.addShopFormKey,
        child: Container(
          padding: EdgeInsets.all(defaultPadding),
          width: size.width * 0.3,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Gap(defaultPadding),
              Gap(defaultPadding),
              Consumer<ShopProvider>(
                builder: (context, catProvider, child) {
                  return CategoryImageCard(
                    labelText: "Category",
                    imageFile: catProvider.selectedImage,
                    imageUrlForUpdateImage: shop?.imageUrl,
                    onTap: () {
                      catProvider.pickImage();
                    },
                  );
                },
              ),
              CustomTextField(
                controller: context.shopProvider.shopNameCtrl,
                labelText: 'Shop Name',
                onSave: (val) {},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a shop name';
                  }
                  return null;
                },
              ),
              CustomTextField(
                controller: context.shopProvider.shopDesCtrl,
                labelText: 'Description',
                onSave: (val) {},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              CustomTextField(
                controller: context.shopProvider.shopAddressCtrl,
                labelText: 'Select Location',
                onSave: (val) {},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a location';
                  }
                  return null;
                },
              ),
              SwitchListTile(
                title: Text("Active"),
                value: true,
                onChanged: (val) {},
              ),
              Gap(defaultPadding * 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: secondaryColor,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the popup
                    },
                    child: Text('Cancel'),
                  ),
                  Gap(defaultPadding),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: primaryColor,
                    ),
                    onPressed: () {
                      // Validate and save the form
                      if (context.shopProvider.addShopFormKey.currentState!.validate()) {
                        context.shopProvider.addShopFormKey.currentState!.save();
                        //TODO: should complete call submitCategory
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text('Submit'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// How to show the shop popup
void showAddShopForm(BuildContext context, Shop? shop) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: bgColor,
        title: Center(child: Text('Add Shop'.toUpperCase(), style: TextStyle(color: primaryColor))),
        content: ShopSubmitForm(shop: shop),
      );
    },
  );
}
