import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({
    super.key,
    required this.title,
    this.message,
    this.icon = Icons.inbox_outlined,
  });

  final String title;
  final String? message;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: AppColors.textSecondary, size: 40),
            const SizedBox(height: AppSpacing.md),
            Text(title, style: AppTypography.bodyStrong, textAlign: TextAlign.center),
            if (message != null) ...[
              const SizedBox(height: AppSpacing.xs),
              Text(
                message!,
                style: AppTypography.caption,
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
