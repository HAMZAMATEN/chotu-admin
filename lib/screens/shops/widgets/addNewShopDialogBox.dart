import 'package:chotu_admin/providers/store_provider.dart';
import 'package:chotu_admin/providers/users_provider.dart';
import 'package:chotu_admin/utils/app_Colors.dart';
import 'package:chotu_admin/utils/app_Paddings.dart';
import 'package:chotu_admin/utils/app_text_widgets.dart';
import 'package:chotu_admin/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';

import '../../../generated/assets.dart';
import '../../../widgets/custom_TextField.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class AddShopDialog extends StatefulWidget {
  @override
  _AddShopDialogState createState() => _AddShopDialogState();
}

class _AddShopDialogState extends State<AddShopDialog> {
  final _formKey = GlobalKey<FormState>();

  /// Controllers for input fields
  final _shopNameController = TextEditingController();
  final _categoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<StoreProvider>(builder: (context, provider, child) {
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
                onPressed: () {
                  provider.setImagesMapsToNull();
                  Navigator.pop(context);
                },
              ),
            ),
            Text(
              ' Add Shop',
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
                      await provider.pickStoreImage(context);
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
                        child: provider.storeImageMap == null
                            ? Center(
                                child: SvgPicture.asset(
                                  Assets.iconsMageUsersFill,
                                ),
                              )
                            : Image.memory(
                                provider.storeImageMap!['image'],
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ),
                  padding20,

                  /// Shop Name and Shop Category Text-Fields
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: CustomTextField(
                      title: 'Shop Name',
                      controller: _shopNameController,
                      obscureText: false,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      hintText: '',
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "Please enter shop name";
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 20), // More spacing between rows
                  /// phone Number and Address Text-Fields
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: CustomTextField(
                            title: 'Shop Category',
                            enabled: false,
                            controller: _categoryController,
                            obscureText: false,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            hintText: '',
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Please enter category";
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Container(
                          margin: EdgeInsets.only(top: 24),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: AppColors.textFieldBorderColor),
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white),
                          child: provider.allCategoriesList == null
                              ? Text("No Categories Found")
                              : DropdownButton(
                                  hint: Text("Select"),
                                  items: provider.allCategoriesList!
                                      .map((e) => DropdownMenuItem(
                                            child: Text(e.name),
                                            value: e.name,
                                          ))
                                      .toList()
                                      .where((e) => e.enabled == true)
                                      .toList(),
                                  onChanged: (val) {
                                    if (val != null) {
                                      _categoryController.text = val;
                                      provider.updateCategoryId(provider.allCategoriesList!.where((e)=>e.name == val).first.id!);
                                    }
                                  },
                                ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () async {
                        await provider.pickStoreCoverImage(context);
                      },
                      child: Container(
                        height: 250,
                        width: 350,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            width: 1,
                            color: AppColors.textFieldBorderColor,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: provider.storeCoverImageMap == null
                              ? Center(
                                  child: Icon(
                                    Icons.image,
                                    color: AppColors.textFieldBorderColor,
                                  ),
                                )
                              : Image.memory(
                                  provider.storeCoverImageMap!['image'],
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "PICK LOCATION",
                      style: getBoldStyle(color: Colors.black, fontSize: 24),
                    ),
                  ),
                  const SizedBox(height: 10),
                  GoogleMapPicker(),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: CustomTextField(
                        title: 'Address',
                        enabled: true,
                        controller: provider.addressController,
                        obscureText: false,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.phone,
                        hintText: '',
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "Please enter shop address";
                          }
                          return null;
                        }),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: CustomTextField(
                            enabled: false,
                            title: 'Latitude',
                            controller: provider.latitudeController,
                            obscureText: false,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            hintText: '',
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Please enter category";
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
                              title: 'Longitude',
                              enabled: false,
                              controller: provider.longitudeController,
                              obscureText: false,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.phone,
                              hintText: '',
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return "Please enter shop address";
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
            onPressed: () {
              provider.setImagesMapsToNull();
              Navigator.of(context).pop();
            },
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
                if (provider.storeImageMap != null) {
                  if (provider.storeCoverImageMap != null) {

                    if(provider.categoryId != null){
                      if (provider.latitudeController.text.isNotEmpty &&
                          provider.longitudeController.text.isNotEmpty) {

                        Map<String,String> body = {
                          'name': _shopNameController.text,
                          'category_id': provider.categoryId.toString(),
                          'address': provider.addressController.text,
                          'latitude': provider.latitudeController.text,
                          'longitude': provider.longitudeController.text,
                        };

                         provider.addShopToDataBase(body,context);

                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   const SnackBar(
                        //       content: Text('Shop added successfully!')),
                        // );
                        // Navigator.of(context).pop(); // Close the dialog
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Please Select Store Address!')),
                        );
                      }
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Please Select Store Category')),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Please Select Store Image!')),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please Select Store Image!')),
                  );
                }
              }
            },
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.primaryColor),
              child: Text(
                'Add Shop',
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

void showAddShopDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => Container(child: AddShopDialog()),
  );
}

class GoogleMapPicker extends StatefulWidget {
  @override
  _GoogleMapPickerState createState() => _GoogleMapPickerState();
}

class _GoogleMapPickerState extends State<GoogleMapPicker> {
  late GoogleMapController _mapController;
  LatLng? _currentLatLng;
  LatLng? _selectedLatLng;
  Set<Marker> _markers = {};

  // late StoreProvider storeProvider;

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    // bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    // if (!serviceEnabled) {
    //   print('Location services are disabled.');
    //   return;
    // }


    try{
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever ||
          permission == LocationPermission.denied) {
        print('Location permissions are denied.');
        setState(() {});
        return;
      }

      Position position = await Geolocator.getCurrentPosition();
      setState(() {
        _currentLatLng = LatLng(position.latitude, position.longitude);
        _markers.add(
          Marker(
            markerId: MarkerId("current"),
            position: _currentLatLng!,
            infoWindow: InfoWindow(title: "Current Location"),
          ),
        );
        Provider.of<StoreProvider>(context, listen: false).latitudeController.text = position.latitude.toString();
        Provider.of<StoreProvider>(context, listen: false).longitudeController.text = position.longitude.toString();
      });
    }catch(e){
      print("EXCEPTION WHILE _determinePosition $e");
    }

  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  Future<void> _onMapTapped(LatLng latLng) async {
    setState(() {
      _selectedLatLng = latLng;
      _markers.removeWhere((m) => m.markerId == MarkerId("selected"));
      _markers.add(
        Marker(
          markerId: MarkerId("selected"),
          position: latLng,
          infoWindow: InfoWindow(title: "Selected Location"),
        ),
      );
      Provider.of<StoreProvider>(context, listen: false).latitudeController.text = latLng.latitude.toString();
      Provider.of<StoreProvider>(context, listen: false).longitudeController.text = latLng.longitude.toString();
    });
    print("Selected lat: ${latLng.latitude}, long: ${latLng.longitude}");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 600,
      height: 400,
      child: _currentLatLng == null
          ? Center(child: CircularProgressIndicator())
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                target: _currentLatLng!,
                zoom: 14,
              ),
              onMapCreated: _onMapCreated,
              markers: _markers,
              onTap: _onMapTapped,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
            ),
    );
  }
}
