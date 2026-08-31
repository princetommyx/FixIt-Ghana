import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/core_providers.dart';
import '../../data/models/service_request_summary.dart';
import '../../data/requests_repository.dart';

final requestsRepositoryProvider = Provider<RequestsRepository>((ref) {
  return RequestsRepository(ref.watch(apiClientProvider));
});

final requestsProvider = FutureProvider<List<ServiceRequestSummary>>((ref) {
  return ref.watch(requestsRepositoryProvider).list();
});
