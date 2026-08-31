import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/network/api_exception.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/app_primary_button.dart';
import '../providers/auth_controller.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _identifierController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _identifierController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    await ref.read(authControllerProvider.notifier).login(
          identifier: _identifierController.text.trim(),
          password: _passwordController.text,
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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.xxl),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppSpacing.xxxl),
                Text('Welcome back', style: AppTypography.heading1),
                const SizedBox(height: AppSpacing.xs),
                const Text(
                  'Sign in to continue to FixIt Ghana.',
                  style: AppTypography.caption,
                ),
                const SizedBox(height: AppSpacing.xxxl),
                TextFormField(
                  controller: _identifierController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Phone or email',
                    hintText: '024xxxxxxx or you@example.com',
                  ),
                  validator: (value) =>
                      (value == null || value.trim().isEmpty) ? 'Enter your phone or email' : null,
                ),
                const SizedBox(height: AppSpacing.lg),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(_obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                      onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                    ),
                  ),
                  validator: (value) =>
                      (value == null || value.isEmpty) ? 'Enter your password' : null,
                  onFieldSubmitted: (_) => _submit(),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Password reset is coming soon.')),
                    ),
                    child: const Text('Forgot password?'),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                AppPrimaryButton(label: 'Login', isLoading: isLoading, onPressed: _submit),
                const SizedBox(height: AppSpacing.xxl),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?", style: AppTypography.caption),
                    TextButton(
                      onPressed: () => context.push('/register'),
                      child: const Text('Register'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
