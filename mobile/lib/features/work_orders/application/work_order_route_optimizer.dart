import 'dart:math' as math;

import '../../../domain/entities/work_order_route_stop.dart';

final class OptimizedWorkOrderRoute {
  const OptimizedWorkOrderRoute({
    required this.stops,
    required this.mapsUri,
    required this.optimizedByCoordinates,
  });

  final List<WorkOrderRouteStop> stops;
  final Uri mapsUri;
  final bool optimizedByCoordinates;
}

final class WorkOrderRouteOptimizer {
  const WorkOrderRouteOptimizer();

  OptimizedWorkOrderRoute plan(
    List<WorkOrderRouteStop> stops, {
    RouteCoordinate? origin,
  }) {
    if (stops.isEmpty) {
      throw ArgumentError.value(
        stops,
        'stops',
        'At least one stop is required.',
      );
    }

    final scheduled = _scheduledOrder(stops);
    final canOptimizeByCoordinates =
        scheduled.length > 1 &&
        scheduled.every((stop) => stop.coordinate != null) &&
        (origin != null || scheduled.first.coordinate != null);
    final ordered = canOptimizeByCoordinates
        ? _nearestNeighborOrder(scheduled, origin: origin)
        : scheduled;

    return OptimizedWorkOrderRoute(
      stops: ordered,
      mapsUri: _mapsUri(ordered, origin: origin),
      optimizedByCoordinates: canOptimizeByCoordinates,
    );
  }

  List<WorkOrderRouteStop> _nearestNeighborOrder(
    List<WorkOrderRouteStop> stops, {
    RouteCoordinate? origin,
  }) {
    final remaining = stops.toList();
    final ordered = <WorkOrderRouteStop>[];
    var current = origin;

    if (current == null) {
      final first = remaining.removeAt(0);
      ordered.add(first);
      current = first.coordinate;
    }

    while (remaining.isNotEmpty) {
      final currentPoint = current;
      if (currentPoint == null) {
        throw StateError('Route optimization requires a current coordinate.');
      }
      remaining.sort((left, right) {
        final leftDistance = _distanceMeters(currentPoint, left.coordinate!);
        final rightDistance = _distanceMeters(currentPoint, right.coordinate!);
        final distanceCompare = leftDistance.compareTo(rightDistance);
        if (distanceCompare != 0) {
          return distanceCompare;
        }
        return _compareSchedule(left, right);
      });

      final next = remaining.removeAt(0);
      ordered.add(next);
      current = next.coordinate;
    }

    return ordered;
  }

  List<WorkOrderRouteStop> _scheduledOrder(List<WorkOrderRouteStop> stops) {
    final sorted = stops.toList();
    sorted.sort(_compareSchedule);
    return sorted;
  }

  int _compareSchedule(WorkOrderRouteStop left, WorkOrderRouteStop right) {
    final leftStart = left.workOrder.scheduledStart;
    final rightStart = right.workOrder.scheduledStart;
    if (leftStart == null && rightStart != null) {
      return 1;
    }
    if (leftStart != null && rightStart == null) {
      return -1;
    }
    if (leftStart != null && rightStart != null) {
      final timeCompare = leftStart.compareTo(rightStart);
      if (timeCompare != 0) {
        return timeCompare;
      }
    }
    return left.workOrder.orderNumber.compareTo(right.workOrder.orderNumber);
  }

  double _distanceMeters(RouteCoordinate left, RouteCoordinate right) {
    const earthRadiusMeters = 6371000.0;
    final leftLat = _radians(left.latitude);
    final rightLat = _radians(right.latitude);
    final deltaLat = _radians(right.latitude - left.latitude);
    final deltaLng = _radians(right.longitude - left.longitude);
    final haversine =
        math.sin(deltaLat / 2) * math.sin(deltaLat / 2) +
        math.cos(leftLat) *
            math.cos(rightLat) *
            math.sin(deltaLng / 2) *
            math.sin(deltaLng / 2);
    final angularDistance =
        2 * math.atan2(math.sqrt(haversine), math.sqrt(1 - haversine));
    return earthRadiusMeters * angularDistance;
  }

  double _radians(double degrees) => degrees * math.pi / 180;

  Uri _mapsUri(List<WorkOrderRouteStop> stops, {RouteCoordinate? origin}) {
    final destination = stops.last.mapsQuery;
    final waypoints = stops.length == 1
        ? const <String>[]
        : stops.take(stops.length - 1).map((stop) => stop.mapsQuery).toList();
    final query = <String, String>{
      'api': '1',
      'travelmode': 'driving',
      'destination': destination,
      if (origin != null)
        'origin':
            '${origin.latitude.toStringAsFixed(6)},${origin.longitude.toStringAsFixed(6)}',
      if (waypoints.isNotEmpty) 'waypoints': waypoints.join('|'),
    };

    return Uri.https('www.google.com', '/maps/dir/', query);
  }
}
