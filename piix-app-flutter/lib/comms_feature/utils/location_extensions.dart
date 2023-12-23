import 'package:geolocator/geolocator.dart';

extension LocationPermissionMessage on LocationPermission {
  
  String get message {
    switch (this) {
      case LocationPermission.denied:
      case LocationPermission.deniedForever:
        return 'Se requiere autorizar la ubicación par usar la aplicación';
      case LocationPermission.unableToDetermine:
        return 'Ocurrio un error al obtener tu ubicación';
      default:
        return '';
    }
  }

}