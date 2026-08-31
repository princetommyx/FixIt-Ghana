import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Holds the name/contact/password collected on the Registration screen
/// (spec 8.6) until Role Selection (spec 8.7) picks a role and the account
/// is actually created.
class RegistrationDraft {
  const RegistrationDraft({
    required this.name,
    required this.password,
    this.phone,
    this.email,
  });

  final String name;
  final String password;
  final String? phone;
  final String? email;
}

final registrationDraftProvider = StateProvider<RegistrationDraft?>((ref) => null);
