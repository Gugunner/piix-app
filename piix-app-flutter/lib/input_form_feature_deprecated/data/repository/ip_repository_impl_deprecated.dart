import 'package:dio/dio.dart';
import 'package:piix_mobile/form_feature/domain/provider/form_answer_provider_deprecated.dart';
import 'package:piix_mobile/general_app_feature/api/piix_api_deprecated.dart';
import 'package:piix_mobile/input_form_feature_deprecated/data/repository/ip_repository_deprecated.dart';

@Deprecated('Will be removed in 4.0')
extension IpRepositoryImplDeprecated on IpRepositoryDeprecated {
  @Deprecated('Will be removed in 4.0')
  Future<dynamic> getIpAddressRequestedImpl() async {
    try {
      final response = await ipApi.getIpAddressApi();
      final statusCode = response.statusCode ?? 500;
      if (PiixApiDeprecated.checkStatusCode(statusCode: statusCode)) {
        if (response.data != null) {
          final data = {};
          data['state'] = LegalAnswerState.retrieved;
          data['ip'] = response.data;
          return data;
        }
      }
      return LegalAnswerState.error;
      // ignore: unused_catch_clause
    } on DioError catch (dioError) {
      rethrow;
    }
  }
}
