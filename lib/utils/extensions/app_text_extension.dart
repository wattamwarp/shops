import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

extension AppTextExtension on String {
  String toRupees() {
    return '₹${trim()}';
  }

  Widget heading({
    Color? color,
    double fontSize = 24,
    FontWeight fontWeight = FontWeight.bold,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
  }) {
    return Text(
      this,
      style: TextStyle(
        color: color ?? AppColors.text,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  Widget subheading({
    Color? color,
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.w500,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
  }) {
    return Text(
      this,
      style: TextStyle(
        color: color ?? AppColors.subtext,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
