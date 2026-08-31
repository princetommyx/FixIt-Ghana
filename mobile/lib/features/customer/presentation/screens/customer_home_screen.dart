import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/error_view.dart';
import '../../../../shared/widgets/loading_view.dart';
import '../../../auth/presentation/providers/auth_controller.dart';
import '../../../categories/presentation/category_icons.dart';
import '../../../categories/presentation/providers/categories_provider.dart';

class CustomerHomeScreen extends ConsumerWidget {
  const CustomerHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authControllerProvider).valueOrNull;
    final categoriesAsync = ref.watch(categoriesProvider);
    final firstName = (user?.name ?? '').split(' ').first;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => ref.refresh(categoriesProvider.future),
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.xxl),
            children: [
              Text(
                firstName.isEmpty ? 'Welcome' : 'Hello, $firstName',
                style: AppTypography.heading2,
              ),
              const SizedBox(height: AppSpacing.xs),
              const Text(
                'What do you need help with today?',
                style: AppTypography.caption,
              ),
              const SizedBox(height: AppSpacing.xl),
              _StartRequestCard(onTap: () => context.push('/customer/requests')),
              const SizedBox(height: AppSpacing.xxl),
              const Text('Popular services', style: AppTypography.heading3),
              const SizedBox(height: AppSpacing.md),
              categoriesAsync.when(
                loading: () => const Padding(
                  padding: EdgeInsets.symmetric(vertical: AppSpacing.xxl),
                  child: LoadingView(),
                ),
                error: (error, _) => ErrorView(
                  message: 'Could not load services.',
                  onRetry: () => ref.invalidate(categoriesProvider),
                ),
                data: (categories) => GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: AppSpacing.md,
                    crossAxisSpacing: AppSpacing.md,
                    childAspectRatio: 0.85,
                  ),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return _CategoryTile(
                      icon: categoryIconFor(category.icon),
                      label: category.name,
                      onTap: () => context.push('/customer/requests'),
                    );
                  },
                ),
              ),
              const SizedBox(height: AppSpacing.xxl),
              Container(
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.08),
                  borderRadius: AppRadii.mdRadius,
                ),
                child: const Row(
                  children: [
                    Icon(Icons.verified_rounded, color: AppColors.primary),
                    SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Text(
                        'Every professional on FixIt is verified before they can quote a job.',
                        style: AppTypography.caption,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StartRequestCard extends StatelessWidget {
  const _StartRequestCard({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppRadii.lgRadius,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpacing.xl),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: AppRadii.lgRadius,
        ),
        child: const Row(
          children: [
            Icon(Icons.add_circle_rounded, color: Colors.white, size: 32),
            SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'What do you need help with?',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Post a request and get quotes from verified pros',
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 16),
          ],
        ),
      ),
    );
  }
}

class _CategoryTile extends StatelessWidget {
  const _CategoryTile({required this.icon, required this.label, required this.onTap});

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppRadii.mdRadius,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.md, horizontal: AppSpacing.xs),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppRadii.mdRadius,
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppColors.primary, size: 26),
            const SizedBox(height: AppSpacing.sm),
            Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.caption.copyWith(fontWeight: FontWeight.w600, color: AppColors.textPrimary),
            ),
          ],
        ),
      ),
    );
  }
}
