import 'dart:convert';

import 'package:chotu_admin/main.dart';
import 'package:chotu_admin/model/faq_item_model.dart';
import 'package:chotu_admin/providers/api_services_provider.dart';
import 'package:chotu_admin/utils/api_consts.dart';
import 'package:chotu_admin/utils/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../utils/toast_dialogue.dart';

class AdditionalSettingsProvider extends ChangeNotifier {
  ApiServicesProvider apiServicesProvider =
      navigatorKey.currentContext!.read<ApiServicesProvider>();

  GlobalKey<FormState> faqKey = GlobalKey();
  GlobalKey<FormState> contactUsKey = GlobalKey();
  GlobalKey<FormState> aboutUsKey = GlobalKey();

  List<FaqItemModel>? faqItems;



  TextEditingController contactUsTitleController = TextEditingController();
  TextEditingController contactUsDescriptionController = TextEditingController();


  final List<Map<String, String>> _aboutUsContent = [
    {
      "title": "About Chotu App",
      "description":
          "Welcome to Chotu App, your go-to platform for seamless live order management. We are committed to delivering a fast, reliable, and user-friendly experience, making online ordering effortless for businesses and customers alike.",
    },
    {
      "title": "Our Mission",
      "description":
          "To transform the commerce industry by providing a real-time ordering platform that connects businesses and customers efficiently, ensuring smooth transactions and instant order processing.",
    },
    {
      "title": "Our Vision",
      "description":
          "To become the leading live order platform, recognized for innovation, trust, and an unmatched ordering experience.",
    },
  ];

  List<Map<String, String>> get aboutUsContent => _aboutUsContent;

  final List<Map<String, String>> _contactUsContent = [
    {
      "title": "Email",
      "description": "support@yourapp.com", // Add your app's support email
    },
    {
      "title": "Phone",
      "description": "+1 234 567 890", // Add your app's phone number
    },
    {
      "title": "Address",
      "description": "123 Main Street, City, Country",
      // Add your office address
    },
    {
      "title": "Working Hours",
      "description": "Monday to Friday, 9:00 AM - 5:00 PM", // Optional field
    },
  ];

  List<Map<String, String>> get contactUsContent => _contactUsContent;

  Set<String> _selectedAboutUsContent = {};
  bool _showAboutUsCheckboxes = false;

  bool get showAboutUsCheckboxes => _showAboutUsCheckboxes;

  Set<String> get selectedAboutUsContent => _selectedAboutUsContent;

  Set<String> _selectedContactUsContent = {};
  bool _showContactUsCheckboxes = false;

  bool get showContactUsCheckboxes => _showContactUsCheckboxes;

  Set<String> get selectedContactUsContent => _selectedContactUsContent;

  void toggleAboutUsCheckboxMode() {
    _showAboutUsCheckboxes = !_showAboutUsCheckboxes;
    _selectedAboutUsContent.clear();
    notifyListeners();
  }

  void toggleAboutUsSelection(Map<String, String> contact) {
    if (_selectedAboutUsContent.contains(jsonEncode(contact))) {
      _selectedAboutUsContent.remove(jsonEncode(contact));
    } else {
      print('else');
      _selectedAboutUsContent.add(jsonEncode(contact));
    }

    print('contact:::$_selectedAboutUsContent');
    notifyListeners();
  }

  void deleteSelectedAboutUs(BuildContext context) {
    if (_selectedAboutUsContent.isEmpty) {
      ShowToastDialog.showToast(
          'Please select at least one about us section to delete!');
      return;
    }
    _aboutUsContent.removeWhere(
        (type) => _selectedAboutUsContent.contains(jsonEncode(type)));
    _selectedAboutUsContent.clear();
    _showAboutUsCheckboxes = false;
    notifyListeners();
  }


  void toggleContactUsCheckboxMode() {
    _showContactUsCheckboxes = !_showContactUsCheckboxes;
    _selectedContactUsContent.clear();
    notifyListeners();
  }

  void toggleContactUsSelection(Map<String, String> contact) {
    if (_selectedContactUsContent.contains(jsonEncode(contact))) {
      _selectedAboutUsContent.remove(jsonEncode(contact));
    } else {
      print('else');
      _selectedContactUsContent.add(jsonEncode(contact));
    }

    notifyListeners();
  }

  void deleteSelectedContactUsSection(BuildContext context) {
    if (_selectedContactUsContent.isEmpty) {
      ShowToastDialog.showToast(
          'Please select at least one contact us section to delete!');
      return;
    }
    _contactUsContent.removeWhere(
        (type) => _selectedContactUsContent.contains(jsonEncode(type)));
    _selectedContactUsContent.clear();
    _showContactUsCheckboxes = false;
    notifyListeners();
  }

  addContactUsItem() {
    _contactUsContent.add({
      "title": contactUsTitleController.text,
      "description": contactUsDescriptionController.text,
    });
    notifyListeners();
  }

  /// about us variables
  String? aboutUs;

  String? aboutUsLastUpdate;

  /// about us variables
  String? termsAndCondition;
  String? termsAndConditionLastUpdate;

  /// about us variables
  String? privacyPolicy;
  String? privacyPolicyLastUpdate;

  Future<void> getAboutUs() async {
    try {
      http.Response response =
          await apiServicesProvider.getRequestResponse(APIConstants.getAboutUs);

      print("Response of getAboutUs is ${response.body}");
      print("Response Status of getAboutUs is ${response.statusCode}");

      if (response.statusCode == 200) {
        aboutUs = (jsonDecode(response.body))['content'];
        aboutUsLastUpdate = AppFunctions.extractDate(
            ((jsonDecode(response.body))['updated_at']));
      } else {
        aboutUs = "";
        aboutUsLastUpdate = "";
      }
      notifyListeners();
    } catch (e) {
      print("Exception while getting about us content: $e");
      AppFunctions.showToastMessage(message: 'Error fetching About Us content');
    }
  }

  Future<void> getTermsAndConditions() async {
    try {
      http.Response response = await apiServicesProvider
          .getRequestResponse(APIConstants.getTermsAndConditions);

      print("Response of getTermsAndConditions is ${response.body}");
      print(
          "Response Status of getTermsAndConditions is ${response.statusCode}");

      if (response.statusCode == 200) {
        termsAndCondition = (jsonDecode(response.body))['content'];
        termsAndConditionLastUpdate = AppFunctions.extractDate(
            ((jsonDecode(response.body))['updated_at']));
      } else {
        termsAndCondition = "";
        termsAndConditionLastUpdate = "";
      }
      notifyListeners();
    } catch (e) {
      print("Exception while getting terms and conditions content: $e");
      AppFunctions.showToastMessage(
          message: 'Error fetching Terms and Conditions content');
    }
  }

  Future<void> getPrivacyPolicy() async {
    try {
      http.Response response = await apiServicesProvider
          .getRequestResponse(APIConstants.getPrivacyPolicy);

      print("Response of getPrivacyPolicy is ${response.body}");
      print("Response Status of getPrivacyPolicy is ${response.statusCode}");

      if (response.statusCode == 200) {
        privacyPolicy = (jsonDecode(response.body))['content'];
        privacyPolicyLastUpdate = AppFunctions.extractDate(
            ((jsonDecode(response.body))['updated_at']));
      } else {
        privacyPolicy = "";
        privacyPolicyLastUpdate = "";
      }
      notifyListeners();
    } catch (e) {
      print("Exception while getting privacy policy content: $e");
      AppFunctions.showToastMessage(
          message: 'Error fetching Privacy Policy content');
    }
  }

  Future<void> updateAdditionalSettingContent({
    bool isAboutUs = false,
    bool isTermAndCondition = false,
    bool isPrivacyPolicy = false,
    required String content,
  }) async {
    try {
      EasyLoading.show(status: 'Updating...');
      String settingEndPoint = "";
      String title = "";
      if (isAboutUs) {
        settingEndPoint = "about-us";
        title = "About Us";
      }
      if (isTermAndCondition) {
        settingEndPoint = "terms-and-conditions";
        title = "Terms & Condition";
      }
      if (isPrivacyPolicy) {
        settingEndPoint = "privacy-policy";
        title = "Privacy Policy";
      }

      print(
          "URL IS ${APIConstants.updateAdditionalSettings + "${settingEndPoint}"}");
      http.Response response = await apiServicesProvider.putRequestResponse(
        APIConstants.updateAdditionalSettings + "${settingEndPoint}",
        body: {
          "title": "${title}",
          "content": "${content}",
        },
      );

      print(
          "Response Status of updateAdditionalSettingContent is ${response.statusCode}");
      print("Response of updateAdditionalSettingContent is ${response.body}");

      if (response.statusCode == 200) {
        if (isAboutUs) {
          await getAboutUs();
        }
        if (isTermAndCondition) {
          await getTermsAndConditions();
        }
        if (isPrivacyPolicy) {
          await getPrivacyPolicy();
        }
      }
      AppFunctions.showToastMessage(message: 'Content Updated Successfully');
      notifyListeners();
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
      print(
          "Exception while getting updateAdditionalSettingContent content: $e");
      AppFunctions.showToastMessage(
          message: 'Error updating updateAdditionalSettingContent');
    }
  }

  Future<void> getAllFaqs() async {
    try {
      http.Response response =
          await apiServicesProvider.getRequestResponse(APIConstants.getAllFaqs);

      print("Response of getAllFaqs is ${response.body}");
      print("Response Status of getAllFaqs is ${response.statusCode}");

      if (response.statusCode == 200) {
        List<dynamic> faqList = jsonDecode(response.body);
        faqItems = faqList.map((item) => FaqItemModel.fromJson(item)).toList();
        faqItems!.sort((a, b) => a.id.compareTo(b.id));
        print("faqItems: $faqItems");
      } else {
        faqItems = [];
      }
      notifyListeners();
    } catch (e) {
      faqItems = [];
      print("Exception while getAllFaqs content: $e");
      AppFunctions.showToastMessage(
          message: 'Error fetching getAllFaqs content');
    }
  }

  Future<void> addFaq({required Map<String, dynamic> body}) async {
    try {
      http.Response response = await apiServicesProvider
          .postRequestResponse(APIConstants.addFaq, body: body);

      print("Response of addFaq is ${response.body}");
      print("Response Status of addFaq is ${response.statusCode}");

      if (response.statusCode == 201) {
        getAllFaqs();
        AppFunctions.showToastMessage(message: 'FAQ Added Successfully');
      }
      notifyListeners();
    } catch (e) {
      print("Exception while addFaq content: $e");
      AppFunctions.showToastMessage(message: 'Error fetching addFaq content');
    }
  }

  Future<void> deleteFaq({required int faqId}) async {
    try {
      http.Response response = await apiServicesProvider
          .deleteRequestResponse(APIConstants.deleteFaq+'${faqId}');

      print("Response of addFaq is ${response.body}");
      print("Response Status of addFaq is ${response.statusCode}");

      if (response.statusCode == 200) {
        getAllFaqs();
        AppFunctions.showToastMessage(message: 'FAQ Deleted Successfully');
      }
      notifyListeners();
    } catch (e) {
      print("Exception while deleteFaq content: $e");
      AppFunctions.showToastMessage(message: 'Error fetching deleteFaq content');
    }
  }
}
