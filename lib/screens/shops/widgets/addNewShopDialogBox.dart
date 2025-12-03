import 'dart:async';

import 'package:chotu_admin/providers/store_provider.dart';
import 'package:chotu_admin/utils/app_Colors.dart';
import 'package:chotu_admin/utils/app_Paddings.dart';
import 'package:chotu_admin/utils/app_text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../generated/assets.dart';
import '../../../widgets/custom_TextField.dart';

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
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      Assets.iconsMageUsersFill,
                                    ),
                                    Text('jpg,png or jpeg',style: getLightStyle(color: Colors.black54,fontSize: 14),)
                                  ],
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
                              padding: EdgeInsets.symmetric(horizontal: 10),
                                  borderRadius: BorderRadius.circular(25),
                                  hint: Text("Select"),
                                  items: provider.allCategoriesList!
                                      .map((e) => DropdownMenuItem(
                                            child: Text(e.name??""),
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
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.image,
                                        color: AppColors.textFieldBorderColor,
                                        size: 35,
                                      ),
                                      Text('jpg,png or jpeg',style: getLightStyle(color: Colors.black54,fontSize: 14),)
                                    ],
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
                        title: 'Address ${provider.selectedAddress  != "" ?  ': '+provider.selectedAddress : ''}',
                        enabled: true,
                        controller: provider.locationSearchController,
                        obscureText: false,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.phone,
                        hintText: '',
                        validator: (val) {
                          if (provider.selectedAddress.isEmpty || provider.selectedAddress == "") {
                            return "Please enter shop address";
                          }
                          return null;
                        },
                      onFieldSubmitted: (value){
                        if (value.isNotEmpty) {
                          provider.fetchLocationIQPlaces(query: value);
                        } else {
                          provider.clearPlacesSuggestions();
                        }
                      },
                      // onChanged: (value) {
                      //   if (value.isNotEmpty) {
                      //     provider.fetchSuggestions(value);
                      //   } else {
                      //     provider.clearSuggestions();
                      //   }
                      // },
                    ),

                  ),
                  const SizedBox(height: 20),
                  if(provider.suggestionList.isNotEmpty)...[
                    Container(
                      height: 400,
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: provider.suggestionList.length,
                        itemBuilder: (context, index) {
                          final place = provider.suggestionList[index];
                          return ListTile(
                            title: Text(
                              // place['description'] ?? '',
                              place.displayName ?? '',
                              style: getRegularStyle(
                                  color: AppColors.textColor, fontSize: 12),
                            ),
                            subtitle: Text(
                              '${place.address?.city ?? ''}, ${place.address?.state ?? ''}',
                              style: getRegularStyle(
                                  color: AppColors.textColor, fontSize: 10),
                            ),
                            onTap: () async {
                              // provider.selectedAddress = place["description"] ?? '';
                              provider.selectedAddress = place.displayName ?? '';
                              print("SELECTED ADDRESS IS ${place.displayName}");

                              if(place.lat != null && place.lon != null){
                                LatLng placLatLng = LatLng(double.parse(place.lat!),double.parse(place.lon!));
                                provider.updateLatLang(placLatLng);
                                if(provider.mapController != null){
                                  debugPrint("MAP CONTROLLER IS NOT NULL");
                                  provider.mapController!.animateCamera(
                                    CameraUpdate.newLatLng(placLatLng),
                                  );
                                  Marker marker = Marker(
                                    markerId: MarkerId("selected"),
                                    position: placLatLng,
                                    infoWindow: InfoWindow(title: "Selected Location"),
                                  );
                                  provider.addMarker(marker);
                                }else{
                                  debugPrint("MAP CONTROLLER IS NULL");
                                }
                              }


                              // final placeId = place["place_id"];
                              // if (placeId != null) {
                              //   final latLng = await provider.getPlaceDetails(placeId);
                              //   if (latLng != null) {
                              //     print("PICKED LAT LANG ARE:::$latLng");
                              //     if(provider.mapController != null){
                              //       print("MAP CONTROLLER IS NOT NULL");
                              //       provider.mapController!.animateCamera(
                              //         CameraUpdate.newLatLng(latLng),
                              //       );
                              //       Marker marker = Marker(
                              //         markerId: MarkerId("selected"),
                              //         position: latLng,
                              //         infoWindow: InfoWindow(title: "Selected Location"),
                              //       );
                              //       provider.addMarker(marker);
                              //     }else{
                              //       print("MAP CONTROLLER IS NULL");
                              //     }
                              //
                              //   }
                              // }
                              FocusScope.of(context).unfocus();
                              provider.clearSuggestions();
                            },
                          );
                        },
                      ),
                    )
                  ],
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
                          'address': provider.selectedAddress,
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

  GoogleMapPicker({Key? key,}) : super(key: key);
  @override
  _GoogleMapPickerState createState() => _GoogleMapPickerState();
}

class _GoogleMapPickerState extends State<GoogleMapPicker> {

  LatLng? _currentLatLng;
  LatLng? _selectedLatLng;

  // late StoreProvider storeProvider;

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    try{
      setState(() {
        _currentLatLng = LatLng(24.86146, 67.00994); // Default to Karachi coordinates
        Provider.of<StoreProvider>(context,listen: false).markers.add(
          Marker(
            markerId: MarkerId("current"),
            position: _currentLatLng!,
            // infoWindow: InfoWindow(title: "Current Location"),
          ),
        );
        Provider.of<StoreProvider>(context, listen: false).selectedAddress = "Karachi Sindh Pakistan";
        Provider.of<StoreProvider>(context, listen: false).latitudeController.text = _currentLatLng!.latitude.toString();
        Provider.of<StoreProvider>(context, listen: false).longitudeController.text = _currentLatLng!.longitude.toString();
      });
    }catch(e){
      print("EXCEPTION WHILE adding marker $e");
    }

  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StoreProvider>(
      builder: (context,provider,child) {
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
                  onMapCreated: (GoogleMapController controller) {
                    provider.setMapController(controller);
                  },
                  markers: provider.markers,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                ),
        );
      }
    );
  }
}
