import 'package:evantly_app/utils/app_colors.dart';
import 'package:evantly_app/utils/app_text_theme.dart';
import 'package:flutter/material.dart';

class Customtextfield extends StatelessWidget {
  String name;
  Color HintColor;
  Color errorColor;
  IconData? prefixIcon;
  TextStyle? writeStyle;
  Color? prefixColor;
  Color? cursorColor;
  Color borderColor;
  int? maxLines;
  IconData? sufixIcon;
  String? Function(String?)? validator;
  TextEditingController? controller;

  Customtextfield({super.key, this.controller,
    this.maxLines,
    this.cursorColor,
    this.writeStyle,
    this.validator = null,
    required this.borderColor,
    this.sufixIcon,
    required this.errorColor,
    required this.name,
    this.prefixIcon,
    this.prefixColor,
    required this.HintColor});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller:controller,
      maxLines: maxLines,
      validator: validator,
      cursorColor: cursorColor,
      style: writeStyle,
      decoration: InputDecoration(
          suffixIcon: sufixIcon == null ? null : Icon(sufixIcon),
          hintText: name,
          hintStyle: TextStyle(color: HintColor),
          prefixIcon: prefixIcon != null
              ? Icon(
            prefixIcon,
            size: 30,
            color: prefixColor,
          )
              : null,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: borderColor, width: 1)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: borderColor, width: 1)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: errorColor, width: 1)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: errorColor, width: 1))),
    );
  }
}
