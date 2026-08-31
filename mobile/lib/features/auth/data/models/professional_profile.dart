class ProfessionalProfile {
  const ProfessionalProfile({
    required this.id,
    required this.verificationStatus,
    required this.isVerified,
    required this.rating,
    required this.ratingCount,
    required this.completedJobsCount,
    this.businessName,
    this.bio,
    this.serviceArea,
  });

  factory ProfessionalProfile.fromJson(Map<String, dynamic> json) {
    return ProfessionalProfile(
      id: json['id'] as int,
      verificationStatus: json['verification_status'] as String? ?? 'unsubmitted',
      isVerified: json['is_verified'] as bool? ?? false,
      rating: (json['rating'] as num?)?.toDouble() ?? 0,
      ratingCount: json['rating_count'] as int? ?? 0,
      completedJobsCount: json['completed_jobs_count'] as int? ?? 0,
      businessName: json['business_name'] as String?,
      bio: json['bio'] as String?,
      serviceArea: json['service_area'] as String?,
    );
  }

  final int id;
  final String verificationStatus;
  final bool isVerified;
  final double rating;
  final int ratingCount;
  final int completedJobsCount;
  final String? businessName;
  final String? bio;
  final String? serviceArea;

  bool get isPending => verificationStatus == 'pending';
  bool get isUnsubmitted => verificationStatus == 'unsubmitted';
  bool get isRejected => verificationStatus == 'rejected';
}
