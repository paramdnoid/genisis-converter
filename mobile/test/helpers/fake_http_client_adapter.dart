import 'dart:async';
import 'dart:typed_data';

import 'package:dio/dio.dart';

final jsonHeaders = {
  Headers.contentTypeHeader: [Headers.jsonContentType],
};

final class FakeHttpClientAdapter implements HttpClientAdapter {
  FakeHttpClientAdapter(this._handler);

  final FutureOr<ResponseBody> Function(RequestOptions options) _handler;
  final requests = <RequestOptions>[];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requests.add(options);
    return _handler(options);
  }

  @override
  void close({bool force = false}) {}
}
