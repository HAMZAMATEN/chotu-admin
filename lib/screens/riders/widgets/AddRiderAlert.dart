import 'package:chotu_admin/utils/app_Colors.dart';
import 'package:chotu_admin/utils/app_Paddings.dart';
import 'package:chotu_admin/utils/app_text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../generated/assets.dart';
import '../../../widgets/custom_TextField.dart';

class AddRiderDialog extends StatefulWidget {
  @override
  _AddRiderDialogState createState() => _AddRiderDialogState();
}

class _AddRiderDialogState extends State<AddRiderDialog> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for input fields
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _cnicController = TextEditingController();
  final _addressController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Add rider logic goes here
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Rider added successfully!')),
      );
      Navigator.of(context).pop(); // Close the dialog
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color(0xffffffff),
      title: Row(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              icon: SizedBox(
                  height: 34,
                  width: 34,
                  child: Center(child: Image.asset(Assets.iconsCross))),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Text(
            'Add Rider',
            style: getBoldStyle(
              color: AppColors.textColor,
              fontSize: 20,
            ),
          ),
        ],
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * .5,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      width: 1,
                      color: AppColors.textFieldBorderColor,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Center(
                      child: SvgPicture.asset(
                        Assets.iconsMageUsersFill,
                      ),
                    ),
                  ),
                ),
                padding20,
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: CustomTextField(
                          title: 'Full Name',
                          controller: _nameController,
                          obscureText: false,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          hintText: '',
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return "Please enter name";
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: CustomTextField(
                          title: 'Email',
                          controller: _emailController,
                          obscureText: false,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          hintText: '',
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return "Please enter email";
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20), // More spacing between rows
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: CustomTextField(
                          title: 'Password',
                          controller: _passwordController,
                          obscureText: true,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          hintText: '',
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return "Please enter password";
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: CustomTextField(
                            title: 'Phone Number',
                            controller: _phoneController,
                            obscureText: false,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.phone,
                            hintText: '',
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Please enter number";
                              }
                              return null;
                            }),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: CustomTextField(
                            title: 'CNIC',
                            controller: _cnicController,
                            obscureText: false,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            hintText: '',
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Please enter CNIC";
                              }
                              return null;
                            }),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: CustomTextField(
                            title: 'Address',
                            controller: _addressController,
                            obscureText: false,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.text,
                            hintText: '',
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Please enter address";
                              }
                              return null;
                            }),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            'Cancel',
            style: getRegularStyle(
              color: AppColors.textColor,
            ),
          ),
        ),
        InkWell(
          onTap: _submitForm,
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.primaryColor),
            child: Text(
              'Add Rider',
              style: getMediumStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

void showAddRiderDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => Container(child: AddRiderDialog()),
  );
}
