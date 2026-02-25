import 'package:flutter/foundation.dart';

class AppLogger {
  static final AppLogger _instance = AppLogger._internal();
  factory AppLogger() => _instance;
  AppLogger._internal();

  void log(String message, {String? tag}) {
    final prefix = tag != null ? '[$tag] ' : '';
    debugPrint('$prefix$message');
  }

  void error(
    String message, {
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  }) {
    final prefix = tag != null ? '[$tag] ' : '';
    debugPrint('ERROR: $prefix$message');
    if (error != null) debugPrint('Error: $error');
    if (stackTrace != null) debugPrint('StackTrace: $stackTrace');
  }
}
