import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({super.key, required this.message, this.onRetry});

  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline_rounded, color: AppColors.error, size: 40),
            const SizedBox(height: AppSpacing.md),
            Text(message, textAlign: TextAlign.center, style: AppTypography.body),
            if (onRetry != null) ...[
              const SizedBox(height: AppSpacing.lg),
              OutlinedButton(onPressed: onRetry, child: const Text('Try again')),
            ],
          ],
        ),
      ),
    );
  }
}
