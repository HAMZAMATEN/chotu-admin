
import 'package:chotu_admin/utils/app_text_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_Colors.dart';

showCustomAlert(BuildContext context, String title, String content,
    VoidCallback? onTap, bool? isCancelButton,
    {bool barrierDismissible = true}) {
  showCupertinoDialog<String>(
      barrierDismissible: barrierDismissible,
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(
          title,
          style: getBoldStyle(color: AppColors.textColor, fontSize: 16),
        ),
        content: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              content,
              style:
              getMediumStyle(color: AppColors.textColor, fontSize: 14),
            )
          ],
        ),
        actions: isCancelButton == false
            ? [
          TextButton(
            onPressed: onTap,
            child: Text(
              'Ok',
              style: getRegularStyle(
                color: AppColors.textColor,
                fontSize: 14,
              ),
            ),
          )
        ]
            : [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'No',
              style: getRegularStyle(
                color: AppColors.textColor,
                fontSize: 14,
              ),
            ),
          ),
          TextButton(
            onPressed: onTap,
            child: Text(
              'Yes',
              style: getRegularStyle(
                color: AppColors.textColor,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ));
}
