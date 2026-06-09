import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/error_state.dart';
import '../../../core/widgets/loading_skeleton.dart';
import '../../../domain/entities/work_order_route_stop.dart';
import '../../../l10n/app_localizations_x.dart';
import '../application/offline_route_map.dart';
import '../application/work_order_providers.dart';
import '../application/work_order_route_optimizer.dart';

class OfflineRouteMapScreen extends ConsumerWidget {
  const OfflineRouteMapScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routeStops = ref.watch(todayRouteStopsProvider);

    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.offlineRouteMapTitle)),
      body: SafeArea(
        child: routeStops.when(
          loading: () => const LoadingSkeleton(itemCount: 4),
          error: (error, stackTrace) => ErrorState(
            title: context.l10n.offlineRouteMapTitle,
            message: error.toString(),
            onRetry: () => ref.invalidate(todayRouteStopsProvider),
          ),
          data: (stops) {
            if (stops.isEmpty) {
              return EmptyState(
                icon: Icons.map_outlined,
                title: context.l10n.offlineRouteMapEmptyTitle,
                message: context.l10n.routeOptimizationNoStopsMessage,
              );
            }

            final route = const WorkOrderRouteOptimizer().plan(stops);
            OfflineRouteMap map;
            try {
              map = const OfflineRouteMapBuilder().build(route);
            } on StateError {
              return EmptyState(
                icon: Icons.location_off_outlined,
                title: context.l10n.offlineRouteMapNoCoordinatesTitle,
                message: context.l10n.offlineRouteMapNoCoordinatesMessage,
              );
            }

            return ListView(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.md,
                AppSpacing.lg,
                AppSpacing.xl,
              ),
              children: [
                Text(context.l10n.offlineRouteMapSubtitle(map.points.length)),
                const SizedBox(height: AppSpacing.lg),
                _OfflineRouteMapPanel(map: map),
                const SizedBox(height: AppSpacing.lg),
                _RouteStopList(points: map.points),
                if (map.unmappedStops.isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.lg),
                  _UnmappedStopList(stops: map.unmappedStops),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}

class _OfflineRouteMapPanel extends StatelessWidget {
  const _OfflineRouteMapPanel({required this.map});

  final OfflineRouteMap map;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
        borderRadius: BorderRadius.circular(8),
      ),
      child: AspectRatio(
        aspectRatio: 1.35,
        child: CustomPaint(
          key: const Key('offline-route-map-canvas'),
          painter: _OfflineRouteMapPainter(
            map: map,
            colorScheme: Theme.of(context).colorScheme,
          ),
        ),
      ),
    );
  }
}

class _RouteStopList extends StatelessWidget {
  const _RouteStopList({required this.points});

  final List<OfflineRouteMapPoint> points;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.offlineRouteMapStopsTitle,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: AppSpacing.sm),
        ...points.map(
          (point) => Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: ListTile(
              leading: CircleAvatar(child: Text('${point.sequence}')),
              title: Text(point.stop.workOrder.orderNumber),
              subtitle: Text(
                '${point.stop.object.name}\n${point.stop.address}\n'
                '${point.coordinate.latitude.toStringAsFixed(6)}, '
                '${point.coordinate.longitude.toStringAsFixed(6)}',
              ),
              isThreeLine: true,
            ),
          ),
        ),
      ],
    );
  }
}

class _UnmappedStopList extends StatelessWidget {
  const _UnmappedStopList({required this.stops});

  final List<WorkOrderRouteStop> stops;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.offlineRouteMapUnmappedTitle,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: AppSpacing.sm),
        ...stops.map(
          (stop) => ListTile(
            leading: const Icon(Icons.location_off_outlined),
            title: Text(stop.workOrder.orderNumber),
            subtitle: Text('${stop.object.name}\n${stop.address}'),
            isThreeLine: true,
          ),
        ),
      ],
    );
  }
}

class _OfflineRouteMapPainter extends CustomPainter {
  const _OfflineRouteMapPainter({required this.map, required this.colorScheme});

  final OfflineRouteMap map;
  final ColorScheme colorScheme;

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPaint = Paint()
      ..color = colorScheme.surfaceContainerHighest;
    final gridPaint = Paint()
      ..color = colorScheme.outlineVariant
      ..strokeWidth = 1;
    final routePaint = Paint()
      ..color = colorScheme.primary
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    canvas.drawRRect(
      RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(8)),
      backgroundPaint,
    );

    for (var step = 1; step < 4; step += 1) {
      final dx = size.width * step / 4;
      final dy = size.height * step / 4;
      canvas.drawLine(Offset(dx, 0), Offset(dx, size.height), gridPaint);
      canvas.drawLine(Offset(0, dy), Offset(size.width, dy), gridPaint);
    }

    final offsets = map.points.map((point) => _offset(point, size)).toList();
    if (offsets.length > 1) {
      final path = Path()..moveTo(offsets.first.dx, offsets.first.dy);
      for (final offset in offsets.skip(1)) {
        path.lineTo(offset.dx, offset.dy);
      }
      canvas.drawPath(path, routePaint);
    }

    for (var index = 0; index < offsets.length; index += 1) {
      _drawMarker(canvas, offsets[index], map.points[index]);
    }
  }

  Offset _offset(OfflineRouteMapPoint point, Size size) {
    const padding = 32.0;
    final width = (size.width - padding * 2).clamp(1.0, double.infinity);
    final height = (size.height - padding * 2).clamp(1.0, double.infinity);
    return Offset(padding + width * point.x, padding + height * point.y);
  }

  void _drawMarker(Canvas canvas, Offset offset, OfflineRouteMapPoint point) {
    final fillPaint = Paint()..color = colorScheme.primary;
    final strokePaint = Paint()
      ..color = colorScheme.surface
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    canvas
      ..drawCircle(offset, 15, fillPaint)
      ..drawCircle(offset, 15, strokePaint);

    final textPainter = TextPainter(
      text: TextSpan(
        text: '${point.sequence}',
        style: TextStyle(
          color: colorScheme.onPrimary,
          fontSize: 13,
          fontWeight: FontWeight.w800,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    textPainter.paint(
      canvas,
      offset - Offset(textPainter.width / 2, textPainter.height / 2),
    );
  }

  @override
  bool shouldRepaint(covariant _OfflineRouteMapPainter oldDelegate) {
    return oldDelegate.map != map || oldDelegate.colorScheme != colorScheme;
  }
}
