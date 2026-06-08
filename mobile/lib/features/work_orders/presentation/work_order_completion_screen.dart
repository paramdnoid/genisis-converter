import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/routing/app_router.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/error_state.dart';
import '../../../core/widgets/loading_skeleton.dart';
import '../../../core/widgets/status_badge.dart';
import '../../../domain/use_cases/completion_validator.dart';
import '../application/work_order_providers.dart';

class WorkOrderCompletionScreen extends ConsumerWidget {
  const WorkOrderCompletionScreen({required this.workOrderId, super.key});

  final String workOrderId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(workOrderDetailProvider(workOrderId));

    return Scaffold(
      appBar: AppBar(title: const Text('Auftrag abschließen')),
      body: SafeArea(
        child: detail.when(
          loading: () => const LoadingSkeleton(itemCount: 4),
          error: (error, stackTrace) => ErrorState(
            title: 'Abschluss konnte nicht geladen werden',
            message: error.toString(),
            onRetry: () => ref.invalidate(workOrderDetailProvider(workOrderId)),
          ),
          data: (detail) {
            if (detail == null) {
              return const EmptyState(
                icon: Icons.assignment_late_outlined,
                title: 'Auftrag nicht gefunden',
                message: 'Der lokale Auftrag ist nicht vorhanden.',
              );
            }
            final result = const CompletionValidator().validate(detail);
            return ListView(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.md,
                AppSpacing.lg,
                AppSpacing.xl,
              ),
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Abschlussprüfung',
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(fontWeight: FontWeight.w800),
                              ),
                            ),
                            StatusBadge(
                              label: result.canComplete ? 'Bereit' : 'Offen',
                              icon: result.canComplete
                                  ? Icons.task_alt
                                  : Icons.warning_amber,
                              tone: result.canComplete
                                  ? StatusBadgeTone.success
                                  : StatusBadgeTone.warning,
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.md),
                        if (result.missingItems.isEmpty)
                          const Text(
                            'Alle lokalen Mindestdaten sind vorhanden.',
                          )
                        else
                          ...result.missingItems.map(
                            (item) => Padding(
                              padding: const EdgeInsets.only(
                                bottom: AppSpacing.xs,
                              ),
                              child: Text('- $item'),
                            ),
                          ),
                        const SizedBox(height: AppSpacing.lg),
                        Wrap(
                          spacing: AppSpacing.sm,
                          runSpacing: AppSpacing.sm,
                          children: [
                            ActionChip(
                              avatar: const Icon(Icons.draw, size: 18),
                              label: const Text('Signatur'),
                              onPressed: () => context.push(
                                AppRoutes.workOrderSignaturePath(workOrderId),
                              ),
                            ),
                            ActionChip(
                              avatar: const Icon(
                                Icons.picture_as_pdf_outlined,
                                size: 18,
                              ),
                              label: const Text('Bericht'),
                              onPressed: () => context.push(
                                AppRoutes.workOrderReportPath(workOrderId),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        FilledButton.icon(
                          onPressed: result.canComplete
                              ? () async {
                                  final complete = await ref.read(
                                    completeWorkOrderProvider.future,
                                  );
                                  await complete(workOrderId);
                                  if (context.mounted) {
                                    context.go(
                                      AppRoutes.workOrderDetailPath(
                                        workOrderId,
                                      ),
                                    );
                                  }
                                }
                              : null,
                          icon: const Icon(Icons.task_alt),
                          label: const Text('Lokal abschließen'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
