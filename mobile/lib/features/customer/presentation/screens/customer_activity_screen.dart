import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/empty_view.dart';
import '../../../../shared/widgets/error_view.dart';
import '../../../../shared/widgets/loading_view.dart';
import '../../../requests/data/models/service_request_summary.dart';
import '../../../requests/presentation/providers/requests_provider.dart';

class CustomerActivityScreen extends ConsumerWidget {
  const CustomerActivityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final requestsAsync = ref.watch(requestsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Activity')),
      body: requestsAsync.when(
        loading: () => const LoadingView(),
        error: (error, _) => ErrorView(
          message: 'Could not load your requests.',
          onRetry: () => ref.invalidate(requestsProvider),
        ),
        data: (requests) {
          if (requests.isEmpty) {
            return const EmptyView(
              icon: Icons.assignment_outlined,
              title: 'No requests yet',
              message: 'Requests you post will show up here.',
            );
          }

          return RefreshIndicator(
            onRefresh: () => ref.refresh(requestsProvider.future),
            child: ListView.separated(
              padding: const EdgeInsets.all(AppSpacing.lg),
              itemCount: requests.length,
              separatorBuilder: (context, index) => const SizedBox(height: AppSpacing.md),
              itemBuilder: (context, index) => _RequestCard(request: requests[index]),
            ),
          );
        },
      ),
    );
  }
}

class _RequestCard extends StatelessWidget {
  const _RequestCard({required this.request});

  final ServiceRequestSummary request;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadii.mdRadius,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(request.categoryName, style: AppTypography.bodyStrong),
              ),
              _StatusBadge(status: request.status),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            request.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.caption,
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Text(DateFormat.yMMMd().format(request.createdAt), style: AppTypography.caption),
              if (request.quotesCount > 0) ...[
                const SizedBox(width: AppSpacing.md),
                Text(
                  '${request.quotesCount} quote${request.quotesCount == 1 ? '' : 's'}',
                  style: AppTypography.caption.copyWith(color: AppColors.primary, fontWeight: FontWeight.w600),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});

  final String status;

  Color get _color {
    switch (status) {
      case 'completed':
        return AppColors.primary;
      case 'cancelled':
        return AppColors.error;
      case 'hired':
        return AppColors.info;
      case 'quoted':
        return AppColors.warning;
      default:
        return AppColors.textSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 2),
      decoration: BoxDecoration(
        color: _color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        status[0].toUpperCase() + status.substring(1),
        style: AppTypography.caption.copyWith(color: _color, fontWeight: FontWeight.w600),
      ),
    );
  }
}
