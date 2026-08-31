import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';

/// Placeholder for screens outside this build's scope, so bottom navigation
/// is fully wired without half-building unrelated features.
class ComingSoonView extends StatelessWidget {
  const ComingSoonView({super.key, required this.title, required this.icon});

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xxl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 40, color: AppColors.textSecondary),
              const SizedBox(height: AppSpacing.md),
              Text('$title is coming soon', style: AppTypography.bodyStrong),
            ],
          ),
        ),
      ),
    );
  }
}
