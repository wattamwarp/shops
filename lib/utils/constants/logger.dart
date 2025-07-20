import 'package:flutter/foundation.dart';

class Logger {
  final bool isDebug;
  Logger({this.isDebug = kDebugMode});

  void log(String message) {
    if (isDebug) {
      print('[LOG] $message');
    }
  }

  void error(String message) {
    if (isDebug) {
      print('[ERROR] $message');
    }
  }
}
