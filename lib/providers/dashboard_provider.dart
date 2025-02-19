import 'package:flutter/cupertino.dart';
import 'package:chotu_admin/utils/toast_dialogue.dart';

class DashboardProvider extends ChangeNotifier {
  final List<String> statuses = ['Today', 'Weekly', 'Monthly', 'Yearly'];

  String _selectedStatus = 'Today';

  String get selectedStatus => _selectedStatus;

  TextEditingController addPropertyTypeController = TextEditingController();
  TextEditingController addEventTypeController = TextEditingController();

  // Property Types
  List<String> _propertyTypes = [
    'TownHouse',
    'Villa',
    'Guest House',
    'Apartment',
    'Hotel',
    'Hotel Rooms',
    'House',
  ];

  List<String> get propertyTypes => _propertyTypes;

  Set<String> _selectedPropertyTypes = {};
  bool _showPropertyCheckboxes = false;

  bool get showPropertyCheckboxes => _showPropertyCheckboxes;
  Set<String> get selectedPropertyTypes => _selectedPropertyTypes;

  void togglePropertyCheckboxMode() {
    _showPropertyCheckboxes = !_showPropertyCheckboxes;
    _selectedPropertyTypes.clear();
    notifyListeners();
  }

  void togglePropertySelection(String property) {
    if (_selectedPropertyTypes.contains(property)) {
      _selectedPropertyTypes.remove(property);
    } else {
      _selectedPropertyTypes.add(property);
    }
    notifyListeners();
  }

  void deleteSelectedProperties(BuildContext context) {
    if (_selectedPropertyTypes.isEmpty) {
      ShowToastDialog.showToast('Please select at least one property to delete!');
      return;
    }
    _propertyTypes.removeWhere((type) => _selectedPropertyTypes.contains(type));
    _selectedPropertyTypes.clear();
    _showPropertyCheckboxes = false;
    notifyListeners();
  }

  void addProperty(String property, BuildContext context) {
    if (!_propertyTypes.contains(property)) {
      _propertyTypes.add(property);
      addPropertyTypeController.clear();
      Navigator.pop(context);
      notifyListeners();
    } else {
      ShowToastDialog.showToast('Property with the same type already exists!!');
    }
  }

  // Event Types
  List<String> _eventTypes = [
    'Conference',
    'Wedding',
    'Birthday Party',
    'Workshop',
    'Seminar',
    'Exhibition',
    'Corporate Event',
  ];

  List<String> get eventTypes => _eventTypes;

  Set<String> _selectedEventTypes = {};
  bool _showEventCheckboxes = false;

  bool get showEventCheckboxes => _showEventCheckboxes;
  Set<String> get selectedEventTypes => _selectedEventTypes;

  void toggleEventCheckboxMode() {
    _showEventCheckboxes = !_showEventCheckboxes;
    _selectedEventTypes.clear();
    notifyListeners();
  }

  void toggleEventSelection(String event) {
    if (_selectedEventTypes.contains(event)) {
      _selectedEventTypes.remove(event);
    } else {
      _selectedEventTypes.add(event);
    }
    notifyListeners();
  }

  void deleteSelectedEvents(BuildContext context) {
    if (_selectedEventTypes.isEmpty) {
      ShowToastDialog.showToast('Please select at least one event to delete!');
      return;
    }
    _eventTypes.removeWhere((type) => _selectedEventTypes.contains(type));
    _selectedEventTypes.clear();
    _showEventCheckboxes = false;
    notifyListeners();
  }

  void addEvent(String event, BuildContext context) {
    if (!_eventTypes.contains(event)) {
      _eventTypes.add(event);
      addEventTypeController.clear();
      Navigator.pop(context);
      notifyListeners();
    } else {
      ShowToastDialog.showToast('Event with the same type already exists!!');
    }
  }

  // Status Selection
  setSelectedStatus(String val) {
    _selectedStatus = val;
    notifyListeners();
  }
}
