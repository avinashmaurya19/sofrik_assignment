import 'package:flutter/material.dart';

import 'package:sofrik_assignment/widget/app_colors.dart';

/// App text styles using Work Sans font family
class AppTextStyles {
  AppTextStyles._();


  static TextStyle mediumStyle({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    TextDecoration? decoration,
    double? letterSpacing,
    height,
  }) {
    return _textStyle(
      color: color,
      fontSize: fontSize ?? 14,
      fontWeight: fontWeight ?? FontWeight.w500,
      decoration: decoration,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  static TextStyle semiBoldStyle({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    TextDecoration? decoration,
    double? letterSpacing,
    height,
  }) {
    return _textStyle(
      color: color,
      fontSize: fontSize ?? 14,
      fontWeight: fontWeight ?? FontWeight.w600,
      decoration: decoration,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  static TextStyle boldStyle({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    TextDecoration? decoration,
    double? letterSpacing,
    height,
  }) {
    return _textStyle(
      color: color,
      fontSize: fontSize ?? 22,
      fontWeight: fontWeight ?? FontWeight.w700,
      decoration: decoration,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  static TextStyle regularStyle({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    TextDecoration? decoration,
    double? letterSpacing,
    height,
  }) {
    return _textStyle(
      color: color,
      fontSize: fontSize ?? 12,
      decoration: decoration,
      fontWeight: fontWeight ?? FontWeight.w400,
      height: height,
      letterSpacing: letterSpacing,
    );
  }
}

TextStyle _textStyle({
  Color? color = AppColors.primary,
  required double fontSize,
  FontWeight? fontWeight,
  TextDecoration? decoration,
  double? height,
  double? letterSpacing,
}) {
  // return GoogleFonts.inter(
  return TextStyle(
    color: color,
    fontSize: fontSize,
    decoration: decoration,
    decorationColor: color,
    fontWeight: fontWeight,
    height: height,
    letterSpacing: letterSpacing,
  );
}
