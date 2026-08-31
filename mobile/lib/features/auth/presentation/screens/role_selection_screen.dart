import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/api_exception.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/app_primary_button.dart';
import '../providers/auth_controller.dart';
import '../providers/registration_draft.dart';

class RoleSelectionScreen extends ConsumerStatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  ConsumerState<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends ConsumerState<RoleSelectionScreen> {
  String? _selectedRole;

  Future<void> _confirm() async {
    final role = _selectedRole;
    final draft = ref.read(registrationDraftProvider);
    if (role == null || draft == null) return;

    await ref.read(authControllerProvider.notifier).register(
          role: role,
          name: draft.name,
          password: draft.password,
          phone: draft.phone,
          email: draft.email,
        );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(authControllerProvider, (previous, next) {
      final error = next.error;
      if (error is ApiException && !next.isLoading) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(error.message), backgroundColor: AppColors.error));
      }
    });

    final isLoading = ref.watch(authControllerProvider).isLoading;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xxl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('How will you use FixIt?', style: AppTypography.heading1),
              const SizedBox(height: AppSpacing.xs),
              const Text(
                'You can always reach out to us to change this later.',
                style: AppTypography.caption,
              ),
              const SizedBox(height: AppSpacing.xxxl),
              _RoleCard(
                icon: Icons.person_search_rounded,
                title: 'I need a service',
                description: 'Post a job, compare quotes and hire a trusted professional.',
                selected: _selectedRole == 'customer',
                onTap: () => setState(() => _selectedRole = 'customer'),
              ),
              const SizedBox(height: AppSpacing.lg),
              _RoleCard(
                icon: Icons.engineering_rounded,
                title: 'I provide a service',
                description: 'Get verified, receive job requests and grow your reputation.',
                selected: _selectedRole == 'professional',
                onTap: () => setState(() => _selectedRole = 'professional'),
              ),
              const Spacer(),
              AppPrimaryButton(
                label: 'Continue',
                isLoading: isLoading,
                onPressed: _selectedRole == null ? null : _confirm,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  const _RoleCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String description;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppRadii.mdRadius,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppRadii.mdRadius,
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.border,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: AppRadii.smRadius,
              ),
              child: Icon(icon, color: AppColors.primary),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTypography.bodyStrong),
                  const SizedBox(height: 2),
                  Text(description, style: AppTypography.caption),
                ],
              ),
            ),
            Icon(
              selected ? Icons.check_circle_rounded : Icons.circle_outlined,
              color: selected ? AppColors.primary : AppColors.border,
            ),
          ],
        ),
      ),
    );
  }
}
