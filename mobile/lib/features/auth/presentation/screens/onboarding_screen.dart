import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/onboarding/onboarding_store.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class _OnboardingPage {
  const _OnboardingPage({required this.icon, required this.title, required this.description});

  final IconData icon;
  final String title;
  final String description;
}

const _pages = [
  _OnboardingPage(
    icon: Icons.search_rounded,
    title: 'Find help fast',
    description: 'Tell FixIt what you need — plumbing, electrical, cleaning and more — '
        'and reach verified local professionals in minutes.',
  ),
  _OnboardingPage(
    icon: Icons.compare_arrows_rounded,
    title: 'Compare quotes',
    description: 'Professionals send you quotes with prices, ratings and completed jobs, '
        'so you can pick who to trust with confidence.',
  ),
  _OnboardingPage(
    icon: Icons.task_alt_rounded,
    title: 'Get it done',
    description: 'Track the job from confirmed to completed, message your professional, '
        'and leave a review when it is done.',
  ),
];

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _controller = PageController();
  int _page = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _finish() async {
    await ref.read(onboardingStoreProvider).markComplete();
    if (!mounted) return;
    context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    final isLast = _page == _pages.length - 1;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: TextButton(onPressed: _finish, child: const Text('Skip')),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _pages.length,
                onPageChanged: (page) => setState(() => _page = page),
                itemBuilder: (context, index) {
                  final page = _pages[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxxl),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 140,
                          height: 140,
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(page.icon, color: AppColors.primary, size: 64),
                        ),
                        const SizedBox(height: AppSpacing.xxxl),
                        Text(page.title, style: AppTypography.heading1, textAlign: TextAlign.center),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          page.description,
                          style: AppTypography.body.copyWith(color: AppColors.textSecondary),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i < _pages.length; i++)
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: i == _page ? 22 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: i == _page ? AppColors.primary : AppColors.border,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.xxl),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isLast
                      ? _finish
                      : () => _controller.nextPage(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeOut,
                          ),
                  child: Text(isLast ? 'Get Started' : 'Continue'),
                ),
              ),
            ),
            if (isLast)
              Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.lg),
                child: TextButton(
                  onPressed: _finish,
                  child: const Text('I already have an account'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
