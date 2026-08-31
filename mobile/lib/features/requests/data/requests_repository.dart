import '../../../core/network/api_client.dart';
import 'models/service_request_summary.dart';

class RequestsRepository {
  RequestsRepository(this._client);

  final ApiClient _client;

  Future<List<ServiceRequestSummary>> list() async {
    final response = await _client.get('/requests');
    final data = response.data['data'] as List<dynamic>;
    return data
        .map((json) => ServiceRequestSummary.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
