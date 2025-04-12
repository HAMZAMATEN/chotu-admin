import 'dart:convert';

import 'package:chotu_admin/providers/riders_provider.dart';
import 'package:chotu_admin/utils/app_Colors.dart';
import 'package:chotu_admin/utils/app_Paddings.dart';
import 'package:chotu_admin/utils/app_constants.dart';
import 'package:chotu_admin/utils/app_text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../../generated/assets.dart';
import '../../../widgets/custom_TextField.dart';

class AddRiderDialog extends StatefulWidget {
  @override
  _AddRiderDialogState createState() => _AddRiderDialogState();
}

class _AddRiderDialogState extends State<AddRiderDialog> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<RidersProvider>(
      builder: (context, provider, child) {
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
                'Add Rider',
                style: getBoldStyle(
                  color: AppColors.textColor,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * .5,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () async {
                      await provider.pickRiderImage(context);
                    },
                    child: Container(
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
                        child: provider.storeRiderImage == null
                            ? Center(
                                child: SvgPicture.asset(
                                  Assets.iconsMageUsersFill,
                                ),
                              )
                            : Image.memory(
                                provider.storeRiderImage!['image'],
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ),
                  padding12,
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: CustomTextField(
                                    hintText: 'Full Name',
                                    isBoldHint: true,
                                    controller: provider.nameController,
                                    obscureText: false,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.text,
                                    title: '',
                                    validator: (val) {
                                      if (val == null || val.isEmpty) {
                                        return "Please enter name";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: CustomTextField(
                                    hintText: 'Email',
                                    isBoldHint: true,
                                    controller: provider.emailController,
                                    obscureText: false,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.emailAddress,
                                    title: '',
                                    validator: (val) {
                                      if (val == null || val.isEmpty) {
                                        return "Please enter email";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: CustomTextField(
                                    hintText: 'Password (At-least 8 characters)',
                                    isBoldHint: true,
                                    controller: provider.passwordController,
                                    obscureText: false,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.text,
                                    title: '',
                                    validator: (val) {
                                      if (val == null || val.isEmpty) {
                                        return "Please enter password";
                                      } else if (val.length < 8) {
                                        return "Password must contain at least 8 characters";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: CustomTextField(
                                      hintText:
                                          'Phone Number (Must have 11 digits)',
                                      isBoldHint: true,
                                      controller: provider.phoneController,
                                      obscureText: false,
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.phone,
                                      title: '',
                                      validator: (val) {
                                        if (val == null || val.isEmpty) {
                                          return "Please enter number";
                                        } else if (val.length != 11) {
                                          return "Number must be exactly 13 digits";
                                        }
                                        return null;
                                      }),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: CustomTextField(
                                      hintText: 'CNIC (Must have 13 digits)',
                                      isBoldHint: true,
                                      controller: provider.cnicController,
                                      obscureText: false,
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.number,
                                      title: '',
                                      validator: (val) {
                                        if (val == null || val.isEmpty) {
                                          return "Please enter CNIC";
                                        } else if (val.length != 13) {
                                          return "CNIC must be exactly 13 digits";
                                        }
                                        return null;
                                      }),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: CustomTextField(
                                    hintText: 'City',
                                    isBoldHint: true,
                                    controller: provider.cityController,
                                    obscureText: false,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.text,
                                    title: '',
                                    // validator: (val) {
                                    //   if (val == null || val.isEmpty) {
                                    //     return "Please enter city";
                                    //   }
                                    //   return null;
                                    // }
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomTextField(
                                        hintText: 'Full Address',
                                        isBoldHint: true,
                                        controller: provider.addressController,
                                        obscureText: false,
                                        textInputAction: TextInputAction.next,
                                        keyboardType: TextInputType.text,
                                        title: '',
                                        // validator: (val) {
                                        //   if (val == null || val.isEmpty) {
                                        //     return "Please enter full address";
                                        //   }
                                        //   return null;
                                        // },
                                        onChanged: (value) {
                                          setState(() {
                                            provider.isSearching = true;
                                          });
                                          provider.getPlacePredictions(value);
                                        },
                                      ),
                                      if (provider.isSearching &&
                                          provider.placePredictions.isNotEmpty)
                                        Container(
                                          height: 200,
                                          child: ListView.builder(
                                            itemCount: provider
                                                .placePredictions.length,
                                            itemBuilder: (context, index) {
                                              final prediction = provider
                                                  .placePredictions[index];

                                              return Column(
                                                children: [
                                                  padding12,
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 16),
                                                    child: GestureDetector(
                                                      onTap: () async {
                                                        // Fetch the selected address details (lat, lng) using the place_id
                                                        final details =
                                                            await provider
                                                                .getPlaceDetails(
                                                                    prediction[
                                                                        'place_id']);

                                                        if (details != null) {
                                                          final lat = details[
                                                                      'geometry']
                                                                  ['location']
                                                              ['lat'];
                                                          final lng = details[
                                                                      'geometry']
                                                                  ['location']
                                                              ['lng'];

                                                          provider.setLatLang(
                                                              lat, lng);

                                                          // Update your address controller with the selected address
                                                          provider.addressController
                                                                  .text =
                                                              prediction[
                                                                  'description'];

                                                          // Now you have latitude and longitude
                                                          print(
                                                              'Latitude: $lat, Longitude: $lng');

                                                          // Clear predictions and stop searching
                                                          setState(() {
                                                            provider
                                                                .placePredictions
                                                                .clear();
                                                            provider.isSearching =
                                                                false;
                                                          });
                                                        }
                                                      },
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .location_on_outlined,
                                                            color: AppColors
                                                                .textColor,
                                                          ),
                                                          SizedBox(width: 8),
                                                          Expanded(
                                                            child: Text(
                                                              prediction[
                                                                  'description'],
                                                              style:
                                                                  getSemiBoldStyle(
                                                                color: AppColors
                                                                    .textColor,
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  padding6,
                                                  Divider(
                                                    height: 0,
                                                    thickness: .5,
                                                  ),
                                                  padding6,
                                                ],
                                              );
                                            },
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: CustomTextField(
                                    hintText: 'Flat/Society',
                                    isBoldHint: true,
                                    controller: provider.flatSocietyController,
                                    obscureText: false,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.text,
                                    title: '',
                                    // validator: (val) {
                                    //   if (val == null || val.isEmpty) {
                                    //     return "Please enter flat/society";
                                    //   }
                                    //   return null;
                                    // }
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: CustomTextField(
                                    hintText: 'Flat/House No',
                                    isBoldHint: true,
                                    controller: provider.flatHouseNoController,
                                    obscureText: false,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.text,
                                    title: '',
                                    // validator: (val) {
                                    //   if (val == null || val.isEmpty) {
                                    //     return "Please enter flat/house no.";
                                    //   }
                                    //   return null;
                                    // }
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: CustomTextField(
                                    hintText: 'Floor',
                                    isBoldHint: true,
                                    controller: provider.floorController,
                                    obscureText: false,
                                    textInputAction: TextInputAction.done,
                                    keyboardType: TextInputType.text,
                                    title: '',
                                    // validator: (val) {
                                    //   if (val == null || val.isEmpty) {
                                    //     return "Please enter floor";
                                    //   }
                                    //   return null;
                                    // }
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
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
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  provider.addRiderToDataBase(context);
                  // Add rider logic goes here
                }
              },
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.primaryColor),
                child: Text(
                  'Add Rider',
                  style: getMediumStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

void showAddRiderDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => Container(child: AddRiderDialog()),
  );
}
