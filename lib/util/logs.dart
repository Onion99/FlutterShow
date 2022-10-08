import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:intl/intl.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

/// Logging config
void printLog([dynamic data, DateTime? startTime]) {
  if (foundation.kDebugMode) {
    var time = '';
    if (startTime != null) {
      final endTime = DateTime.now().difference(startTime);
      final icon = endTime.inMilliseconds > 2000
          ? '⌛️Slow-'
          : endTime.inMilliseconds > 1000
          ? '⏰Medium-'
          : '⚡️Fast-';
      time = '[$icon${endTime.inMilliseconds}ms]';
    }

    try {
      final now = DateFormat('h:mm:ss-ms').format(DateTime.now());
      debugPrint('ℹ️[${now}ms]$time${data.toString()}');

      if (data.toString().contains('is not a subtype of type')) {
        throw Exception();
      }
    } catch (e, trace) {
      debugPrint('🔴 ${data.toString()}');
      debugPrint(trace.toString());
    }
  }
}



/// The default http GET that support Logging
Future<http.Response> httpGet(
    Uri url, {
      Map<String, String>? headers,
      bool enableDio = false,
      String kWebProxy = '',
    }) async {
  final startTime = DateTime.now();
  if (enableDio) {
    try {
      final res = await Dio().get(url.toString(),
          options: Options(headers: headers, responseType: ResponseType.plain));
      printLog('GET:$url', startTime);
      final response = http.Response(res.toString(), res.statusCode!);
      return response;
    } on DioError catch (e) {
      if (e.response != null) {
        final response =
        http.Response(e.response.toString(), e.response!.statusCode!);
        return response;
      } else {
        // ignore: only_throw_errors
        throw e.message;
      }
    }
  } else {
    // ignore: prefer_typing_uninitialized_variables
    var response;
    var uri = url;
    if (foundation.kIsWeb) {
      final proxyURL = '$url';
      uri = Uri.parse(proxyURL);
    }

    response = await http.get(uri, headers: headers);
    printLog('♻️ GET:$url', startTime);

    return response;
  }
}