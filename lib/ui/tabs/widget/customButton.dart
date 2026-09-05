import 'package:evantly_app/utils/app_text_theme.dart';
import 'package:flutter/material.dart';

class Custombutton extends StatelessWidget {
  String text;
  TextStyle Textstyle;
  IconData? prefixIcon;
  Color prefixIconColor;
  Color bgColor;
  bool center;
  bool imageIconPick;
  String? imagePathPrefix;
  Color borderColor;
  Function onButtonClick;

  Custombutton(
      {super.key,
      required this.onButtonClick,
      this.borderColor = Colors.transparent,
      this.imageIconPick = false,
      this.imagePathPrefix,
      this.center = false,
      this.prefixIcon,
      required this.text,
      this.prefixIconColor = Colors.red,
      required this.bgColor,
      required this.Textstyle});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(16),
            backgroundColor: bgColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            side: BorderSide(color: borderColor)),
        onPressed: () {
          onButtonClick();
        },
        child: Row(
          children: [
            if (prefixIcon != null)
              Icon(
                ///فيها غلطات بس انا مكنتش قادر واقتها ف سيبتها علي هذا الحال
                prefixIcon,
                color: prefixIconColor,
              )
            else
              SizedBox(),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                textAlign: center == true ? TextAlign.center : null,
                text,
                style: Textstyle,
              ),
            )
          ],
        ));
  }
}
