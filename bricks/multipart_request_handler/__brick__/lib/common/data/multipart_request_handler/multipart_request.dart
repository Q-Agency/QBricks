import 'dart:async';

import 'package:http/http.dart' as http;

class MultipartRequest extends http.MultipartRequest {
  http.Client client = http.Client();
  final void Function(int bytes, int totalBytes)? onProgress;

  MultipartRequest(
    super.method,
    super.url, {
    this.onProgress,
  });

  void cancel() => client.close();

  @override
  Future<http.StreamedResponse> send() async {
    try {
      final response = await client.send(this);
      final stream = onDone(response.stream, client.close);
      return http.StreamedResponse(
        http.ByteStream(stream),
        response.statusCode,
        contentLength: response.contentLength,
        request: response.request,
        headers: response.headers,
        isRedirect: response.isRedirect,
        persistentConnection: response.persistentConnection,
        reasonPhrase: response.reasonPhrase,
      );
    } catch (_) {
      client.close();
      rethrow;
    }
  }

  Stream<T> onDone<T>(Stream<T> stream, void Function() onDone) =>
      stream.transform(
        StreamTransformer.fromHandlers(
          handleDone: (sink) {
            sink.close();
            onDone();
          },
        ),
      );

  /// Freezes all mutable fields and returns a single-subscription [ByteStream]
  /// that will emit the request body.
  @override
  http.ByteStream finalize() {
    final byteStream = super.finalize();
    if (onProgress == null) return byteStream;

    final total = contentLength;
    var bytes = 0;

    final transformer = StreamTransformer.fromHandlers(
      handleData: (List<int> data, EventSink<List<int>> sink) {
        bytes += data.length;
        if (onProgress != null) {
          // ignore: prefer_null_aware_method_calls, avoid-non-null-assertion
          onProgress!(bytes, total);
        }
        sink.add(data);
      },
    );
    final stream = byteStream.transform(transformer);
    return http.ByteStream(stream);
  }
}
