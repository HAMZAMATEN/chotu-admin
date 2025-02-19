import 'package:flutter/cupertino.dart';

class AddPropertiesProvider extends ChangeNotifier {
// Controllers
  final formKey = GlobalKey<FormState>();
  final eventFormKey = GlobalKey<FormState>();

// Event-specific controllers
  final eventNameController = TextEditingController();
  final eventDateController = TextEditingController();
  final eventTimeController = TextEditingController();
  final eventLocationController = TextEditingController();
  final eventDescriptionController = TextEditingController();

// Other existing controllers
  final nameController = TextEditingController();
  final locationController = TextEditingController();
  final overviewController = TextEditingController();
  final cityController = TextEditingController();
  final featuresController = TextEditingController();
  final handoverDateController = TextEditingController();

// Focus Nodes
// Event-specific focus nodes
  final eventNameFocusNode = FocusNode();
  final eventDateFocusNode = FocusNode();
  final eventTimeFocusNode = FocusNode();
  final eventLocationFocusNode = FocusNode();
  final eventDescriptionFocusNode = FocusNode();

// Other existing focus nodes
  final nameFocusNode = FocusNode();
  final locationFocusNode = FocusNode();
  final overviewFocusNode = FocusNode();
  final cityFocusNode = FocusNode();
  final featuresFocusNode = FocusNode();
  final handoverDateFocusNode = FocusNode();

  void handleSubmit(BuildContext context) {
    if (formKey.currentState?.validate() ?? false) {
      // Proceed with other form submission
      print("Other form is valid. Proceeding...");
    } else {
      // Focus on the first invalid or empty field for the other form
      if (nameController.text.isEmpty) {
        FocusScope.of(context).requestFocus(nameFocusNode);
      } else if (locationController.text.isEmpty) {
        FocusScope.of(context).requestFocus(locationFocusNode);
      } else if (overviewController.text.isEmpty) {
        FocusScope.of(context).requestFocus(overviewFocusNode);
      } else if (cityController.text.isEmpty) {
        FocusScope.of(context).requestFocus(cityFocusNode);
      } else if (featuresController.text.isEmpty) {
        FocusScope.of(context).requestFocus(featuresFocusNode);
      } else if (handoverDateController.text.isEmpty) {
        FocusScope.of(context).requestFocus(handoverDateFocusNode);
      }
    }
  }

  void handleEventSubmit(BuildContext context) {
    if (eventFormKey.currentState?.validate() ?? false) {
      // Proceed with event submission
      print("Event form is valid. Proceeding...");
    } else {
      // Focus on the first invalid or empty event-specific field
      if (eventNameController.text.isEmpty) {
        FocusScope.of(context).requestFocus(eventNameFocusNode);
      } else if (eventDateController.text.isEmpty) {
        FocusScope.of(context).requestFocus(eventDateFocusNode);
      } else if (eventTimeController.text.isEmpty) {
        FocusScope.of(context).requestFocus(eventTimeFocusNode);
      } else if (eventLocationController.text.isEmpty) {
        FocusScope.of(context).requestFocus(eventLocationFocusNode);
      } else if (eventDescriptionController.text.isEmpty) {
        FocusScope.of(context).requestFocus(eventDescriptionFocusNode);
      }
    }
  }

// Dispose controllers and focus nodes
  void disposeControllers() {
    // Event-specific disposals
    eventNameController.dispose();
    eventDateController.dispose();
    eventTimeController.dispose();
    eventLocationController.dispose();
    eventDescriptionController.dispose();

    eventNameFocusNode.dispose();
    eventDateFocusNode.dispose();
    eventTimeFocusNode.dispose();
    eventLocationFocusNode.dispose();
    eventDescriptionFocusNode.dispose();

    // Other existing disposals
    nameController.dispose();
    locationController.dispose();
    overviewController.dispose();
    cityController.dispose();
    featuresController.dispose();
    handoverDateController.dispose();

    nameFocusNode.dispose();
    locationFocusNode.dispose();
    overviewFocusNode.dispose();
    cityFocusNode.dispose();
    featuresFocusNode.dispose();
    handoverDateFocusNode.dispose();
  }
}
