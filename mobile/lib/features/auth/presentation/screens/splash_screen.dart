import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/onboarding/onboarding_store.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../data/models/user.dart';
import '../providers/auth_controller.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _bootstrap());
  }

  Future<void> _bootstrap() async {
    final user = await ref.read(authControllerProvider.future);
    if (!mounted) return;

    if (user != null) {
      context.go(user.role == UserRole.professional ? '/professional/home' : '/customer/home');
      return;
    }

    final onboardingDone = await ref.read(onboardingStoreProvider).isComplete();
    if (!mounted) return;

    context.go(onboardingDone ? '/login' : '/onboarding');
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.handyman_rounded, color: AppColors.primary, size: 56),
            SizedBox(height: AppSpacing.md),
            Text('FixIt Ghana', style: AppTypography.heading1),
            SizedBox(height: AppSpacing.xs),
            Text(
              'Find trusted professionals. Get the job done.',
              style: AppTypography.caption,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
