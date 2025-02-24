import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../utils/toast_dialogue.dart';

class AdditionalSettingsProvider extends ChangeNotifier {
  GlobalKey<FormState> faqKey = GlobalKey();
  GlobalKey<FormState> contactUsKey = GlobalKey();
  GlobalKey<FormState> aboutUsKey = GlobalKey();

  List<FaqItem> _faqItems = [
    FaqItem(
      question: "What is the purpose of this app?",
      answer:
          "This app allows users to rent, sell, and buy properties effortlessly. It provides detailed property shops, user statistics, and supports both short-term and long-term rental options.",
    ),
    FaqItem(
      question: "Who can use this app?",
      answer:
          "The app is designed for Buyers/Renters, Realtors managing property listings, and Property owners who want to sell or rent their properties.",
    ),
    FaqItem(
      question: "How can I search for properties to rent or buy?",
      answer:
          "You can use the search feature to filter properties based on location, property type, price range, and availability (short-term or long-term).",
    ),
    FaqItem(
      question: "How do I list my property for sale or rent?",
      answer:
          "You can list your property by navigating to the 'Add Property' section in the app. Fill in the property details, upload images, and set the price.",
    ),
    FaqItem(
      question: "How can I make payments for property transactions?",
      answer:
          "You can make payments through integrated payment gateways like Stripe or other available options in the app.",
    ),
    FaqItem(
      question: "Is my personal information secure?",
      answer:
          "Yes, the app follows strict privacy policies and uses advanced encryption to protect your data.",
    ),
    FaqItem(
      question: "What should I do if the app crashes or freezes?",
      answer:
          "Try restarting the app. If the issue persists, contact our support team through the 'Help & Support' section.",
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

  final List<Map<String, String>> _aboutUsContent =

  [
    {
      "title": "About SAQFI",
      "description":
          "Welcome to SAQFI, your number one source for all things property-related. We're dedicated to providing you the very best of property listings, with an emphasis on reliability, user-friendliness, and comprehensive shops.",
    },
    {
      "title": "Our Mission",
      "description":
          "To revolutionize the property market by providing an intuitive platform that connects buyers, renters, and riders seamlessly, ensuring transparency and efficiency in every transaction.",
    },
    {
      "title": "Our Vision",
      "description":
          "To be the leading property platform globally, recognized for innovation, trustworthiness, and exceptional user experience.",
    },
    // Add more sections if needed
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
      ShowToastDialog.showToast('Please select at least one about us section to delete!');
      return;
    }
    _aboutUsContent.removeWhere((type) => _selectedAboutUsContent.contains(jsonEncode(type)));
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
      ShowToastDialog.showToast('Please select at least one contact us section to delete!');
      return;
    }
    _contactUsContent.removeWhere((type) => _selectedContactUsContent.contains(jsonEncode(type)));
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
