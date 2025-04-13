import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/app_Paddings.dart';
import '../utils/app_text_widgets.dart';
import '../utils/fonts_manager.dart';

class CustomButton extends StatelessWidget {
  final double height;
  final double width;
  final double radius;
  final Color btnColor;
  final Color btnTextColor;
  final Color borderColor;
  final String btnText;
  final VoidCallback onPress;

  const CustomButton(
      {super.key,
      this.height = 60,
      required this.width,
      this.radius = 10,
      required this.btnColor,
      required this.btnText,
      required this.btnTextColor,
      required this.onPress,
      this.borderColor = Colors.transparent});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      borderRadius: BorderRadius.circular(radius),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: btnColor,
          border: Border.all(
            color: borderColor,
          ),
        ),
        child: Center(
          child: Text(
            btnText,
            style: getBoldStyle(
              color: btnTextColor,
              fontSize: MyFonts.size16,
            ),
          ),
        ),
      ),
    );
  }
}

class CustomButtonWithIcon extends StatelessWidget {
  final double height;
  final double width;
  final double radius;
  final Color btnColor;
  final Color btnTextColor;
  final Color borderColor;
  final String btnText;
  final String assetName;
  final String iconPath;
  final VoidCallback onPress;

  const CustomButtonWithIcon(
      {super.key,
      this.height = 48,
      required this.width,
      this.radius = 10,
      this.iconPath = '',
      required this.btnColor,
      required this.btnText,
      required this.btnTextColor,
      required this.onPress,
      required this.assetName,
      required this.borderColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      overlayColor: WidgetStateColor.transparent,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            color: btnColor,
            border: Border.all(
              color: borderColor,
            )),
        child: Center(
          child: Row(
            children: [
              padding10,
              if (iconPath == '')
                Image.asset(assetName)
              else if (assetName == '')
                SvgPicture.asset(iconPath),
              Spacer(),
              Text(
                btnText,
                style: getMediumStyle(
                  color: btnTextColor,
                  fontSize: MyFonts.size12,
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
