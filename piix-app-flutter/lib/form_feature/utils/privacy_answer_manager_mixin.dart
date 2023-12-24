import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:piix_mobile/form_feature/form_model_barrel_file.dart';
import 'package:piix_mobile/utils/repositories/ip_repository.dart';

///Allows any class with this to construct additional
///[AnswerModel]s with internal devices information.
mixin PrivacyAnswerManager {
  ///Obtains the [DateTime] of the moment
  ///this method is being called and converts it
  ///to a 24 hour format 'HH:mm:ss'.
  ///
  ///Returns the 'signedHour' [AnswerModel].
  AnswerModel getSignedHour() {
    final date = DateTime.now();
    final format24Hours = DateFormat('HH:mm:ss');
    final signedHour = format24Hours.format(date);
    return AnswerModel(
      formFieldId: 'signedHour',
      dataTypeId: 'time',
      answer: signedHour,
    );
  }

  ///Obtains the [DateTime] of the moment
  ///and converts it to an iso 8601 format.
  ///
  ///Returns the 'signedDate' [AnswerModel].
  AnswerModel getSignedDate() {
    final date = DateTime.now();
    final isoDate = date.toIso8601String();
    return AnswerModel(
      formFieldId: 'signedDate',
      dataTypeId: 'date',
      answer: isoDate,
    );
  }

  ///Calls [getIpAddress] and if an [ip] address
  ///is obtained it returns a 'signedIp' [AnswerModel].
  ///
  ///If no [ip] is retrived it returns [null].
  Future<AnswerModel?> getSignedIp() async {
    try {
      final ipRepository = IPRepository();
      final ip = await ipRepository.getIPAddress();
      return AnswerModel(
        formFieldId: 'signedIP',
        dataTypeId: 'string',
        answer: ip,
      );
    } catch (error) {
      //TODO: Log error
      return null;
    }
  }

  ///Returns the 'signedLocalization' [AnswerModel] if
  ///locations services are enabled and the user has
  ///granted permission of location.
  Future<AnswerModel?> getSignedLocation() async {
    try {
      //Obtains the current status of location services in the device.
      final enabledServices = await Geolocator.isLocationServiceEnabled();
      //If services are not enabled it returns null.
      if (!enabledServices) return null;
      //If services are enabled it checks for the current LocationPermission.
      final currentPermission = await Geolocator.checkPermission();
      //If the currentPermission is not either 'always' or 'whileInUse'
      //it returns null.
      switch (currentPermission) {
        case LocationPermission.unableToDetermine:
        case LocationPermission.denied:
        case LocationPermission.deniedForever:
          return null;
        default:
          //The user granted permission and allows for the reading of its
          //device latitude and longitude.
          final position = await Geolocator.getCurrentPosition();
          final stringLatLng = '${position.latitude},${position.longitude}';
          //Returns the 'signedLocalization'
          return AnswerModel(
            formFieldId: 'signedGelocalization',
            dataTypeId: 'location',
            answer: stringLatLng,
          );
      }
    } catch (e) {
      return null;
    }
  }

  ///Reads the [Locale] of the passed [context]
  ///and returns the device's language code wrapped in
  ///the 'user_preferred_language' [AnswerModel.]
  AnswerModel getUserLanguage(BuildContext context) {
    final locale = Localizations.localeOf(context);
    return AnswerModel(
      formFieldId: 'user_preferred_language',
      dataTypeId: 'string',
      answer: locale.languageCode,
    );
  }
}
