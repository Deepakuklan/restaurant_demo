import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xFF4CAF50); // Green
  static const Color secondaryColor = Color(0xFFFF9800); // Orange

  static const Color backgroundColor = Colors.white;
  static const Color surfaceColor = Color(0xFFF5F5F5); // Grey 100
  static const Color errorColor = Colors.red;

  static const Color textPrimary = Colors.black;
  static const Color textSecondary = Color(0xFF757575); // Grey 600
  static const Color textHint = Color(0xFFBDBDBD); // Grey 400
}

class AppTextStyles {
  static const TextStyle headline1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static const TextStyle headline2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle bodyText1 = TextStyle(fontSize: 16, color: AppColors.textPrimary);

  static const TextStyle bodyText2 = TextStyle(fontSize: 14, color: AppColors.textSecondary);

  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static const TextStyle caption = TextStyle(fontSize: 12, color: AppColors.textHint);
}
