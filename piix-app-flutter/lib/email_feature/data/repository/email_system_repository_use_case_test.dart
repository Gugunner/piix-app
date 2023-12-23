import 'package:piix_mobile/email_feature/data/repository/email_system_repository.dart';
import 'package:piix_mobile/email_feature/domain/model/request_email_model.dart';

extension EmailSystemRepositoryUseCaseTest on EmailSystemRepository {
  Future<EmailState> sendEmailRequestedTest(RequestEmailModel requestEmail) {
    return Future.delayed(const Duration(seconds: 2), () {
      if (requestEmail.toEmails.any((recipient) => recipient.email.contains('error'))) {
        return EmailState.error;
      } else if (requestEmail.toEmails.any((recipient) => recipient.email.contains('found'))) {
        return EmailState.notFound;
      }
      return EmailState.sent;
    });
  }
}
