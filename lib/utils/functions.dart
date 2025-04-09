import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:chotu_admin/utils/app_colors.dart';
import 'package:chotu_admin/utils/app_text_widgets.dart';
import 'package:image_picker_for_web/image_picker_for_web.dart' as pk;

class AppFunctions {
  static showSnackBar(BuildContext context, String message) {
    var snackBar = SnackBar(
      duration: const Duration(milliseconds: 800),
      content: Text(
        extractErrorMessage(message),
        style: getRegularStyle(color: AppColors.textColor),
      ),
      backgroundColor: Colors.white, // Black background color
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static String extractErrorMessage(String error) {
    if (error.contains(']')) {
      return error.split(']').last.trim();
    }
    return error;
  }

  static parseDate(String input) {
    DateTime parsedDate = DateTime.parse(input);

    // Format the date to the desired format
    String formattedDate = DateFormat('MMMM dd, yyyy').format(parsedDate);

    return formattedDate;
  }

  static showToastMessage({required String message}) {
    Fluttertoast.showToast(
        msg: "${message}",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 5,
        backgroundColor: AppColors.primaryColor,
        textColor: Colors.white,
        fontSize: 16.0,
        webBgColor: "linear-gradient(to right, #096237, #07ff86)",
        webPosition: "right");
  }

  Uint8List? image;
  String selectedFile = '';

  Future<Map<String, dynamic>?> pickImageOnWeb(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      String selectedFile = result.files.first.name;
      Uint8List? image = result.files.first.bytes;
      Map<String, dynamic> imageFileMap = {
        'fileName': selectedFile,
        'image': image
      };
      return imageFileMap;
    } else {
      return null;
    }
  }
}
