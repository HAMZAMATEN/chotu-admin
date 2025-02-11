import 'dart:io';
import '../../../models/shop.dart';
import '../../../services/http_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' hide Shop;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/data/data_provider.dart';

class ShopProvider extends ChangeNotifier {
  HttpService service = HttpService();
  final DataProvider _dataProvider;
  final addShopFormKey = GlobalKey<FormState>();

  TextEditingController shopNameCtrl = TextEditingController();
  TextEditingController shopAddressCtrl = TextEditingController();
  TextEditingController shopDesCtrl=TextEditingController();

  Shop? shopForUpdate;

  File? selectedImage;
  XFile? imgXFile;

  double? latitude;
  double? longitude;
  bool isActive = true;

  ShopProvider(this._dataProvider);

  //? Pick Image for Shop
  void pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImage = File(image.path);
      imgXFile = image;
      notifyListeners();
    }
  }

  //? Set Shop Location (From Google Maps)
  void setLocation(double lat, double lng, String address) {
    latitude = lat;
    longitude = lng;
    shopAddressCtrl.text = address;
    notifyListeners();
  }

  //? Create FormData for API Submission
  Future<FormData> createFormData({required XFile? imgXFile, required Map<String, dynamic> formData}) async {
    if (imgXFile != null) {
      MultipartFile multipartFile;
      if (kIsWeb) {
        String fileName = imgXFile.name;
        Uint8List byteImg = await imgXFile.readAsBytes();
        multipartFile = MultipartFile(byteImg, filename: fileName);
      } else {
        String fileName = imgXFile.path.split('/').last;
        multipartFile = MultipartFile(imgXFile.path, filename: fileName);
      }
      formData['img'] = multipartFile;
    }
    final FormData form = FormData(formData);
    return form;
  }

  //? Set Data for Update
  setDataForUpdateShop(Shop? shop) {
    if (shop != null) {
      clearFields();
      shopForUpdate = shop;

      shopNameCtrl.text = shop.name ?? '';
      shopAddressCtrl.text = shop.address ?? '';
      latitude = shop.latitude;
      longitude = shop.longitude;
      isActive = shop.isActive ?? true;
    } else {
      clearFields();
    }
  }

  //? Clear Form Fields
  clearFields() {
    shopNameCtrl.clear();
    shopAddressCtrl.clear();
    selectedImage = null;
    imgXFile = null;
    latitude = null;
    longitude = null;
    isActive = true;
    shopForUpdate = null;
  }
}
