import 'dart:ui';
import 'package:evantly_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AppStyle {
  static TextStyle w40014white = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.primary_light);
  static TextStyle bold24white = TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: AppColors.primary_light);
  static TextStyle bold14blue = TextStyle(
      fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.blue);
  static TextStyle bold16blue = TextStyle(
      fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.blue);
  static TextStyle medium14white = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: AppColors.primary_light);
  static TextStyle bold20blue = TextStyle(
      fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.blue);
  static TextStyle bold20white =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white);
}
