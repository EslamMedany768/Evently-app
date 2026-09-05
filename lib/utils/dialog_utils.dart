import 'package:evantly_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class DialogUtils {
  static show(
      {required BuildContext context,
      String? posActName,
      Function()? posActButton,
      String? title,
      required String message}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: title == null ? null : Text(title),
        content: Text(message),
        actions: posActName == null
            ? null
            : [TextButton(onPressed: posActButton, child: Text(posActName))],
      ),
    );
  }

  static hide(BuildContext context) {
    Navigator.of(context).pop();
  }

  static showLoading(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(
              color: AppColors.blue,
            ),
            SizedBox(
              width: 5,
            ),
            Text("Loading...")
          ],
        ),
      ),
    );
  }
}
