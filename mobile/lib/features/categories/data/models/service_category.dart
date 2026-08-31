class ServiceCategory {
  const ServiceCategory({required this.id, required this.name, required this.slug, this.icon});

  factory ServiceCategory.fromJson(Map<String, dynamic> json) {
    return ServiceCategory(
      id: json['id'] as int,
      name: json['name'] as String,
      slug: json['slug'] as String,
      icon: json['icon'] as String?,
    );
  }

  final int id;
  final String name;
  final String slug;
  final String? icon;
}
