import 'dart:developer' as dev;
import 'dart:io';
import 'package:flutter/foundation.dart';

enum LogLevel { info, success, warning, error, debug }

class AppLogger {
  static final AppLogger _instance = AppLogger._internal();
  factory AppLogger() => _instance;
  AppLogger._internal();

  static File? _logFile;

  static Future<void> init() async {
    if (kIsWeb) return;
    try {
      // On Windows, we can use a local path or a specific directory
      final directory = Directory.current.path;
      _logFile = File('$directory/firebase_requests.log');
      if (!await _logFile!.exists()) {
        await _logFile!.create();
      }
      log('Logger initialized. Log file: ${_logFile!.path}', level: LogLevel.info);
    } catch (e) {
      dev.log('Failed to initialize log file: $e');
    }
  }

  static void log(String message, {LogLevel level = LogLevel.info, dynamic error, StackTrace? stackTrace}) {
    final timestamp = DateTime.now().toIso8601String();
    final emoji = _getEmoji(level);
    final formattedMessage = '[$timestamp] $emoji ${level.name.toUpperCase()}: $message';

    // Print to console with colors (using dev.log)
    dev.log(
      formattedMessage,
      name: 'AppLogger',
      error: error,
      stackTrace: stackTrace,
      level: _getDevLogLevel(level),
    );

    // Save to file if initialized and not on web
    if (_logFile != null && !kIsWeb) {
      String fileMessage = formattedMessage;
      if (error != null) fileMessage += '\nError: $error';
      if (stackTrace != null) fileMessage += '\nStackTrace: $stackTrace';
      
      _logFile!.writeAsStringSync('$fileMessage\n', mode: FileMode.append);
    }
  }

  static String _getEmoji(LogLevel level) {
    switch (level) {
      case LogLevel.info: return 'ℹ️';
      case LogLevel.success: return '✅';
      case LogLevel.warning: return '⚠️';
      case LogLevel.error: return '❌';
      case LogLevel.debug: return '🔍';
    }
  }

  static int _getDevLogLevel(LogLevel level) {
    switch (level) {
      case LogLevel.info: return 0;
      case LogLevel.success: return 0;
      case LogLevel.warning: return 500;
      case LogLevel.error: return 1000;
      case LogLevel.debug: return 0;
    }
  }
}
