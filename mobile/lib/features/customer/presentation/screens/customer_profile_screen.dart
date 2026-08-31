import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../auth/presentation/providers/auth_controller.dart';

class CustomerProfileScreen extends ConsumerWidget {
  const CustomerProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authControllerProvider).valueOrNull;

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
                child: Icon(Icons.person_rounded, color: Colors.white, size: 32),
              ),
              const SizedBox(width: AppSpacing.lg),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(user?.name ?? '', style: AppTypography.heading3),
                    const SizedBox(height: 2),
                    Text(
                      user?.phone ?? user?.email ?? '',
                      style: AppTypography.caption,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xxxl),
          _SettingsTile(icon: Icons.edit_outlined, label: 'Edit profile'),
          _SettingsTile(icon: Icons.location_on_outlined, label: 'Saved addresses'),
          _SettingsTile(icon: Icons.notifications_outlined, label: 'Notifications'),
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
