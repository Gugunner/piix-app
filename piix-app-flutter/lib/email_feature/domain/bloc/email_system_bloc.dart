import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:piix_mobile/email_feature/data/repository/email_system_repository.dart';
import 'package:piix_mobile/email_feature/domain/model/request_email_model.dart';
import 'package:piix_mobile/utils/api/app_api_log_exception.dart';
import 'package:piix_mobile/general_app_feature/di/service_locator.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_logger/piix_logger.dart';

class EmailSystemBLoC extends ChangeNotifier {
  EmailState _emailState = EmailState.idle;
  EmailState get emailState => _emailState;
  set emailState(EmailState state) {
    _emailState = state;
    notifyListeners();
  }

  EmailSystemRepository get _emailSystemRepository =>
      getIt<EmailSystemRepository>();

  //TODO: Explain method
  Future<void> sendEmail({
    required String userId,
    required String benefitName,
    required List<String> displayNames,
    required List<String> emails,
    required List<String> fileNames,
    required List<String> paths,
  }) async {
    try {
      if (fileNames.isEmpty || paths.isEmpty) {
        emailState = EmailState.error;
        return;
      }
      final filesLength = fileNames.length;
      final pathsLength = paths.length;
      if (filesLength != pathsLength) {
        emailState = EmailState.error;
        throw Exception('Files and S3 paths are not same length');
      }
      if (displayNames.isEmpty || emails.isEmpty) {
        emailState = EmailState.error;
        throw Exception('Either the remitents or the emails are empty');
      }
      final namesLengh = displayNames.length;
      final emailsLength = emails.length;
      if (namesLengh != emailsLength) {
        emailState = EmailState.error;
        throw Exception('Emails and Remitents are not the same length');
      }
      final recipients = <EmailRecipientsModel>[];
      for (var index = 0; index < namesLengh; index++) {
        recipients.add(
          EmailRecipientsModel(
            displayName: displayNames[index],
            email: emails[index],
          ),
        );
      }
      final attachments = <EmailAttachmentsModel>[];
      for (var index = 0; index < filesLength; index++) {
        attachments.add(
          EmailAttachmentsModel(
            filename: fileNames[index],
            path: paths[index],
          ),
        );
      }
      final requestEmail = RequestEmailModel(
        userId: userId,
        benefitName: benefitName,
        toEmails: recipients,
        attachments: attachments,
      );
      emailState = EmailState.sending;
      emailState =
          await _emailSystemRepository.sendEmailRequested(requestEmail);
    } catch (e) {
      final loggerInstance = PiixLogger.instance;
      final logMessage = loggerInstance.errorMessage(
        messageName: 'Error in sendEmail sending the benefit $benefitName',
        message: e.toString(),
        isLoggable: isApiException(e),
      );
      loggerInstance.log(
        logMessage: logMessage.toString(),
        error: e,
        level: Level.error,
        sendToCrashlytics: true,
      );
      emailState = EmailState.error;
    }
  }
}
