
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_text_style.dart';


class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.whiteColor,
    indicatorColor: AppColors.blackColor,
    scaffoldBackgroundColor: AppColors.whiteColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.whiteColor,
      iconTheme: IconThemeData(color: AppColors.blackColor),
      centerTitle: true,
    ),
    textTheme: TextTheme(
      labelLarge: AppTextStyle.bold16Black,
      labelMedium: AppTextStyle.medium14Black,
      labelSmall: AppTextStyle.medium12Gray,
      headlineMedium: AppTextStyle.medium24Black,
      headlineLarge: AppTextStyle.medium20Black,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    primaryColor: AppColors.blackColor,
    indicatorColor: AppColors.whiteColor,
    scaffoldBackgroundColor: AppColors.blackColor,
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor: AppColors.blackColor,
      iconTheme: IconThemeData(color: AppColors.whiteColor),
    ),
    textTheme: TextTheme(
      labelLarge: AppTextStyle.bold16White,
      labelMedium: AppTextStyle.medium14White,
      labelSmall: AppTextStyle.medium12Gray,
      headlineMedium: AppTextStyle.medium24White,
      headlineLarge: AppTextStyle.medium20White,
    ),
  );

}
