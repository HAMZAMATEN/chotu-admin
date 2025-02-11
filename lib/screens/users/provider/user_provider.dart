import 'package:flutter/material.dart';
import '../../../models/users.dart';
import '../../../services/http_services.dart';
import 'package:get/get.dart';

class UserProvider extends ChangeNotifier {
  HttpService service = HttpService();
  final GlobalKey<FormState> userFormKey = GlobalKey<FormState>();

  TextEditingController nameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController roleCtrl = TextEditingController();
  TextEditingController feedbackCtrl = TextEditingController();

  User? userForUpdate;
  bool isActive = true;
  List<User> users = [];

  //? Set User Data for Update
  void setUserForUpdate(User? user) {
    if (user != null) {
      clearFields();
      userForUpdate = user;

      nameCtrl.text = user.name ?? '';
      emailCtrl.text = user.email ?? '';
      roleCtrl.text = user.role ?? '';
      feedbackCtrl.text = user.feedback ?? '';
      isActive = user.isActive ?? true;
    } else {
      clearFields();
    }
  }

  //? Update User Details
  Future<void> updateUser() async {
    if (!userFormKey.currentState!.validate()) return;

    Map<String, dynamic> updatedData = {
      "name": nameCtrl.text,
      "email": emailCtrl.text,
      "role": roleCtrl.text,
      "isActive": isActive,
    };

  }
  //? Clear Form Fields
  void clearFields() {
    nameCtrl.clear();
    emailCtrl.clear();
    roleCtrl.clear();
    feedbackCtrl.clear();
    isActive = true;
    userForUpdate = null;
  }
}
