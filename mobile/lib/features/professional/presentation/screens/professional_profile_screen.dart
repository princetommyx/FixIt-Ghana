import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../auth/presentation/providers/auth_controller.dart';

class ProfessionalProfileScreen extends ConsumerWidget {
  const ProfessionalProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authControllerProvider).valueOrNull;
    final profile = user?.professionalProfile;

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 32,
                backgroundColor: AppColors.primary,
                child: Icon(Icons.engineering_rounded, color: Colors.white, size: 32),
              ),
              const SizedBox(width: AppSpacing.lg),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            profile?.businessName?.isNotEmpty == true
                                ? profile!.businessName!
                                : (user?.name ?? ''),
                            style: AppTypography.heading3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (profile?.isVerified == true) ...[
                          const SizedBox(width: 6),
                          const Icon(Icons.verified_rounded, color: AppColors.primary, size: 18),
                        ],
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      profile == null || profile.ratingCount == 0
                          ? 'No ratings yet'
                          : '${profile.rating.toStringAsFixed(1)} ★ (${profile.ratingCount}) · ${profile.completedJobsCount} jobs',
                      style: AppTypography.caption,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xxxl),
          _SettingsTile(icon: Icons.badge_outlined, label: 'Verification'),
          _SettingsTile(icon: Icons.edit_outlined, label: 'Edit profile & portfolio'),
          _SettingsTile(icon: Icons.build_outlined, label: 'Services & coverage area'),
          _SettingsTile(icon: Icons.help_outline_rounded, label: 'Help & support'),
          const SizedBox(height: AppSpacing.xxl),
          OutlinedButton(
            onPressed: () => ref.read(authControllerProvider.notifier).logout(),
            style: OutlinedButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Log out'),
          ),
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({required this.icon, required this.label});

  final IconData icon;
  final String label;

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
        leading: Icon(icon, color: AppColors.textSecondary),
        title: Text(label, style: AppTypography.body),
        trailing: const Icon(Icons.chevron_right_rounded, color: AppColors.textSecondary),
        shape: RoundedRectangleBorder(borderRadius: AppRadii.mdRadius),
        onTap: () {},
      ),
    );
  }
}
