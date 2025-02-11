// import 'package:flutter/material.dart';
// import '../../models/users.dart'; // Ensure the correct model path
//
// class UserManagementScreen extends StatelessWidget {
//   final List<User> users = [
//     User(
//       id: '1',
//       name: 'Sewiii Mirza',
//       email: 'sewiiimirza@gmail.com',
//       role: 'Seller',
//       isActive: true,
//       lastActive: '2024-02-05',
//       feedback: 'Great service!',
//     ),
//     User(
//       id: '2',
//       name: 'John Doe',
//       email: 'johndoe@gmail.com',
//       role: 'chotu_admin',
//       isActive: false,
//       lastActive: '2024-02-04',
//       feedback: 'Needs improvement',
//     ),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("User Management")),
//       body: Padding(
//         padding: EdgeInsets.all(16),
//         child: SingleChildScrollView(
//           scrollDirection: Axis.horizontal, // Enable horizontal scrolling
//           child: DataTable(
//             columns: [
//               DataColumn(label: Text("Name", style: TextStyle(fontWeight: FontWeight.bold))),
//               DataColumn(label: Text("Email", style: TextStyle(fontWeight: FontWeight.bold))),
//               DataColumn(label: Text("Role", style: TextStyle(fontWeight: FontWeight.bold))),
//               DataColumn(label: Text("Status", style: TextStyle(fontWeight: FontWeight.bold))),
//               DataColumn(label: Text("Last Active", style: TextStyle(fontWeight: FontWeight.bold))),
//               DataColumn(label: Text("Actions", style: TextStyle(fontWeight: FontWeight.bold))),
//             ],
//             rows: users.map((user) {
//               return DataRow(cells: [
//                 DataCell(Text(user.name)),
//                 DataCell(Text(user.email)),
//                 DataCell(Text(user.role)),
//                 DataCell(
//                   Container(
//                     alignment: Alignment.center,
//                     child: Switch(
//                       value: user.isActive,
//                       onChanged: (val) {
//                         // TODO: Handle status change
//                       },
//                     ),
//                   ),
//                 ),
//                 DataCell(Text(user.lastActive)),
//                 DataCell(Row(
//                   children: [
//                     IconButton(
//                       icon: Icon(Icons.edit, color: Colors.blue),
//                       onPressed: () {
//                         showDialog(
//                           context: context,
//                           builder: (context) => UserEditDialog(user: user),
//                         );
//                       },
//                     ),
//                     IconButton(
//                       icon: Icon(Icons.feedback, color: Colors.orange),
//                       onPressed: () {
//                         showDialog(
//                           context: context,
//                           builder: (context) => AlertDialog(
//                             title: Text("User Feedback"),
//                             content: Text(user.feedback.isEmpty ? "No feedback available" : user.feedback),
//                             actions: [
//                               TextButton(onPressed: () => Navigator.pop(context), child: Text("Close")),
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//                   ],
//                 )),
//               ]);
//             }).toList(),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class UserEditDialog extends StatelessWidget {
//   final User user;
//
//   UserEditDialog({required this.user});
//
//   @override
//   Widget build(BuildContext context) {
//     TextEditingController nameController = TextEditingController(text: user.name);
//     TextEditingController emailController = TextEditingController(text: user.email);
//
//     return AlertDialog(
//       title: Text("Edit User"),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           TextField(controller: nameController, decoration: InputDecoration(labelText: "Name")),
//           TextField(controller: emailController, decoration: InputDecoration(labelText: "Email")),
//         ],
//       ),
//       actions: [
//         TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancel")),
//         ElevatedButton(
//           onPressed: () {
//             // TODO: Save updated user info to backend
//             Navigator.pop(context);
//           },
//           child: Text("Save"),
//         ),
//       ],
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import '../../models/users.dart'; // Ensure correct model path
//
// class UserManagementScreen extends StatelessWidget {
//   final List<User> users = [
//     User(
//       id: '1',
//       name: 'Sewiii Mirza',
//       email: 'sewiiimirza@gmail.com',
//       role: 'User',
//       isActive: true,
//       lastActive: '2024-02-05',
//       feedback: 'Great service!',
//     ),
//     User(
//       id: '2',
//       name: 'John Doe',
//       email: 'johndoe@gmail.com',
//       role: 'User',
//       isActive: false,
//       lastActive: '2024-02-04',
//       feedback: 'Needs improvement',
//     ),
//   ];
//
//   final List<User> riders = [
//     User(
//       id: '3',
//       name: 'Alex Rider',
//       email: 'alexrider@gmail.com',
//       role: 'Rider',
//       isActive: true,
//       lastActive: '2024-02-03',
//       feedback: 'Fast delivery!',
//     ),
//     User(
//       id: '4',
//       name: 'Sam Delivery',
//       email: 'samdelivery@gmail.com',
//       role: 'Rider',
//       isActive: false,
//       lastActive: '2024-02-02',
//       feedback: 'Late on some orders',
//     ),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2, // Two tabs (Users & Riders)
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text("User Management"),
//           bottom: TabBar(
//             tabs: [
//               Tab(text: "Users"),
//               Tab(text: "Riders"),
//             ],
//           ),
//         ),
//         body: TabBarView(
//           children: [
//             _buildUserTable(users),  // Users Tab
//             _buildUserTable(riders), // Riders Tab
//           ],
//         ),
//       ),
//     );
//   }
//
//   /// Builds the DataTable for Users or Riders
//   Widget _buildUserTable(List<User> userList) {
//     return Padding(
//       padding: EdgeInsets.all(16),
//       child: SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//         child: DataTable(
//           columns: [
//             DataColumn(label: Text("Name", style: TextStyle(fontWeight: FontWeight.bold))),
//             DataColumn(label: Text("Email", style: TextStyle(fontWeight: FontWeight.bold))),
//             DataColumn(label: Text("Role", style: TextStyle(fontWeight: FontWeight.bold))),
//             DataColumn(label: Text("Status", style: TextStyle(fontWeight: FontWeight.bold))),
//             DataColumn(label: Text("Last Active", style: TextStyle(fontWeight: FontWeight.bold))),
//             DataColumn(label: Text("Actions", style: TextStyle(fontWeight: FontWeight.bold))),
//           ],
//           rows: userList.map((user) {
//             return DataRow(cells: [
//               DataCell(Text(user.name)),
//               DataCell(Text(user.email)),
//               DataCell(Text(user.role)),
//               DataCell(
//                 Switch(
//                   value: user.isActive,
//                   onChanged: (val) {
//                     // TODO: Handle status change
//                   },
//                 ),
//               ),
//               DataCell(Text(user.lastActive)),
//               DataCell(Row(
//                 children: [
//                   IconButton(
//                     icon: Icon(Icons.edit, color: Colors.blue),
//                     onPressed: () {
//                       showDialog(
//                         context: context,
//                         // userList.first.name as BuildContext,
//                         builder: (context) => UserEditDialog(user: user),
//                       );
//                     },
//                   ),
//                   IconButton(
//                     icon: Icon(Icons.feedback, color: Colors.orange),
//                     onPressed: () {
//                       showDialog(
//                         context: userList.first.name as BuildContext,
//                         builder: (context) => AlertDialog(
//                           title: Text("User Feedback"),
//                           content: Text(user.feedback.isEmpty ? "No feedback available" : user.feedback),
//                           actions: [
//                             TextButton(onPressed: () => Navigator.pop(context), child: Text("Close")),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                 ],
//               )),
//             ]);
//           }).toList(),
//         ),
//       ),
//     );
//   }
// }
//
// /// User Edit Dialog
// class UserEditDialog extends StatelessWidget {
//   final User user;
//
//   UserEditDialog({required this.user});
//
//   @override
//   Widget build(BuildContext context) {
//     TextEditingController nameController = TextEditingController(text: user.name);
//     TextEditingController emailController = TextEditingController(text: user.email);
//
//     return AlertDialog(
//       title: Text("Edit User"),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           TextField(controller: nameController, decoration: InputDecoration(labelText: "Name")),
//           TextField(controller: emailController, decoration: InputDecoration(labelText: "Email")),
//         ],
//       ),
//       actions: [
//         TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancel")),
//         ElevatedButton(
//           onPressed: () {
//             // TODO: Save updated user info to backend
//             Navigator.pop(context);
//           },
//           child: Text("Save"),
//         ),
//       ],
//     );
//   }
// }
//
import 'package:chotu_admin/utility/constants.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../models/users.dart';
import '../riders/components/add_rider_form.dart';
import 'components/edit_pop.dart';
import 'components/user_header.dart'; // Ensure correct model path

class UserManagementScreen extends StatelessWidget {
  final List<User> users = [
    User(
      id: '1',
      name: 'Sewiii Mirza',
      email: 'sewiiimirza@gmail.com',
      role: 'User',
      isActive: true,
      lastActive: '2024-02-05',
      feedback: 'Great service!',
    ),
    User(
      id: '2',
      name: 'John Doe',
      email: 'johndoe@gmail.com',
      role: 'User',
      isActive: false,
      lastActive: '2024-02-04',
      feedback: 'Needs improvement',
    ),
  ];

  final List<User> riders = [
    User(
      id: '3',
      name: 'Alex Rider',
      email: 'alexrider@gmail.com',
      role: 'Rider',
      isActive: true,
      lastActive: '2024-02-03',
      feedback: 'Fast delivery!',
    ),
    User(
      id: '4',
      name: 'Sam Delivery',
      email: 'samdelivery@gmail.com',
      role: 'Rider',
      isActive: false,
      lastActive: '2024-02-02',
      feedback: 'Late on some orders',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
       child:Scaffold(
         appBar: AppBar(
           title: Text("User Management"),
           bottom: TabBar(
             indicatorColor: secondaryColor,
             labelColor: primaryColor,
             tabs: [
               Tab(text: "Users",),
               Tab(text: "Riders"),
             ],
           ),
         ),
         body: TabBarView(
           children: [
             _buildUserTable(context, users),  // Users Tab
             _buildUserTable(context, riders), // Riders Tab
           ],
         ),
       ),
    );


  }


  Widget _buildUserTable(BuildContext context, List<User> userList) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(label: Text("Name", style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text("Email", style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text("Role", style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text("Status", style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text("Last Active", style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text("Actions", style: TextStyle(fontWeight: FontWeight.bold))),
          ],
          rows: userList.map((user) {
            return DataRow(cells: [
              DataCell(Text(user.name)),
              DataCell(Text(user.email)),
              DataCell(Text(user.role)),
              DataCell(
                Switch(
                  value: user.isActive,
                  onChanged: (val) {
                    // TODO: Handle status change
                  },
                ),
              ),
              DataCell(Text(user.lastActive)),
              DataCell(Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.blue),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => UserEditDialog(user: user),
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.feedback, color: Colors.orange),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("User Feedback",style:TextStyle(color: secondaryColor)),
                          content: Text(user.feedback.isEmpty ? "No feedback available" : user.feedback),
                          actions: [
                        ElevatedButton(
                        style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                          backgroundColor: secondaryColor,),
                       onPressed: () => Navigator.pop(context), child: Text("Close")),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              )),
            ]);
          }).toList(),
        ),
      ),
    );
  }
}


