import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';

class RequireLocationAlert extends StatelessWidget {
  const RequireLocationAlert({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: const EdgeInsets.all(24),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  margin: const EdgeInsets.all(8),
                  height: 24,
                  width: 24,
                  child: const Center(
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Icon(
                        Icons.close,
                        color: PiixColors.errorMain,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Text(
              'Es necesario activar la ubicación',
              style: TextStyle(
                  color: PiixColors.mainText,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              width: 400,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Debes permitir a la aplicación conocer tu ubicación, es requerido buscar en la configuración del dispositivo la opción para permitir a la aplicación conocer tu ubicación.',
                    style: TextStyle(
                        fontSize: 14, color: PiixColors.mainText, height: 1.5),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TextButton(
                onPressed: () {
                  Geolocator.openLocationSettings();
                  Navigator.pop(context);
                },
                child: const Text(
                  'ACEPTAR',
                  style: TextStyle(color: PiixColors.clearBlue, fontSize: 14),
                ))
          ],
        )
      ],
    );
  }
}
