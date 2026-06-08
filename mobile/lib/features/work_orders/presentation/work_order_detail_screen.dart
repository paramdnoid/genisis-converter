import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/routing/app_router.dart';
import '../../../core/errors/app_error.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/error_state.dart';
import '../../../core/widgets/loading_skeleton.dart';
import '../../../core/widgets/status_badge.dart';
import '../../../domain/entities/installation.dart';
import '../../../domain/entities/work_order_detail.dart';
import '../../../domain/enums/work_order_status.dart';
import '../application/work_order_providers.dart';

class WorkOrderDetailScreen extends ConsumerWidget {
  const WorkOrderDetailScreen({required this.workOrderId, super.key});

  final String workOrderId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(workOrderDetailProvider(workOrderId));

    return Scaffold(
      appBar: AppBar(title: const Text('Auftragsdetail')),
      body: SafeArea(
        child: detail.when(
          loading: () => const LoadingSkeleton(itemCount: 4),
          error: (error, stackTrace) => ErrorState(
            title: 'Auftrag konnte nicht geladen werden',
            message: error.toString(),
            onRetry: () => ref.invalidate(workOrderDetailProvider(workOrderId)),
          ),
          data: (detail) {
            if (detail == null) {
              return const EmptyState(
                icon: Icons.assignment_late_outlined,
                title: 'Auftrag nicht gefunden',
                message: 'Der lokale Datensatz ist nicht vorhanden.',
              );
            }

            return _DetailContent(detail: detail);
          },
        ),
      ),
    );
  }
}

class _DetailContent extends ConsumerWidget {
  const _DetailContent({required this.detail});

  final WorkOrderDetail detail;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        AppSpacing.xl,
      ),
      children: [
        _HeaderCard(detail: detail),
        const SizedBox(height: AppSpacing.lg),
        _ActionGrid(detail: detail),
        const SizedBox(height: AppSpacing.lg),
        _CustomerCard(detail: detail),
        const SizedBox(height: AppSpacing.lg),
        _ObjectCard(detail: detail),
        const SizedBox(height: AppSpacing.lg),
        _InstallationList(installations: detail.installations),
        const SizedBox(height: AppSpacing.lg),
        _WorkflowShortcuts(orderId: detail.workOrder.id),
      ],
    );
  }
}

class _HeaderCard extends StatelessWidget {
  const _HeaderCard({required this.detail});

  final WorkOrderDetail detail;

  @override
  Widget build(BuildContext context) {
    final order = detail.workOrder;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    order.title,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                _WorkOrderStatusBadge(status: order.status),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(order.orderNumber),
            const SizedBox(height: AppSpacing.md),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                StatusBadge(
                  label: _formattedAppointment(order.scheduledStart),
                  icon: Icons.event,
                ),
                StatusBadge(
                  label: order.priority.label,
                  icon: Icons.flag_outlined,
                  tone:
                      order.priority == WorkOrderPriority.high ||
                          order.priority == WorkOrderPriority.urgent
                      ? StatusBadgeTone.warning
                      : StatusBadgeTone.neutral,
                ),
                if (order.isDirty)
                  const StatusBadge(
                    label: 'Lokal geändert',
                    icon: Icons.cloud_upload_outlined,
                    tone: StatusBadgeTone.warning,
                  ),
              ],
            ),
            if (order.description != null) ...[
              const SizedBox(height: AppSpacing.md),
              Text(order.description!),
            ],
            if (order.actualStart != null || order.actualEnd != null) ...[
              const SizedBox(height: AppSpacing.md),
              Text(
                'Ist-Zeit: ${_formattedTime(order.actualStart)} - ${_formattedTime(order.actualEnd)}',
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ActionGrid extends ConsumerWidget {
  const _ActionGrid({required this.detail});

  final WorkOrderDetail detail;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final order = detail.workOrder;

    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth >= 560 ? 3 : 2;

        return GridView.count(
          crossAxisCount: columns,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: AppSpacing.md,
          mainAxisSpacing: AppSpacing.md,
          childAspectRatio: columns == 3 ? 2.8 : 2.35,
          children: [
            _ActionButton(
              icon: Icons.navigation_outlined,
              label: 'Navigation',
              onPressed: () => _openMaps(context, detail),
            ),
            _ActionButton(
              icon: Icons.call_outlined,
              label: 'Anrufen',
              onPressed: detail.hasPhone
                  ? () => _callCustomer(context, detail)
                  : null,
            ),
            _ActionButton(
              icon: Icons.play_arrow,
              label: 'Starten',
              onPressed: order.status.canStart
                  ? () => _runAction(context, () async {
                      final useCase = await ref.read(
                        startWorkOrderProvider.future,
                      );
                      await useCase(order.id);
                    })
                  : null,
            ),
            _ActionButton(
              icon: Icons.pause,
              label: 'Pausieren',
              onPressed: order.status.canPause
                  ? () => _runAction(context, () async {
                      final useCase = await ref.read(
                        pauseWorkOrderProvider.future,
                      );
                      await useCase(order.id);
                    })
                  : null,
            ),
            _ActionButton(
              icon: Icons.replay,
              label: 'Fortsetzen',
              onPressed: order.status.canResume
                  ? () => _runAction(context, () async {
                      final useCase = await ref.read(
                        resumeWorkOrderProvider.future,
                      );
                      await useCase(order.id);
                    })
                  : null,
            ),
            _ActionButton(
              icon: Icons.task_alt,
              label: 'Abschließen',
              onPressed: order.status.canComplete
                  ? () =>
                        context.push(AppRoutes.workOrderCompletePath(order.id))
                  : null,
            ),
          ],
        );
      },
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis),
    );
  }
}

class _CustomerCard extends StatelessWidget {
  const _CustomerCard({required this.detail});

  final WorkOrderDetail detail;

  @override
  Widget build(BuildContext context) {
    final customer = detail.customer;

    return _SectionCard(
      title: 'Kunde',
      icon: Icons.person_outline,
      children: [
        _InfoRow(label: 'Name', value: customer.displayName),
        _InfoRow(label: 'Telefon', value: customer.preferredPhone ?? '-'),
        _InfoRow(label: 'E-Mail', value: customer.email ?? '-'),
        if (customer.notes != null)
          _InfoRow(label: 'Notizen', value: customer.notes!),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton.icon(
            onPressed: () =>
                context.push(AppRoutes.customerDetailPath(customer.id)),
            icon: const Icon(Icons.open_in_new),
            label: const Text('Kunde öffnen'),
          ),
        ),
      ],
    );
  }
}

class _ObjectCard extends StatelessWidget {
  const _ObjectCard({required this.detail});

  final WorkOrderDetail detail;

  @override
  Widget build(BuildContext context) {
    final object = detail.object;

    return _SectionCard(
      title: 'Objekt',
      icon: Icons.home_work_outlined,
      children: [
        _InfoRow(label: 'Name', value: object.name),
        _InfoRow(label: 'Adresse', value: object.addressLine),
        if (object.accessNotes != null)
          _InfoRow(label: 'Zugang', value: object.accessNotes!),
        if (object.safetyNotes != null)
          _InfoRow(label: 'Sicherheit', value: object.safetyNotes!),
        if (object.objectNotes != null)
          _InfoRow(label: 'Notizen', value: object.objectNotes!),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton.icon(
            onPressed: () =>
                context.push(AppRoutes.objectDetailPath(object.id)),
            icon: const Icon(Icons.open_in_new),
            label: const Text('Objekt öffnen'),
          ),
        ),
      ],
    );
  }
}

class _InstallationList extends StatelessWidget {
  const _InstallationList({required this.installations});

  final List<Installation> installations;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Anlagen',
      icon: Icons.fireplace_outlined,
      children: installations.isEmpty
          ? const [Text('Keine Anlagen verknüpft.')]
          : installations
                .map((installation) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () => context.push(
                            AppRoutes.installationDetailPath(installation.id),
                          ),
                          child: Text(
                            installation.displayName,
                            style: Theme.of(context).textTheme.titleSmall
                                ?.copyWith(fontWeight: FontWeight.w800),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          [
                            installation.locationDescription,
                            installation.fuelType,
                            installation.serialNumber == null
                                ? null
                                : 'SN ${installation.serialNumber}',
                          ].whereType<String>().join(' · '),
                        ),
                        if (installation.notes != null) ...[
                          const SizedBox(height: AppSpacing.xs),
                          Text(installation.notes!),
                        ],
                      ],
                    ),
                  );
                })
                .toList(growable: false),
    );
  }
}

class _WorkflowShortcuts extends StatelessWidget {
  const _WorkflowShortcuts({required this.orderId});

  final String orderId;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Bearbeitung',
      icon: Icons.build_circle_outlined,
      children: [
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            ActionChip(
              avatar: const Icon(Icons.checklist, size: 18),
              label: const Text('Checkliste'),
              onPressed: () =>
                  context.push(AppRoutes.workOrderChecklistPath(orderId)),
            ),
            ActionChip(
              avatar: const Icon(Icons.monitor_heart_outlined, size: 18),
              label: const Text('Messungen'),
              onPressed: () =>
                  context.push(AppRoutes.workOrderMeasurementsPath(orderId)),
            ),
            ActionChip(
              avatar: const Icon(Icons.report_problem_outlined, size: 18),
              label: const Text('Mängel'),
              onPressed: () =>
                  context.push(AppRoutes.workOrderDefectsPath(orderId)),
            ),
            ActionChip(
              avatar: const Icon(Icons.photo_camera_outlined, size: 18),
              label: const Text('Fotos'),
              onPressed: () =>
                  context.push(AppRoutes.workOrderPhotosPath(orderId)),
            ),
            ActionChip(
              avatar: const Icon(Icons.timer_outlined, size: 18),
              label: const Text('Zeiten'),
              onPressed: () =>
                  context.push(AppRoutes.workOrderTimePath(orderId)),
            ),
            ActionChip(
              avatar: const Icon(Icons.inventory_2_outlined, size: 18),
              label: const Text('Material'),
              onPressed: () =>
                  context.push(AppRoutes.workOrderMaterialsPath(orderId)),
            ),
            ActionChip(
              avatar: const Icon(Icons.picture_as_pdf_outlined, size: 18),
              label: const Text('Bericht'),
              onPressed: () =>
                  context.push(AppRoutes.workOrderReportPath(orderId)),
            ),
            ActionChip(
              avatar: const Icon(Icons.draw, size: 18),
              label: const Text('Signatur'),
              onPressed: () =>
                  context.push(AppRoutes.workOrderSignaturePath(orderId)),
            ),
          ],
        ),
      ],
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.icon,
    required this.children,
  });

  final String title;
  final IconData icon;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            ...children,
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 96,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}

class _WorkOrderStatusBadge extends StatelessWidget {
  const _WorkOrderStatusBadge({required this.status});

  final WorkOrderStatus status;

  @override
  Widget build(BuildContext context) {
    return StatusBadge(
      label: status.label,
      icon: switch (status) {
        WorkOrderStatus.completed || WorkOrderStatus.synced => Icons.task_alt,
        WorkOrderStatus.inProgress => Icons.construction,
        WorkOrderStatus.paused => Icons.pause_circle,
        WorkOrderStatus.cancelled => Icons.cancel_outlined,
        _ => Icons.schedule,
      },
      tone: switch (status) {
        WorkOrderStatus.completed ||
        WorkOrderStatus.synced => StatusBadgeTone.success,
        WorkOrderStatus.inProgress ||
        WorkOrderStatus.paused => StatusBadgeTone.warning,
        WorkOrderStatus.cancelled => StatusBadgeTone.error,
        _ => StatusBadgeTone.neutral,
      },
    );
  }
}

Future<void> _runAction(
  BuildContext context,
  Future<void> Function() action,
) async {
  try {
    await action();
  } on AppError catch (error) {
    if (!context.mounted) {
      return;
    }

    final missingItems = error.metadata['missingItems'];
    final suffix = missingItems is List
        ? '\n${missingItems.whereType<String>().join('\n')}'
        : '';
    _showMessage(context, '${error.userMessage}$suffix');
  } catch (error) {
    if (context.mounted) {
      _showMessage(context, error.toString());
    }
  }
}

Future<void> _openMaps(BuildContext context, WorkOrderDetail detail) async {
  final uri = Uri.https('www.google.com', '/maps/search/', {
    'api': '1',
    'query': detail.object.addressLine,
  });

  await _launchExternal(
    context,
    uri,
    'Navigation konnte nicht geöffnet werden.',
  );
}

Future<void> _callCustomer(BuildContext context, WorkOrderDetail detail) async {
  final phone = detail.primaryPhone.replaceAll(RegExp(r'\s+'), '');
  final uri = Uri(scheme: 'tel', path: phone);

  await _launchExternal(context, uri, 'Anruf konnte nicht gestartet werden.');
}

Future<void> _launchExternal(
  BuildContext context,
  Uri uri,
  String errorMessage,
) async {
  final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
  if (!launched && context.mounted) {
    _showMessage(context, errorMessage);
  }
}

void _showMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}

String _formattedAppointment(DateTime? value) {
  if (value == null) {
    return 'ohne Termin';
  }

  return DateFormat('dd.MM.yyyy HH:mm').format(value.toLocal());
}

String _formattedTime(DateTime? value) {
  if (value == null) {
    return '--:--';
  }

  return DateFormat('HH:mm').format(value.toLocal());
}
