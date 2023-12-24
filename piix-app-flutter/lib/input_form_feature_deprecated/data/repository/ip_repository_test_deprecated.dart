import 'package:piix_mobile/form_feature/domain/provider/form_answer_provider_deprecated.dart';
import 'package:piix_mobile/input_form_feature_deprecated/data/repository/ip_repository_deprecated.dart';

@Deprecated('Will be removed in 4.0')
extension IpRepositoryTestDeprecated on IpRepositoryDeprecated {
  @Deprecated('Will be removed in 4.0')
  Future<dynamic> getIpAddressRequestedTest() async {
    return {
      'ip': '189.203.104.126',
      'state': LegalAnswerState.retrieved,
    };
  }
}
