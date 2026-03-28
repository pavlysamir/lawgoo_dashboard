import 'app_logger.dart';

class FirebaseLogger {
  static Future<T> logCall<T>(
    String methodName, {
    required Future<T> Function() call,
    Map<String, dynamic>? params,
  }) async {
    final startTime = DateTime.now();
    final logParams = params != null ? ' Params: $params' : '';
    
    AppLogger.log(
      'START: $methodName$logParams',
      level: LogLevel.info,
    );

    try {
      final result = await call();
      final duration = DateTime.now().difference(startTime).inMilliseconds;
      
      AppLogger.log(
        'SUCCESS: $methodName (Duration: ${duration}ms)',
        level: LogLevel.success,
      );
      
      return result;
    } catch (e, stackTrace) {
      final duration = DateTime.now().difference(startTime).inMilliseconds;
      
      AppLogger.log(
        'ERROR: $methodName (Duration: ${duration}ms)',
        level: LogLevel.error,
        error: e,
        stackTrace: stackTrace,
      );
      
      rethrow;
    }
  }
}
