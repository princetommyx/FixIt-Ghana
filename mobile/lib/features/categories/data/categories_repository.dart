import '../../../core/network/api_client.dart';
import 'models/service_category.dart';

class CategoriesRepository {
  CategoriesRepository(this._client);

  final ApiClient _client;

  Future<List<ServiceCategory>> list() async {
    final response = await _client.get('/services/categories');
    final data = response.data['data'] as List<dynamic>;
    return data
        .map((json) => ServiceCategory.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
