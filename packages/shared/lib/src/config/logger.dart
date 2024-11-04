import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// Singleton Logger instance
class AppLogger {
  /// Factory constructor for the Logger
  factory AppLogger() => _instance;

  AppLogger._initialize()
      : _logger = Logger(
    level: isProduction ? Level.warning : Level.debug,
  ),
        platform = _getPlatformInfo(),
        appVersionFuture = _getAppVersion();
  // Singleton pattern for the Logger
  static final AppLogger _instance = AppLogger._initialize();

  final Logger _logger;
  /// Platform information
  final String platform;
  /// App version information
  final Future<String> appVersionFuture;

  /// Production or development mode can be set here
  static const bool isProduction = bool.fromEnvironment('dart.vm.product');

  static String _getPlatformInfo() {
    if (Platform.isAndroid) return 'Android';
    if (Platform.isIOS) return 'iOS';
    if (Platform.isMacOS) return 'macOS';
    if (Platform.isWindows) return 'Windows';
    if (Platform.isLinux) return 'Linux';
    if (kIsWeb) return 'Web';
    return 'Unknown';
  }

  static Future<String> _getAppVersion() async {
    try {
      final info = await PackageInfo.fromPlatform();
      return '${info.version}+${info.buildNumber}';
    } catch (e) {
      return 'Unknown';
    }
  }

  /// Logging methods
  /// Log an error message
  Future<void> logError(
      dynamic message, {
        DateTime? time,
        Object? error,
        StackTrace? stackTrace,
      }) async {
    final appVersion = await appVersionFuture;
    _logger.e(
      '[Platform: $platform, Version: $appVersion] $message',
      error: error,
      stackTrace: stackTrace,
      time: time ?? DateTime.now(),
    );
  }
/// Log a warning message
  Future<void> logWarning(
      dynamic message, {
        DateTime? time,
        Object? error,
        StackTrace? stackTrace,
      }) async {
    final appVersion = await appVersionFuture;
    _logger.w(
      '[Platform: $platform, Version: $appVersion] $message',
      error: error,
      stackTrace: stackTrace,
      time: time ?? DateTime.now(),
    );
  }
/// Log an info message
  Future<void> logInfo(
      dynamic message, {
        DateTime? time,
        Object? error,
        StackTrace? stackTrace,
      }) async {
    final appVersion = await appVersionFuture;
    _logger.i(
      '[Platform: $platform, Version: $appVersion] $message',
      error: error,
      stackTrace: stackTrace,
      time: time ?? DateTime.now(),
    );
  }
/// Log a debug message
  Future<void> logDebug(
      dynamic message, {
        DateTime? time,
        Object? error,
        StackTrace? stackTrace,
      }) async {
    if (!isProduction) {
      final appVersion = await appVersionFuture;
      _logger.d(
        '[Platform: $platform, Version: $appVersion] $message',
        error: error,
        stackTrace: stackTrace,
        time: time ?? DateTime.now(),
      );
    }
  }
}
