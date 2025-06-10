import 'package:flutter/material.dart';
import 'package:food_for_family/common/constants/colors.dart';
import 'package:food_for_family/common/constants/text_styles.dart';

class ThemeStyles {
  static ThemeData get lightTheme {
    return ThemeData(
        shadowColor: AppColors.dropShadow,
        primaryColor: AppColors.brandPrimaryBase,
        scaffoldBackgroundColor: AppColors.neutralLighter,
        appBarTheme: AppBarTheme(
            foregroundColor: AppColors.brandSecondaryDarkest,
            backgroundColor: AppColors.white,
            titleTextStyle: AppTextStyles.ibmPlexSansBold(
                16, AppColors.brandSecondaryDarkest),
            shadowColor: AppColors.dropShadow,
            actionsIconTheme: const IconThemeData(
                color: AppColors.brandSecondaryDarkest, size: 20),
            centerTitle: false),
        highlightColor: AppColors.itemSelected,
        cardTheme: const CardTheme(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)))));
  }
}
