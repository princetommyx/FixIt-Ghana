import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_radii.dart';
import 'app_typography.dart';

abstract final class AppTheme {
  static ThemeData get light {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        error: AppColors.error,
        surface: AppColors.surface,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: AppColors.background,
      fontFamily: AppTypography.fontFamily,
    );

    return base.copyWith(
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: AppTypography.heading3,
      ),
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadii.mdRadius,
          side: const BorderSide(color: AppColors.border),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: AppRadii.mdRadius,
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadii.mdRadius,
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadii.mdRadius,
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppRadii.mdRadius,
          borderSide: const BorderSide(color: AppColors.error),
        ),
        labelStyle: AppTypography.body,
        hintStyle: AppTypography.body.copyWith(color: AppColors.textSecondary),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          disabledBackgroundColor: AppColors.primary.withValues(alpha: 0.4),
          minimumSize: const Size.fromHeight(52),
          textStyle: AppTypography.button,
          shape: RoundedRectangleBorder(borderRadius: AppRadii.mdRadius),
          elevation: 0,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          minimumSize: const Size.fromHeight(48),
          side: const BorderSide(color: AppColors.border),
          textStyle: AppTypography.button,
          shape: RoundedRectangleBorder(borderRadius: AppRadii.mdRadius),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          textStyle: AppTypography.bodyStrong,
        ),
      ),
      dividerTheme: const DividerThemeData(color: AppColors.border, thickness: 1),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
      ),
      textTheme: base.textTheme.copyWith(
        headlineLarge: AppTypography.heading1,
        headlineMedium: AppTypography.heading2,
        titleLarge: AppTypography.heading3,
        bodyLarge: AppTypography.body,
        bodyMedium: AppTypography.body,
        labelLarge: AppTypography.button,
        bodySmall: AppTypography.caption,
      ),
    );
  }
}
