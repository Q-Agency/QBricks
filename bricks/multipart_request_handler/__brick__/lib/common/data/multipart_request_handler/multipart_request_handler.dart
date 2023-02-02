// ignore_for_file: prefer-correct-identifier-length, avoid-non-null-assertion
import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:{{project_name.snakeCase()}}/common/data/multipart_request_handler/multipart_request.dart';
import 'package:{{project_name.snakeCase()}}/common/data/multipart_request_handler/multipart_file_holder.dart';

final multipartRequestHandlerProvider = Provider<MultipartRequestHandler>(
  (_) => MultipartRequestHandlerImpl(),
);

abstract class MultipartRequestHandler {
  /// Sends out a multipart request to the given [uri] with [body] and [headers].
  ///
  /// Body can contain a normal json file structure, except that the file you are sending needs to be on the top of the hierarchy, it's
  /// key can be any [String] you need, but the value needs to be a [MultipartFileHolder].
  ///
  /// Example of body, where [XFile] is received from the image picker and uploaded using multipart.
  /// ```dart
  /// {
  /// 'file': MultipartFileHolder(
  ///         stream: xfile.openRead(),
  ///         length: fileLength,
  ///         filename: xfile!.name,
  ///         contentType: MediaType.parse('image/jpeg'),
  ///   ),
  ///  'data': message,
  ///  'user_id': 1234,
  /// }
  /// ```
  Future<Map<String, dynamic>> multipartRequest({
    required Method method,
    required Uri uri,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    void Function(int sentBytes, int totalBytes)? progress,
  });
}

class MultipartRequestHandlerImpl extends MultipartRequestHandler {
  Future<Map<String, dynamic>> multipartRequest({
    required Method method,
    required Uri uri,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    void Function(int sentBytes, int totalBytes)? progress,
  }) async {
    final request = MultipartRequest(
      method.toString().split('.').last.toUpperCase(),
      uri,
      onProgress: progress,
    );
    body?.forEach((key, value) async {
      if (value is MultipartFileHolder) {
        final part = http.MultipartFile(
          key,
          value.stream,
          value.length,
          filename: value.filename,
          contentType: value.contentType,
        );
        request.files.add(part);
      } else if (value is List<String>) {
        request.fields[key] = value.join(',');
      } else if (value is List) {
        final converted = value.map((e) => jsonEncode(e));
        request.fields[key] = converted.join(',');
      } else if (value is String) {
        request.fields[key] = value;
      } else if (value != null) {
        request.fields[key] = jsonEncode(value);
      }
    });
    request.headers.addAll(headers ?? _commonHeaders());
    final resp = await request.send();
    final result = await http.Response.fromStream(resp);

    return _response(result);
  }

  Map<String, String> _commonHeaders() {
    final commonHeaders = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    return commonHeaders;
  }

  Future<Map<String, dynamic>> _response(http.Response response) async {
    final resp = jsonDecode(response.body);
    final statusCode = response.statusCode;
    if (statusCode >= 400 && statusCode <= 599) {
      final message = response.reasonPhrase ?? resp['message'] ?? '';
      switch (statusCode) {
        case 400:
          _logDebug(
            'Multipart - Bad request: $message for ${response.request?.url.toString()}',
          );
          throw BadRequestError(message: message);
        case 401:
        case 403:
          _logDebug(
            'Multipart - Unauthorized request: $message',
          );
          throw UnauthorizeError(message: message);
        case 500:
        default:
          _logDebug(
            'Multipart - internal server error :${response.statusCode}',
          );
          throw InternalServerError(
            message: 'internal server error :${response.statusCode}',
          );
      }
    }

    return resp;
  }

  void _logDebug(
    String message,
  ) {
    if (kDebugMode) {
      log(message);
    }
  }
}

enum Method {
  get,
  post,
  put,
  delete,
  patch,
}

class MultipartError extends Error {
  String? message;

  MultipartError({
    this.message,
  });
}

class BadRequestError extends MultipartError {
  BadRequestError({super.message});
}

class UnauthorizeError extends MultipartError {
  UnauthorizeError({super.message});
}

class InternalServerError extends MultipartError {
  InternalServerError({super.message});
}
