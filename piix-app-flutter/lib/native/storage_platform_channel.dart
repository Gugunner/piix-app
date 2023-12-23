import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_logger/piix_logger.dart';

//TODO: Analyze and refactor for 4.0
class StoragePlatformChannel {
  final MethodChannel _methodChannel =
      const MethodChannel('com.piix.app/storage');

  Future<String> storagePermission() async {
    try {
      final result = await _methodChannel.invokeMethod(
        'getStoragePermission',
      );
      return result;
    } on PlatformException catch (e) {
      final loggerInstance = PiixLogger.instance;
      final logMessage = loggerInstance.errorMessage(
        messageName: 'Exception in platform chanel'
            'with storage permission',
        message: e.message,
        isLoggable: true,
      );
      loggerInstance.log(
        logMessage: logMessage.toString(),
        error: e,
        level: Level.error,
      );
      rethrow;
    }
  }

  Future<void> openAppSettings() async {
    try {
      await _methodChannel.invokeMethod(
        'openAppSettings',
      );
    } on PlatformException catch (e) {
      final loggerInstance = PiixLogger.instance;
      final logMessage = loggerInstance.errorMessage(
        messageName: 'Exception in platform chanel'
            'with open app settings',
        message: e.message,
        isLoggable: true,
      );
      loggerInstance.log(
        logMessage: logMessage.toString(),
        error: e,
        level: Level.error,
      );
      throw e;
    }
  }
}
