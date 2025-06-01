import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/app_Colors.dart';
import '../utils/app_Paddings.dart';
import '../utils/app_text_widgets.dart';

Widget CustomTextField(
    {required String title,
    required TextEditingController controller,
    required bool obscureText,
    required TextInputAction textInputAction,
    required TextInputType keyboardType,
    String? Function(String?)? validator,
    Widget? prefixIcon,
    void Function(String)? onChanged,
    void Function(String)? onFieldSubmitted,
    Widget? suffixIcon,
    int? minLines,
    int? maxLines,
    Color borderColor = AppColors.textFieldBorderColor,
    double? borderRadius = 10,
    required String hintText,
    FocusNode? focusNode,
    double width = double.infinity,
    double height = double.infinity,
    bool? enabled,
    bool isBoldHint = false,
    List<TextInputFormatter>? inputFormatters}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: getBoldStyle(
          color: AppColors.textColor,
          fontSize: 14,
        ),
      ),
      if (title != "") padding8,
      Container(
        width: width,
        child: TextFormField(
          focusNode: focusNode,
          onChanged: onChanged,
          onFieldSubmitted: onFieldSubmitted,
          obscuringCharacter: '*',
          minLines: obscureText ? 1 : minLines,
          maxLines: obscureText ? 1 : maxLines,
          inputFormatters: inputFormatters,
          controller: controller,
          enabled: enabled,
          cursorColor: AppColors.primaryColor,
          obscureText: obscureText,
          style: getSemiBoldStyle(color: AppColors.textColor, fontSize: 14),
          textInputAction: textInputAction,
          keyboardType: keyboardType,
          validator: validator,
          decoration: InputDecoration(
            fillColor: AppColors.textFieldFillColor,
            filled: true,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            hintText: hintText,
            hintStyle:  getMediumStyle(color: Color(0xffB0B4BE), fontSize: 13)
                ,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius!),
              borderSide: BorderSide(color: borderColor, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(color: borderColor, width: 1),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(color: borderColor, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(color: borderColor, width: 1),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide:
                  BorderSide(color: AppColors.textFieldErrorColor, width: 1),
            ),
          ),
        ),
      ),
    ],
  );
}
