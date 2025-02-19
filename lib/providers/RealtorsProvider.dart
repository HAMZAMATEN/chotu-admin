import 'package:flutter/material.dart';

class RealtorProvider with ChangeNotifier {

  final List<Map<String, dynamic>> _users = [
    {
      "name": "Eleanor Pena",
      "info": "Joined at 25/4/2024 and is a very frequent user",
      "button": "See",
      "status": "Pending"
    },
    {
      "name": "Wade Warren",
      "info": "Joined at 15/12/2024 and is a non frequent user",
      "button": "See",
      "status": "Approved"
    },
    {
      "name": "Brooklyn Simmons",
      "info": "Joined at 25/4/2024 and is a very frequent user",
      "button": "See",
      "status": "Disapprove"
    },
    {
      "name": "Kathryn Murphy",
      "info": "Joined at 15/12/2024 and is a non frequent user",
      "button": "See",
      "status": "Block"
    },
  ];

  // Getter for accessing the user list
  List<Map<String, dynamic>> get users => _users;

  // Method to update the status of a user
  void updateStatus(int index, String status) {
    _users[index]['status'] = status;
    notifyListeners(); // Notify listeners to rebuild the UI
  }

  // List of statuses
  final List<String> statuses = ['Pending', 'Approved', 'Disapprove', 'Block'];



  // Get background color based on status
  Color getStatusColor(String status) {
    switch (status) {
      case 'Approved':
        return Colors.green.withOpacity(0.4);
      case 'Disapprove':
        return Colors.orange.withOpacity(0.4);
      case 'Block':
        return Colors.red.withOpacity(0.4);
      default:
        return Colors.blue.withOpacity(0.4); // Default for 'Pending'
    }
  }

  // Get text color based on status
  Color getTextColor(String status) {
    return status == 'Block' ? Colors.white : Colors.black;
  }

  Color getStatusIndicatorColor(String status) {
    switch (status) {
      case 'Approved':
        return Colors.green;
      case 'Disapprove':
        return Colors.orange;
      case 'Block':
        return Colors.red;
      default:
        return Colors.blue; // Default for 'Pending'
    }
  }
}
