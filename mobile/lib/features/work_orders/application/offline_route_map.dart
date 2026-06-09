import '../../../domain/entities/work_order_route_stop.dart';
import 'work_order_route_optimizer.dart';

final class OfflineRouteMap {
  const OfflineRouteMap({
    required this.points,
    required this.unmappedStops,
    required this.bounds,
  });

  final List<OfflineRouteMapPoint> points;
  final List<WorkOrderRouteStop> unmappedStops;
  final OfflineRouteMapBounds bounds;

  bool get hasPolyline => points.length > 1;
}

final class OfflineRouteMapPoint {
  const OfflineRouteMapPoint({
    required this.sequence,
    required this.stop,
    required this.coordinate,
    required this.x,
    required this.y,
  });

  final int sequence;
  final WorkOrderRouteStop stop;
  final RouteCoordinate coordinate;
  final double x;
  final double y;
}

final class OfflineRouteMapBounds {
  const OfflineRouteMapBounds({
    required this.minLatitude,
    required this.maxLatitude,
    required this.minLongitude,
    required this.maxLongitude,
  });

  final double minLatitude;
  final double maxLatitude;
  final double minLongitude;
  final double maxLongitude;
}

final class OfflineRouteMapBuilder {
  const OfflineRouteMapBuilder();

  OfflineRouteMap build(OptimizedWorkOrderRoute route) {
    final mappedStops = <WorkOrderRouteStop>[];
    final unmappedStops = <WorkOrderRouteStop>[];
    for (final stop in route.stops) {
      if (stop.coordinate == null) {
        unmappedStops.add(stop);
      } else {
        mappedStops.add(stop);
      }
    }

    if (mappedStops.isEmpty) {
      throw StateError('No route stops with coordinates available.');
    }

    final coordinates = mappedStops
        .map((stop) => stop.coordinate!)
        .toList(growable: false);
    final bounds = _boundsFor(coordinates);
    final latitudeSpan = bounds.maxLatitude - bounds.minLatitude;
    final longitudeSpan = bounds.maxLongitude - bounds.minLongitude;

    final points = <OfflineRouteMapPoint>[];
    for (var index = 0; index < mappedStops.length; index += 1) {
      final stop = mappedStops[index];
      final coordinate = stop.coordinate!;
      points.add(
        OfflineRouteMapPoint(
          sequence: index + 1,
          stop: stop,
          coordinate: coordinate,
          x: (coordinate.longitude - bounds.minLongitude) / longitudeSpan,
          y: 1 - (coordinate.latitude - bounds.minLatitude) / latitudeSpan,
        ),
      );
    }

    return OfflineRouteMap(
      points: points,
      unmappedStops: unmappedStops,
      bounds: bounds,
    );
  }

  OfflineRouteMapBounds _boundsFor(List<RouteCoordinate> coordinates) {
    var minLatitude = coordinates.first.latitude;
    var maxLatitude = coordinates.first.latitude;
    var minLongitude = coordinates.first.longitude;
    var maxLongitude = coordinates.first.longitude;

    for (final coordinate in coordinates.skip(1)) {
      minLatitude = coordinate.latitude < minLatitude
          ? coordinate.latitude
          : minLatitude;
      maxLatitude = coordinate.latitude > maxLatitude
          ? coordinate.latitude
          : maxLatitude;
      minLongitude = coordinate.longitude < minLongitude
          ? coordinate.longitude
          : minLongitude;
      maxLongitude = coordinate.longitude > maxLongitude
          ? coordinate.longitude
          : maxLongitude;
    }

    if (minLatitude == maxLatitude) {
      minLatitude -= 0.001;
      maxLatitude += 0.001;
    }
    if (minLongitude == maxLongitude) {
      minLongitude -= 0.001;
      maxLongitude += 0.001;
    }

    return OfflineRouteMapBounds(
      minLatitude: minLatitude,
      maxLatitude: maxLatitude,
      minLongitude: minLongitude,
      maxLongitude: maxLongitude,
    );
  }
}
