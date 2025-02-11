
import 'package:flutter/material.dart';

import '../../../models/users.dart';
import '../../../utility/constants.dart';

class UserEditDialog extends StatelessWidget {
  final User user;

  UserEditDialog({required this.user});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController(text: user.name);
    TextEditingController emailController = TextEditingController(text: user.email);

    return AlertDialog(
      title: Text("Edit User",style: TextStyle(color: secondaryColor),),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(controller: nameController, decoration: InputDecoration(labelText: "Name")),
          TextField(controller: emailController, decoration: InputDecoration(labelText: "Email")),
        ],
      ),
      actions: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: secondaryColor,
            ),onPressed: () => Navigator.pop(context), child: Text("Cancel")),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: primaryColor,
            ),
            onPressed: () {
              // TODO: Save updated user info to backend
              Navigator.pop(context);
            },
            child: Text("Save")),
      ],
    );
  }
}