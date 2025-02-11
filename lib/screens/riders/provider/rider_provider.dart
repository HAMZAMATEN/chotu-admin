import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/data/data_provider.dart';
import '../../../models/rider.dart';
import '../../../services/http_services.dart';
class RiderProvider extends ChangeNotifier {

  HttpService service = HttpService();
  final DataProvider _dataProvider;
  final addRiderFormKey = GlobalKey<FormState>();
  final riderFormKey = GlobalKey<FormState>();

  TextEditingController nameCtrl = TextEditingController();
  TextEditingController locCtrl = TextEditingController();
  TextEditingController descCtrl=  TextEditingController();
  TextEditingController phoneCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();

  File? selectedImage;
  XFile? imgXFile;

  bool isAvailable = true;
  double latitude = 0.0;
  double longitude = 0.0;
  Rider? riderForUpdate;
 RiderProvider(this._dataProvider);

  // Pick Profile Image
  void pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImage = File(image.path);
      imgXFile = image;
      notifyListeners();
    }
  }

  // Register a new Rider
  Future<void> registerRider() async {
    if (!riderFormKey.currentState!.validate()) return;

    String id = DateTime.now().millisecondsSinceEpoch.toString();
    Rider newRider = Rider(
      id: id,
      name: nameCtrl.text,
      phone: phoneCtrl.text,
      email: emailCtrl.text,
      profileImage: '', // Handle image upload separately
      latitude: latitude,
      longitude: longitude,
      isAvailable: isAvailable, location: '',
    );

    clearFields();
    notifyListeners();
  }
  //
  // Assign Rider to an Order
  // Future<void> assignRiderToOrder(String orderId, String riderId) async {
  //   await firestore.collection('orders').doc(orderId).update({"riderId": riderId});
  //   notifyListeners();
  // }
  //
  // // Track Rider Location
  // Future<void> updateRiderLocation(String riderId, double lat, double lng) async {
  //   await firestore.collection('riders').doc(riderId).update({
  //     "latitude": lat,
  //     "longitude": lng,
  //   });
  //   notifyListeners();
  // }

  // Clear Fields
  void clearFields() {
    nameCtrl.clear();
    phoneCtrl.clear();
    emailCtrl.clear();
    selectedImage = null;
    imgXFile = null;
    riderForUpdate = null;
  }
}
