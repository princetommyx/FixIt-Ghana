import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/core_providers.dart';
import '../../data/categories_repository.dart';
import '../../data/models/service_category.dart';

final categoriesRepositoryProvider = Provider<CategoriesRepository>((ref) {
  return CategoriesRepository(ref.watch(apiClientProvider));
});

final categoriesProvider = FutureProvider<List<ServiceCategory>>((ref) {
  return ref.watch(categoriesRepositoryProvider).list();
});
