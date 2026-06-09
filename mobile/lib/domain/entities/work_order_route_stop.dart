import 'customer_object.dart';
import 'work_order.dart';

final class WorkOrderRouteStop {
  const WorkOrderRouteStop({required this.workOrder, required this.object});

  final WorkOrder workOrder;
  final CustomerObject object;

  String get address => object.addressLine;

  RouteCoordinate? get coordinate {
    final latitude = object.latitude;
    final longitude = object.longitude;
    if (latitude == null || longitude == null) {
      return null;
    }
    return RouteCoordinate(latitude: latitude, longitude: longitude);
  }

  String get mapsQuery {
    final point = coordinate;
    if (point == null) {
      return address;
    }
    return '${point.latitude.toStringAsFixed(6)},${point.longitude.toStringAsFixed(6)}';
  }
}

final class RouteCoordinate {
  const RouteCoordinate({required this.latitude, required this.longitude});

  final double latitude;
  final double longitude;
}
