import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class AllProductImageProvider extends ChangeNotifier {
  ImagePicker _imagePicker = ImagePicker();

  List<XFile> selectedImagesList = [];

  Future<void> pickMultipleImagesFromGallery() async {
    try {
      final List<XFile>? selectedImages = await _imagePicker.pickMultiImage();
      if (selectedImages != null && selectedImages.isNotEmpty) {
        // Handle the selected images
        selectedImagesList = selectedImages;
        for (var image in selectedImages) {
          print('Selected image path: ${image.path}');
        }
        notifyListeners();
      } else {
        print('No images selected.');
      }
    } catch (e) {
      print('Error picking images: $e');
    }
  }
}
