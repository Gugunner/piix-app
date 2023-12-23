import 'package:piix_mobile/email_feature/data/repository/email_system_repository_impl.dart';
import 'package:piix_mobile/email_feature/data/repository/email_system_repository_use_case_test.dart';
import 'package:piix_mobile/email_feature/data/service/email_system_api.dart';
import 'package:piix_mobile/email_feature/domain/model/request_email_model.dart';
import 'package:piix_mobile/general_app_feature/di/service_locator.dart';
import 'package:piix_mobile/general_app_feature/utils/app_use_case_test.dart';

enum EmailState {
  idle,
  sending,
  sent,
  notFound,
  conflict,
  error,
}

class EmailSystemRepository {
  EmailSystemRepository(this.emailApi);

  final EmailSystemApi emailApi;
  final _appTest = getIt<AppUseCaseTestFlag>().test;

  Future<EmailState> sendEmailRequested(RequestEmailModel requestEmail) async {
    if (_appTest) {
      return sendEmailRequestedTest(requestEmail);
    }
    return sendEmailRequestedImpl(requestEmail);
  }
}
