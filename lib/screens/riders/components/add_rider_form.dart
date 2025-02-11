import '../../../models/category.dart';
import '../../../models/rider.dart';
import '../../../models/shop.dart';
import '../../../utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import '../../../utility/constants.dart';
import '../../../widgets/category_image_card.dart';
import '../../../widgets/custom_dropdown.dart';
import '../../../widgets/custom_text_field.dart';
import '../provider/rider_provider.dart';

class RiderSubmitForm extends StatelessWidget {
  final Rider? rider;

  const RiderSubmitForm({super.key, this.rider});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    //TODO: should complete call setDataForUpdateCategory
    return SingleChildScrollView(
      child: Form(
        key: context.riderProvider.addRiderFormKey,
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
              Consumer<RiderProvider>(
                builder: (context, catProvider, child) {
                  return CategoryImageCard(
                    labelText: "Rider",
                    imageFile: catProvider.selectedImage,
                    imageUrlForUpdateImage:rider?.profileImage,
                    onTap: () {
                      catProvider.pickImage();
                    },
                  );
                },
              ),
              CustomTextField(
                controller: context.riderProvider.nameCtrl,
                labelText: 'Rider Name',
                onSave: (val) {},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a rider name';
                  }
                  return null;
                },
              ),
              CustomTextField(
                controller: context.riderProvider.descCtrl,
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
                controller: context.riderProvider.locCtrl,
                labelText: 'Phone No',
                onSave: (val) {},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a phone no';
                  }
                  return null;
                },
              ),
              CustomTextField(
                controller: context.riderProvider.locCtrl,
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
                      if (context.riderProvider.addRiderFormKey.currentState!.validate()) {
                        context.riderProvider.addRiderFormKey.currentState!.save();
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

// How to show the category popup
void showAddRiderForm(BuildContext context,Rider? rider) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: bgColor,
        title: Center(child: Text('Add Rider'.toUpperCase(), style: TextStyle(color: primaryColor))),
        content: RiderSubmitForm(rider: rider),
      );
    },
  );
}
