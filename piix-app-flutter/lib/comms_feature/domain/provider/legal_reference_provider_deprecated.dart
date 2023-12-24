import 'package:geolocator/geolocator.dart';
import 'package:piix_mobile/comms_feature/data/repository/ip_repository_deprecated.dart';
import 'package:piix_mobile/utils/log_utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'legal_reference_provider_deprecated.g.dart';


@Deprecated('Will be removed in 4.0')
///A Riverpod Notifier class that handles device ip
///methods
@riverpod
class IpNotifier extends _$IpNotifier with LogAppCall {
  @override
  void build() => {};

  @Deprecated('Will be removed in 4.0')
  ///Obtains the ip address of the device and returns 
  ///a String value.
  Future<String?> getIpAddress() async {
    final repository = ref.read(ipRepositoryProvider.notifier);
    try {
      return await repository.getIpAddress();
    } catch (error) {
      logError(error, className: 'IpNotifier');
      rethrow;
    }
  }
}

@Deprecated('Will be removed in 4.0')
///A Riverpod Notifier class that handles device location
///methods
@riverpod
class LocationNotifier extends _$LocationNotifier with LogAppCall {
  @override
  void build() => {};

  @Deprecated('Will be removed in 4.0')
  ///Checks if the [Geolocator] services are enabled in the device
  Future<void> _checkLocationServices() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return Future.error(Exception('disabled'));
  }

  @Deprecated('Will be removed in 4.0')
  ///Checks if the [Geolocator] has permission to retrieve
  ///the device location
  Future<void> _getPermission() async {
    await _checkLocationServices();
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) return;
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever ||
        permission == LocationPermission.unableToDetermine) {
      return Future.error(permission);
    }
    return;
  }

  @Deprecated('Will be removed in 4.0')
  ///Obtains the [Position] of the device
  Future<Position> getLocation() async {
    try {
      await _getPermission();
      return Geolocator.getCurrentPosition();
    } catch (error) {
      logError(error, className: 'LocationNotifier');
      rethrow;
    }
  }
}
