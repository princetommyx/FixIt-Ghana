class ServiceRequestSummary {
  const ServiceRequestSummary({
    required this.id,
    required this.categoryName,
    required this.description,
    required this.status,
    required this.createdAt,
    this.quotesCount = 0,
  });

  factory ServiceRequestSummary.fromJson(Map<String, dynamic> json) {
    final category = json['category'] as Map<String, dynamic>?;

    return ServiceRequestSummary(
      id: json['id'] as int,
      categoryName: category?['name'] as String? ?? 'Service request',
      description: json['description'] as String? ?? '',
      status: json['status'] as String? ?? 'open',
      createdAt: DateTime.tryParse(json['created_at'] as String? ?? '') ?? DateTime.now(),
      quotesCount: json['quotes_count'] as int? ?? 0,
    );
  }

  final int id;
  final String categoryName;
  final String description;
  final String status;
  final DateTime createdAt;
  final int quotesCount;
}
