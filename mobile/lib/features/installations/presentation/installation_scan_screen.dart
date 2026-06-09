import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/routing/app_router.dart';
import '../../../l10n/app_localizations_x.dart';
import '../application/installation_providers.dart';

class InstallationScanScreen extends ConsumerStatefulWidget {
  const InstallationScanScreen({super.key});

  @override
  ConsumerState<InstallationScanScreen> createState() =>
      _InstallationScanScreenState();
}

class _InstallationScanScreenState
    extends ConsumerState<InstallationScanScreen> {
  final _manualController = TextEditingController();
  final _scannerController = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
  );
  bool _isResolving = false;
  String? _lastMissedCode;

  @override
  void dispose() {
    _manualController.dispose();
    _scannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.installationScanTitle)),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    MobileScanner(
                      controller: _scannerController,
                      onDetect: _onDetect,
                      errorBuilder: (context, error) => _ScannerFallback(
                        message: context.l10n.installationScanCameraError,
                      ),
                    ),
                    const _ScanFrame(),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            TextField(
              controller: _manualController,
              decoration: InputDecoration(
                labelText: context.l10n.installationScanManualLabel,
                prefixIcon: const Icon(Icons.qr_code_scanner_outlined),
              ),
              textInputAction: TextInputAction.search,
              onSubmitted: _resolveCode,
            ),
            const SizedBox(height: AppSpacing.md),
            FilledButton.icon(
              onPressed: _isResolving
                  ? null
                  : () => _resolveCode(_manualController.text),
              icon: const Icon(Icons.search_outlined),
              label: Text(context.l10n.installationScanManualAction),
            ),
            if (_lastMissedCode != null) ...[
              const SizedBox(height: AppSpacing.md),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: Theme.of(context).colorScheme.error,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Text(
                          context.l10n.installationScanNoMatchMessage(
                            _lastMissedCode!,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _onDetect(BarcodeCapture capture) {
    if (_isResolving) {
      return;
    }

    String? value;
    for (final barcode in capture.barcodes) {
      value = barcode.rawValue ?? barcode.displayValue;
      if (value != null && value.trim().isNotEmpty) {
        break;
      }
    }
    if (value == null) {
      return;
    }

    _resolveCode(value);
  }

  Future<void> _resolveCode(String rawCode) async {
    final code = rawCode.trim();
    if (code.isEmpty || _isResolving) {
      return;
    }

    setState(() {
      _isResolving = true;
      _lastMissedCode = null;
    });

    final match = await ref.read(installationScanMatchProvider(code).future);
    if (!mounted) {
      return;
    }

    if (match == null) {
      setState(() {
        _isResolving = false;
        _lastMissedCode = code;
      });
      return;
    }

    context.go(AppRoutes.installationDetailPath(match.installation.id));
  }
}

class _ScanFrame extends StatelessWidget {
  const _ScanFrame();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
          width: 3,
        ),
      ),
      child: Center(
        child: Container(
          width: 220,
          height: 220,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 3),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}

class _ScannerFallback extends StatelessWidget {
  const _ScannerFallback({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.black,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
