import 'package:piix_mobile/api_deprecated/piix_dio_provider_deprecated.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ip_repository_deprecated.g.dart';

@Deprecated('Will be removed in 4.0')
///An interface to mandate getting an ip address
abstract class _IpRepositoryInterface {
  Future<String?> getIpAddress();
}

@Deprecated('Will be removed in 4.0')
///A [Notifier] that handles requesting 
///an ip address
@riverpod
class IpRepository extends _$IpRepository implements _IpRepositoryInterface {
  @override
  void build() => {};

  @override
  Future<String?> getIpAddress() async {
    const path = 'https://api.ipify.org';
    final response = await ref.read(piixDioProvider).get(path);
    return response.data;
  }
}
