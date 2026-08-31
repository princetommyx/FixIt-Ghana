import 'package:flutter/material.dart';

/// Design tokens from docs/design-tokens.md. Do not hardcode raw hex values
/// in screens — reference these tokens instead.
abstract final class AppColors {
  static const Color primary = Color(0xFF16A34A);
  static const Color primaryDark = Color(0xFF15803D);
  static const Color deepGreen = Color(0xFF166534);

  static const Color background = Color(0xFFF8FAFC);
  static const Color surface = Color(0xFFFFFFFF);

  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF64748B);

  static const Color border = Color(0xFFE2E8F0);

  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFDC2626);
  static const Color info = Color(0xFF2563EB);
}
