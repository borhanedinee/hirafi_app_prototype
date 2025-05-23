import 'package:flutter/material.dart';
import 'package:hirafi/core/themes/app_theme.dart';

class AppColors {
  static const Color primaryColor = Color(0xffff3600);
  static const Color blackColor = Color(0xff171717);
  static const Color greyColor = Color(0xff808080);
  static const Color whiteColor = Color(0xffffffff);
  static const Color gradiantColor = Color(0xFFE6F0FA);

  // CARDS SHADOW COLOR
  static Color shadowColor =
      greyColor.withValues(alpha: AppThemes.SHADOW_OPACITY);
}
