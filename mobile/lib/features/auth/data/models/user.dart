import 'professional_profile.dart';

enum UserRole { customer, professional, admin }

UserRole _roleFromJson(String? value) {
  switch (value) {
    case 'professional':
      return UserRole.professional;
    case 'admin':
      return UserRole.admin;
    case 'customer':
    default:
      return UserRole.customer;
  }
}

class User {
  const User({
    required this.id,
    required this.role,
    required this.name,
    required this.status,
    this.phone,
    this.email,
    this.professionalProfile,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    final profileJson = json['professional_profile'];

    return User(
      id: json['id'] as int,
      role: _roleFromJson(json['role'] as String?),
      name: json['name'] as String,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      status: json['status'] as String? ?? 'active',
      professionalProfile: (profileJson is Map<String, dynamic> && profileJson.isNotEmpty)
          ? ProfessionalProfile.fromJson(profileJson)
          : null,
    );
  }

  final int id;
  final UserRole role;
  final String name;
  final String? phone;
  final String? email;
  final String status;
  final ProfessionalProfile? professionalProfile;

  bool get isCustomer => role == UserRole.customer;
  bool get isProfessional => role == UserRole.professional;
}
