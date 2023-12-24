import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_logger/piix_logger.dart';

//TODO: Check exception handling
Future<Position> getLocation() async {
  final serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location service are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location service.
    final loggerInstance = PiixLogger.instance;
    final logMessage = loggerInstance.errorMessage(
      messageName: 'Error in getLocation',
      message: 'Location service are disabled.',
      isLoggable: false,
    );
    loggerInstance.log(
      logMessage: logMessage.toString(),
      error: Error(),
      level: Level.error,
      sendToCrashlytics: true,
    );
    return Future.error('Location service are disabled.');
  }
  //
  var permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      final loggerInstance = PiixLogger.instance;
      final logMessage = loggerInstance.errorMessage(
        messageName: 'Error in getLocation',
        message: 'Location permissions are denied',
        isLoggable: false,
      );
      loggerInstance.log(
        logMessage: logMessage.toString(),
        error: Error(),
        level: Level.error,
        sendToCrashlytics: true,
      );
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    final loggerInstance = PiixLogger.instance;
    final logMessage = loggerInstance.errorMessage(
      messageName: 'Error in getLocation',
      message: 'Location permissions are permanently denied, '
          'we cannot request permissions.',
      isLoggable: false,
    );
    loggerInstance.log(
      logMessage: logMessage.toString(),
      error: Error(),
      level: Level.error,
      sendToCrashlytics: true,
    );
    return Future.error('Location permissions are permanently denied, '
        'we cannot request permissions.');
  }

  return Geolocator.getCurrentPosition();
}

Future<String?> getPermission() async {
  final serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location service are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location service.
    return PiixCopiesDeprecated.locationServiceDisabled;
  }

  var permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    try {
      permission = await Geolocator.requestPermission();
    } catch (e) {
      final loggerInstance = PiixLogger.instance;
      final logMessage = loggerInstance.errorMessage(
        messageName: 'Error in getPermission',
        message: e.toString(),
        isLoggable: false,
      );
      loggerInstance.log(
        logMessage: logMessage.toString(),
        error: e,
        level: Level.error,
        sendToCrashlytics: true,
      );
    }
    if (permission == LocationPermission.denied) {
      return PiixCopiesDeprecated.locationServiceDenied;
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return PiixCopiesDeprecated.locationServiceIsDenied;
  }
  return null;
}

Future<bool> validatePermission() async {
  final serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location service are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location service.
    return false;
  }

  var permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    try {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        return true;
      }
      return false;
    } catch (e) {
      final loggerInstance = PiixLogger.instance;
      final logMessage = loggerInstance.errorMessage(
        messageName: 'Error in validatePermission',
        message: e.toString(),
        isLoggable: false,
      );
      loggerInstance.log(
        logMessage: logMessage.toString(),
        error: e,
        level: Level.error,
        sendToCrashlytics: true,
      );
      return false;
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return false;
  }
  return true;
}
