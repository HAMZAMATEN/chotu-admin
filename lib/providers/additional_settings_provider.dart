import 'dart:convert';

import 'package:chotu_admin/utils/api_consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../utils/functions.dart';
import '../utils/toast_dialogue.dart';
import 'api_services_provider.dart';

class AdditionalSettingsProvider extends ChangeNotifier {
  ApiServicesProvider apiServicesProvider =
      navigatorKey.currentContext!.read<ApiServicesProvider>();
  GlobalKey<FormState> faqKey = GlobalKey();
  GlobalKey<FormState> contactUsKey = GlobalKey();
  GlobalKey<FormState> aboutUsKey = GlobalKey();

  Future<void> addAboutUs(
    String title,
    String content,
    BuildContext context,
  ) async {
    ShowToastDialog.showLoader('Adding About Us');
    try {
      await apiServicesProvider
          .putRequestResponse(APIConstants.updateAboutUs, body: {
        "title": title,
        "content": content,
      }).then((response) {
        print("STATUS:::${response.statusCode}");
        if (response.statusCode == 200) {
          AppFunctions.showToastMessage(message: "About Us added successfully");
          Navigator.pop(context);
        } else {
          AppFunctions.showToastMessage(message: "Failed to add about us");
          var data = jsonDecode(response.body);
          print(
              "EXCEPTION WHILE ADDING ABOUT US AND ST:::${response.statusCode} BODY:::$data");
        }

        ShowToastDialog.closeLoader();
      });
    } catch (e) {
      print("EXCEPTION WHILE ADDING ABOUT US:::$e");

      AppFunctions.showToastMessage(
          message: "Exception while adding about us : $e");
      ShowToastDialog.closeLoader();
    }
  }

  Future<void> addTermsAndConditions(
    String title,
    String content,
    BuildContext context,
  ) async {
    ShowToastDialog.showLoader('Adding Terms and Conditions');
    try {
      await apiServicesProvider
          .putRequestResponse(APIConstants.updateAboutUs, body: {
        "title": title,
        "content": content,
      }).then((response) {
        print("STATUS:::${response.statusCode}");
        if (response.statusCode == 200) {
          AppFunctions.showToastMessage(
              message: "Terms and Conditions added successfully");
          Navigator.pop(context);
        } else {
          AppFunctions.showToastMessage(
              message: "Failed to add Terms and Conditions");
          var data = jsonDecode(response.body);
          print(
              "EXCEPTION WHILE ADDING Terms and Conditions AND ST:::${response.statusCode} BODY:::$data");
        }

        ShowToastDialog.closeLoader();
      });
    } catch (e) {
      print("EXCEPTION WHILE ADDING Terms and Conditions:::$e");

      AppFunctions.showToastMessage(
          message: "Exception while adding Terms and Conditions : $e");
      ShowToastDialog.closeLoader();
    }
  }

  Future<void> addPrivacyPolicy(
    String title,
    String content,
    BuildContext context,
  ) async {
    ShowToastDialog.showLoader('Adding About Us');
    try {
      await apiServicesProvider
          .putRequestResponse(APIConstants.updatePrivacyPolicy, body: {
        "title": title,
        "content": content,
      }).then((response) {
        print("STATUS:::${response.statusCode}");
        if (response.statusCode == 200) {
          AppFunctions.showToastMessage(
              message: "Privacy policy added successfully");
          Navigator.pop(context);
        } else {
          AppFunctions.showToastMessage(
              message: "Failed to add Privacy policy");
          var data = jsonDecode(response.body);
          print(
              "EXCEPTION WHILE ADDING Privacy policy AND ST:::${response.statusCode} BODY:::$data");
        }

        ShowToastDialog.closeLoader();
      });
    } catch (e) {
      print("EXCEPTION WHILE ADDING Privacy policy:::$e");

      AppFunctions.showToastMessage(
          message: "Exception while adding Privacy policy : $e");
      ShowToastDialog.closeLoader();
    }
  }

  Future<void> getAllAboutUs() async {
    try {
      await apiServicesProvider
          .getRequestResponse(APIConstants.getAboutUs)
          .then((response) {
        if (response.statusCode == 200) {}
      });
    } catch (e) {
      print("EXCEPTION WHILE getting ABOUT US:::$e");

      AppFunctions.showToastMessage(
          message: "Exception while getting about us : $e");
    }
  }

  List<FaqItem> _faqItems = [
    FaqItem(
      question: "What is the purpose of this app?",
      answer:
          "This app allows users to browse, buy, and sell products seamlessly. It offers a wide range of categories, secure payment options, and user-friendly navigation for a smooth shopping experience.",
    ),
    FaqItem(
      question: "Who can use this app?",
      answer:
          "The app is designed for shoppers looking for great deals, sellers who want to list their products, and businesses aiming to reach a broader audience.",
    ),
    FaqItem(
      question: "How can I search for products?",
      answer:
          "You can use the search bar to filter products by category, price range, brand, and availability. Advanced filters help you find exactly what you need.",
    ),
    FaqItem(
      question: "How do I list an item for sale?",
      answer:
          "You can list your products by going to the 'Sell' section in the app. Simply upload product images, add a description, set a price, and publish your listing.",
    ),
    FaqItem(
      question: "What payment methods are available?",
      answer:
          "The app supports multiple payment options, including credit/debit cards, PayPal, and digital wallets, ensuring secure and convenient transactions.",
    ),
    FaqItem(
      question: "Is my personal and payment information secure?",
      answer:
          "Yes, the app follows strict security protocols, including data encryption and fraud protection, to keep your information safe.",
    ),
    FaqItem(
      question: "What should I do if the app crashes or freezes?",
      answer:
          "Try closing and reopening the app. If the problem persists, please contact our support team through the 'Help & Support' section.",
    ),
  ];

  List<FaqItem> get faqItems => _faqItems;

  TextEditingController questionController = TextEditingController();
  TextEditingController answerController = TextEditingController();

  TextEditingController contactUsTitleController = TextEditingController();
  TextEditingController contactUsDescriptionController =
      TextEditingController();
  TextEditingController aboutUsTitleController = TextEditingController();
  TextEditingController aboutUsDescriptionController = TextEditingController();

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

  addAboutUsItem() {
    _aboutUsContent.add({
      "title": aboutUsTitleController.text,
      "description": aboutUsDescriptionController.text,
    });
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
}

class FaqItem {
  String question;
  String answer;
  bool isExpanded;

  FaqItem({
    required this.question,
    required this.answer,
    this.isExpanded = false,
  });
}
