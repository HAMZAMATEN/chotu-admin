import 'package:chotu_admin/utils/app_Paddings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../generated/assets.dart';
import '../../utils/app_Colors.dart';
import '../../utils/toast_dialogue.dart';
import '../../widgets/custom_Button.dart';
import '../sidebar/side_bar_screen.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late String email, password;
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  String? user;
  /// email con
  TextEditingController emailController = TextEditingController();
  /// password con
  TextEditingController passwordController = TextEditingController();
  ///  validCredentials
  final Map<String, String> validCredentials = {
    'chotu@admin.com': 'chotu@123',
    'wahab@admin.com': 'wahab@123',
  };


  bool validateAndSave() {
    final form = globalKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.withOpacity(.1),
        body:_buildDesktopView(context)
    );
  }
  /// build Desktop View
  Widget _buildDesktopView(BuildContext context){
    return

      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * .50,


                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 10.0),
                        Container(
                          height: 100,
                          width: 120,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                  Assets.imagesAppLogo,

                                ),
                                fit: BoxFit.contain),
                          ),
                        ),
                        Divider(
                          thickness: 1.0,
                          color: Colors.grey.withOpacity(0.1),
                        ),
                        Text(
                          'Chotu Login Panel',
                          style: TextStyle(
                              color:  Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 21.0),
                          textAlign: TextAlign.center,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Form(
                            key: globalKey,
                            child: Column(
                              children: [
                                /// email text filed
                                TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Email can\'n be empty';
                                    } else if (!value.contains('@')) {
                                      return 'Please enter a valid email';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {},
                                  showCursor: true,
                                  controller: emailController,
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                    labelText: 'Email',
                                    labelStyle: TextStyle(
                                        color: Colors.black),
                                    hintText: 'Enter your email address',
                                    hintStyle: TextStyle(
                                        color: Colors.black54),
                                    contentPadding: const EdgeInsets.all(4.0),
                                    enabledBorder: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(4.0),
                                      ),
                                      borderSide: BorderSide(
                                          color: Colors.green,
                                          width: 1),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4.0)),
                                      borderSide: BorderSide(
                                          color: Colors.green,
                                          width: 2),
                                    ),
                                    errorBorder: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4.0)),
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 1),
                                    ),
                                  ),
                                  // textFieldType: TextFieldType.EMAIL,
                                ),
                                const SizedBox(height: 20.0),
                                /// password text filed
                                TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Password can\'t be empty';
                                    } else if (value.length < 4) {
                                      return 'Please enter a bigger password';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {},
                                  controller: passwordController,
                                  showCursor: true,
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    floatingLabelAlignment:
                                    FloatingLabelAlignment.start,
                                    labelStyle: TextStyle(
                                        color: Colors.black),
                                    hintText: 'Enter your password',
                                    hintStyle: TextStyle(
                                        color: Colors.black54),
                                    contentPadding: const EdgeInsets.all(4.0),
                                    enabledBorder: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(4.0),
                                      ),
                                      borderSide: BorderSide(
                                          color: Colors.green,
                                          width: 1),
                                    ),
                                    errorBorder: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4.0)),
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 1),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4.0)),
                                      borderSide: BorderSide(
                                          color: Colors.green,
                                          width: 2),
                                    ),
                                  ),
                                  // textFieldType: TextFieldType.PASSWORD,
                                ),
                                const SizedBox(height: 20.0),
                                /// login button
                                CustomButton(
                                  height: 50,
                                  width: double.infinity,
                                  btnColor: AppColors.primaryColor,
                                  btnText: 'Login',
                                  btnTextColor: Colors.white,
                                  onPress: () async{
                                    if (globalKey.currentState!.validate()) {
                                      String enteredEmail = emailController.text.trim();
                                      String enteredPassword = passwordController.text;

                                      if (validCredentials.containsKey(enteredEmail) &&
                                          validCredentials[enteredEmail] == enteredPassword) {
                                        ShowToastDialog.showLoader('Please Wait');
                                        Get.offAll(() => const SideBarScreen());
                                        ShowToastDialog.closeLoader();


                                      } else {
                                        ShowToastDialog.showToast('Invalid Credentials');
                                      }
                                    }

                                  },
                                ),
                               padding20,

                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      )

    ;
  }
}
