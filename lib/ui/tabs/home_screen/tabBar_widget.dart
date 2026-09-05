import 'package:evantly_app/utils/app_colors.dart';
import 'package:evantly_app/utils/app_text_theme.dart';
import 'package:flutter/material.dart';

class TabBarWidget extends StatelessWidget {
  String title;
  bool isSelected;

  TabBarWidget({super.key, required this.title,required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
      decoration: BoxDecoration(color: isSelected==true?AppColors.primary_light:null,
          border: Border.all(color: AppColors.primary_light, width: 2),
          borderRadius: BorderRadius.circular(46)),
      child: Text(
        title,
        style: isSelected==true?AppStyle.bold14blue.copyWith(fontSize: 16):
        AppStyle.medium14white.copyWith(fontSize: 16,fontWeight: FontWeight.bold),
      ),
    );
  }
}
