import 'package:piix_mobile/input_form_feature_deprecated/data/repository/ip_repository_impl_deprecated.dart';
import 'package:piix_mobile/input_form_feature_deprecated/data/repository/ip_repository_test_deprecated.dart';
import 'package:piix_mobile/input_form_feature_deprecated/data/service_deprecated/ip_api_deprecated.dart';

@Deprecated('Use new IpRepository')
class IpRepositoryDeprecated {
  const IpRepositoryDeprecated(this.ipApi);

  @Deprecated('Will be removed in 4.0')
  final IpApiDeprecated ipApi;

  @Deprecated('Will be removed in 4.0')
  Future<dynamic> getIpAddressRequested([bool test = false]) async {
    if (test) {
      return getIpAddressRequestedTest();
    }
    return getIpAddressRequestedImpl();
  }
}
