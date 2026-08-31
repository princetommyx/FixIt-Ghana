import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../providers/registration_draft.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _identifierController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _acceptedTerms = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _identifierController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _continue() {
    if (!_formKey.currentState!.validate()) return;

    if (!_acceptedTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please accept the Terms of Service to continue.')),
      );
      return;
    }

    final identifier = _identifierController.text.trim();
    final isEmail = identifier.contains('@');

    ref.read(registrationDraftProvider.notifier).state = RegistrationDraft(
      name: _nameController.text.trim(),
      password: _passwordController.text,
      phone: isEmail ? null : identifier,
      email: isEmail ? identifier : null,
    );

    context.push('/role-selection');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(AppSpacing.xxl, 0, AppSpacing.xxl, AppSpacing.xxl),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Create your account', style: AppTypography.heading1),
                const SizedBox(height: AppSpacing.xs),
                const Text(
                  'Join FixIt Ghana as a customer or professional.',
                  style: AppTypography.caption,
                ),
                const SizedBox(height: AppSpacing.xxxl),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Full name'),
                  validator: (value) =>
                      (value == null || value.trim().isEmpty) ? 'Enter your name' : null,
                ),
                const SizedBox(height: AppSpacing.lg),
                TextFormField(
                  controller: _identifierController,
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
                      (value == null || value.length < 8) ? 'Use at least 8 characters' : null,
                ),
                const SizedBox(height: AppSpacing.lg),
                TextFormField(
                  controller: _confirmController,
                  obscureText: _obscurePassword,
                  decoration: const InputDecoration(labelText: 'Confirm password'),
                  validator: (value) =>
                      value != _passwordController.text ? 'Passwords do not match' : null,
                ),
                const SizedBox(height: AppSpacing.lg),
                CheckboxListTile(
                  value: _acceptedTerms,
                  onChanged: (value) => setState(() => _acceptedTerms = value ?? false),
                  contentPadding: EdgeInsets.zero,
                  controlAffinity: ListTileControlAffinity.leading,
                  title: const Text('I agree to the Terms of Service', style: AppTypography.caption),
                ),
                const SizedBox(height: AppSpacing.md),
                ElevatedButton(onPressed: _continue, child: const Text('Continue')),
                const SizedBox(height: AppSpacing.xxl),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account?', style: AppTypography.caption),
                    TextButton(
                      onPressed: () => context.pop(),
                      child: const Text('Login'),
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
