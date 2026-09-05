import 'package:evantly_app/utils/app_colors.dart';
import 'package:evantly_app/utils/app_text_theme.dart';
import 'package:flutter/material.dart';

class CustomTabWidget extends StatelessWidget {
  String eventName;

  bool isSelected;

  CustomTabWidget(
      {super.key, required this.eventName, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 18),
      decoration: BoxDecoration(
          color: isSelected == true ? AppColors.blue : Colors.white,
          border: Border.all(color: AppColors.blue, width: 2),
          borderRadius: BorderRadius.circular(28)),
      child: Text(
        eventName,
        style: isSelected == true
            ? AppStyle.bold20white.copyWith(fontSize: 18)
            : AppStyle.bold16blue.copyWith(fontSize: 18),
      ),
    );
  }
}
