import 'package:connectivity_plus/connectivity_plus.dart';

final class NetworkMonitor {
  NetworkMonitor({Connectivity? connectivity})
    : _connectivity = connectivity ?? Connectivity();

  final Connectivity _connectivity;

  Stream<bool> get isOnline async* {
    try {
      await for (final results in _connectivity.onConnectivityChanged) {
        yield _hasConnection(results);
      }
    } catch (_) {
      yield false;
    }
  }

  Future<bool> checkNow() async {
    try {
      return _hasConnection(await _connectivity.checkConnectivity());
    } catch (_) {
      return false;
    }
  }

  bool _hasConnection(List<ConnectivityResult> results) {
    return results.any(
      (result) =>
          result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi ||
          result == ConnectivityResult.ethernet ||
          result == ConnectivityResult.vpn,
    );
  }
}
