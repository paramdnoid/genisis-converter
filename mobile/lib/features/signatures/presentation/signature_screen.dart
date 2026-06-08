import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:signature/signature.dart';
import 'package:uuid/uuid.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/files/file_storage_service.dart';
import '../../../data/db/database_providers.dart';
import '../../../domain/entities/photo_attachment.dart';
import '../../../l10n/app_localizations_x.dart';
import '../../photos/application/photo_providers.dart';
import '../../reports/application/pdf_report_generator.dart';
import '../../reports/application/report_data_aggregator.dart';
import '../../reports/application/report_providers.dart';
import '../../work_orders/application/work_order_providers.dart';

class SignatureScreen extends ConsumerStatefulWidget {
  const SignatureScreen({required this.workOrderId, super.key});

  final String workOrderId;

  @override
  ConsumerState<SignatureScreen> createState() => _SignatureScreenState();
}

class _SignatureScreenState extends ConsumerState<SignatureScreen> {
  final _nameController = TextEditingController();
  late final SignatureController _signatureController;

  @override
  void initState() {
    super.initState();
    _signatureController = SignatureController(
      penStrokeWidth: 3,
      penColor: Colors.black,
      exportBackgroundColor: Colors.white,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _signatureController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.signatureTitle)),
      body: SafeArea(
        child: ListView(
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
                    Text(
                      context.l10n.customerSignatureTitle,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: context.l10n.signerNameLabel,
                        prefixIcon: const Icon(Icons.person_outline),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Theme.of(context).colorScheme.outlineVariant,
                        ),
                      ),
                      child: SizedBox(
                        height: 240,
                        child: Signature(
                          controller: _signatureController,
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: _signatureController.clear,
                            icon: const Icon(Icons.clear),
                            label: Text(context.l10n.clearAction),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: _signatureController.undo,
                            icon: const Icon(Icons.undo),
                            label: Text(context.l10n.undoAction),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md),
                    FilledButton.icon(
                      onPressed: _save,
                      icon: const Icon(Icons.save_outlined),
                      label: Text(context.l10n.saveSignatureAction),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _save() async {
    if (_nameController.text.trim().isEmpty) {
      _showMessage('Name des Unterzeichners fehlt.');
      return;
    }
    if (_signatureController.isEmpty) {
      _showMessage('Signatur fehlt.');
      return;
    }

    final bytes = await _signatureController.toPngBytes();
    if (bytes == null) {
      _showMessage('Signatur konnte nicht exportiert werden.');
      return;
    }

    final tenantId = ref.read(activeTenantIdProvider);
    final fileName = 'signature-${const Uuid().v4()}.png';
    final stored = await const FileStorageService().writeBytesIntoWorkOrder(
      tenantId: tenantId,
      workOrderId: widget.workOrderId,
      bytes: bytes,
      fileName: fileName,
      mimeType: 'image/png',
    );
    final createPhoto = await ref.read(createPhotoProvider.future);
    final photoId = await createPhoto(
      PhotoDraft(
        workOrderId: widget.workOrderId,
        localPath: stored.path,
        fileName: stored.fileName,
        mimeType: stored.mimeType,
        sizeBytes: stored.sizeBytes,
        caption: 'Signatur ${_nameController.text.trim()}',
      ),
    );
    final database = await ref.read(databaseReadyProvider.future);
    await database.workOrderDao.attachSignatureLocal(
      id: widget.workOrderId,
      signatureFileId: photoId,
    );
    final data = await ReportDataAggregator(
      database: database,
      tenantId: tenantId,
    ).load(widget.workOrderId);
    if (data != null) {
      final storedReport = await const PdfReportGenerator().save(
        data: data,
        tenantId: tenantId,
        workOrderId: widget.workOrderId,
      );
      final createReport = await ref.read(createReportRecordProvider.future);
      await createReport(
        workOrderId: widget.workOrderId,
        reportNumber: 'R-${data.header.workOrder.orderNumber}-signed',
        pdfLocalPath: storedReport.path,
        customerNameSigned: _nameController.text.trim(),
        signed: true,
      );
      ref.invalidate(reportsForWorkOrderProvider(widget.workOrderId));
    }
    _showMessage('Signatur und finaler Rapport lokal gespeichert.');
  }

  void _showMessage(String message) {
    if (!mounted) {
      return;
    }
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}
