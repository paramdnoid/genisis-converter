import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:printing/printing.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/error_state.dart';
import '../../../core/widgets/loading_skeleton.dart';
import '../../../core/widgets/status_badge.dart';
import '../../../data/db/database_providers.dart';
import '../../../domain/entities/report.dart';
import '../../work_orders/application/work_order_providers.dart';
import '../application/pdf_report_generator.dart';
import '../application/report_data_aggregator.dart';
import '../application/report_providers.dart';

final reportPreviewBytesProvider = FutureProvider.autoDispose
    .family<Uint8List?, String>((ref, workOrderId) async {
      final database = await ref.watch(databaseReadyProvider.future);
      final tenantId = ref.watch(activeTenantIdProvider);
      final data = await ReportDataAggregator(
        database: database,
        tenantId: tenantId,
      ).load(workOrderId);
      if (data == null) {
        return null;
      }
      return const PdfReportGenerator().generateBytes(data);
    });

class ReportScreen extends ConsumerWidget {
  const ReportScreen({required this.workOrderId, super.key});

  final String workOrderId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reports = ref.watch(reportsForWorkOrderProvider(workOrderId));
    final preview = ref.watch(reportPreviewBytesProvider(workOrderId));

    return Scaffold(
      appBar: AppBar(title: const Text('Rapport')),
      body: SafeArea(
        child: reports.when(
          loading: () => const LoadingSkeleton(itemCount: 4),
          error: (error, stackTrace) => ErrorState(
            title: 'Rapporte konnten nicht geladen werden',
            message: error.toString(),
            onRetry: () =>
                ref.invalidate(reportsForWorkOrderProvider(workOrderId)),
          ),
          data: (reports) => ListView(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.md,
              AppSpacing.lg,
              AppSpacing.xl,
            ),
            children: [
              _ReportActions(workOrderId: workOrderId),
              const SizedBox(height: AppSpacing.lg),
              _PreviewCard(preview: preview),
              const SizedBox(height: AppSpacing.lg),
              Text(
                'Lokale Rapportdateien',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: AppSpacing.md),
              if (reports.isEmpty)
                const EmptyState(
                  icon: Icons.picture_as_pdf_outlined,
                  title: 'Noch kein PDF erzeugt',
                  message: 'Der Rapport kann offline generiert werden.',
                )
              else
                ...reports.map(
                  (report) => Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.md),
                    child: _ReportCard(report: report),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReportActions extends ConsumerWidget {
  const _ReportActions({required this.workOrderId});

  final String workOrderId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'PDF-Bericht',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: AppSpacing.sm),
            const Text(
              'Rapportdaten werden aus der lokalen Datenbank geladen.',
            ),
            const SizedBox(height: AppSpacing.lg),
            FilledButton.icon(
              onPressed: () => _generate(context, ref),
              icon: const Icon(Icons.picture_as_pdf_outlined),
              label: const Text('PDF lokal speichern'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _generate(BuildContext context, WidgetRef ref) async {
    final database = await ref.read(databaseReadyProvider.future);
    final tenantId = ref.read(activeTenantIdProvider);
    final data = await ReportDataAggregator(
      database: database,
      tenantId: tenantId,
    ).load(workOrderId);
    if (data == null) {
      return;
    }

    final stored = await const PdfReportGenerator().save(
      data: data,
      tenantId: tenantId,
      workOrderId: workOrderId,
    );
    final create = await ref.read(createReportRecordProvider.future);
    await create(
      workOrderId: workOrderId,
      reportNumber: 'R-${data.header.workOrder.orderNumber}',
      pdfLocalPath: stored.path,
    );
    ref.invalidate(reportPreviewBytesProvider(workOrderId));
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('PDF lokal gespeichert.')));
    }
  }
}

class _PreviewCard extends StatelessWidget {
  const _PreviewCard({required this.preview});

  final AsyncValue<Uint8List?> preview;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: SizedBox(
          height: 420,
          child: preview.when(
            loading: () => const LoadingSkeleton(itemCount: 3),
            error: (error, stackTrace) => ErrorState(
              title: 'Vorschau konnte nicht erstellt werden',
              message: error.toString(),
            ),
            data: (bytes) {
              if (bytes == null) {
                return const EmptyState(
                  icon: Icons.picture_as_pdf_outlined,
                  title: 'Keine Vorschau',
                  message: 'Der Auftrag ist lokal nicht vorhanden.',
                );
              }
              return PdfPreview(
                build: (_) async => bytes,
                canChangeOrientation: false,
                canChangePageFormat: false,
                canDebug: false,
              );
            },
          ),
        ),
      ),
    );
  }
}

class _ReportCard extends StatelessWidget {
  const _ReportCard({required this.report});

  final ReportRecord report;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Row(
          children: [
            const Icon(Icons.picture_as_pdf_outlined),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    report.reportNumber,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(report.pdfLocalPath ?? '-'),
                ],
              ),
            ),
            StatusBadge(
              label: report.status,
              icon: report.isSigned ? Icons.verified : Icons.edit_document,
              tone: report.isSigned
                  ? StatusBadgeTone.success
                  : StatusBadgeTone.warning,
            ),
          ],
        ),
      ),
    );
  }
}
