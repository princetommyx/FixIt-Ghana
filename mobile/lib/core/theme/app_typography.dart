import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Inter (falling back to the platform sans-serif when the font asset isn't
/// bundled) per the design system's typography rule.
abstract final class AppTypography {
  static const String fontFamily = 'Inter';

  static const TextStyle heading1 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    height: 1.2,
  );

  static const TextStyle heading2 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    height: 1.25,
  );

  static const TextStyle heading3 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  static const TextStyle body = TextStyle(
    fontFamily: fontFamily,
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    height: 1.45,
  );

  static const TextStyle bodyStrong = TextStyle(
    fontFamily: fontFamily,
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.45,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: fontFamily,
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.4,
  );

  static const TextStyle button = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.2,
  );
}
