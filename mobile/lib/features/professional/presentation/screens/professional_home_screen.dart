import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../auth/data/models/professional_profile.dart';
import '../../../auth/presentation/providers/auth_controller.dart';

class ProfessionalHomeScreen extends ConsumerWidget {
  const ProfessionalHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authControllerProvider).valueOrNull;
    final profile = user?.professionalProfile;
    final firstName = (user?.name ?? '').split(' ').first;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.xxl),
          children: [
            Text(
              firstName.isEmpty ? 'Welcome' : 'Hello, $firstName',
              style: AppTypography.heading2,
            ),
            const SizedBox(height: AppSpacing.xs),
            const Text('Here is what is happening today.', style: AppTypography.caption),
            const SizedBox(height: AppSpacing.xl),
            if (profile != null) _VerificationBanner(profile: profile),
            const SizedBox(height: AppSpacing.xl),
            Row(
              children: [
                Expanded(
                  child: _StatCard(
                    label: 'Rating',
                    value: profile == null || profile.ratingCount == 0
                        ? '—'
                        : profile.rating.toStringAsFixed(1),
                    icon: Icons.star_rounded,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: _StatCard(
                    label: 'Completed jobs',
                    value: '${profile?.completedJobsCount ?? 0}',
                    icon: Icons.task_alt_rounded,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xxl),
            const Text('Quick actions', style: AppTypography.heading3),
            const SizedBox(height: AppSpacing.md),
            _QuickAction(
              icon: Icons.work_outline_rounded,
              label: 'New job requests',
              onTap: () => context.go('/professional/jobs'),
            ),
            _QuickAction(
              icon: Icons.payments_outlined,
              label: 'Earnings',
              onTap: () => context.go('/professional/earnings'),
            ),
          ],
        ),
      ),
    );
  }
}

class _VerificationBanner extends StatelessWidget {
  const _VerificationBanner({required this.profile});

  final ProfessionalProfile profile;

  @override
  Widget build(BuildContext context) {
    final (color, icon, message) = switch (profile.verificationStatus) {
      'verified' => (AppColors.primary, Icons.verified_rounded, 'Your account is verified. You can quote jobs.'),
      'pending' => (AppColors.warning, Icons.hourglass_top_rounded, 'Verification submitted — under review.'),
      'rejected' => (AppColors.error, Icons.error_outline_rounded, 'Verification was rejected. Please resubmit.'),
      _ => (AppColors.warning, Icons.assignment_late_outlined, 'Submit verification to start receiving jobs.'),
    };

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: AppRadii.mdRadius,
      ),
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: AppSpacing.md),
          Expanded(child: Text(message, style: AppTypography.caption)),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.label, required this.value, required this.icon});

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadii.mdRadius,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.primary),
          const SizedBox(height: AppSpacing.sm),
          Text(value, style: AppTypography.heading2),
          Text(label, style: AppTypography.caption),
        ],
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  const _QuickAction({required this.icon, required this.label, required this.onTap});

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadii.mdRadius,
        border: Border.all(color: AppColors.border),
      ),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primary),
        title: Text(label, style: AppTypography.bodyStrong),
        trailing: const Icon(Icons.chevron_right_rounded, color: AppColors.textSecondary),
        shape: RoundedRectangleBorder(borderRadius: AppRadii.mdRadius),
        onTap: onTap,
      ),
    );
  }
}
