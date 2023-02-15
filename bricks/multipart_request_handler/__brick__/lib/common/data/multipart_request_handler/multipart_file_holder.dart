import 'package:http_parser/src/media_type.dart';

class MultipartFileHolder {
  /// The size of the file in bytes.
  final int length;

  /// The basename of the file.
  final String? filename;

  /// The content-type of the file.
  final MediaType? contentType;

  /// The stream that will emit the file's contents.
  final Stream<List<int>> stream;

  MultipartFileHolder({
    required this.length,
    required this.filename,
    required this.contentType,
    required this.stream,
  });
}
