import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';

///A round button with the camera icon that when pressed
///executes [onTakePicture].
final class RoundedCameraButton extends StatelessWidget {
  const RoundedCameraButton({super.key, required this.onTakePicture});

  final VoidCallback onTakePicture;

  ///Diameter of outer circle
  double get _outerDiameter => 64.w;

  ///Diameter difference between inner circle and outer circle
  double get _diameterDifference => 10.w;

  ///Diameter of inner circle
  double get _innerDiameter => _outerDiameter - _diameterDifference;

  @override
  Widget build(BuildContext context) {
    //Creates outer circle
    return Container(
      width: _outerDiameter,
      height: _outerDiameter,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: Material(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_outerDiameter)),
        child: InkWell(
          borderRadius: BorderRadius.circular(_outerDiameter),
          onTap: onTakePicture,
          splashColor: PiixColors.contrast.withOpacity(0.65),
          child: Stack(
            children: [
              const SizedBox(),
              Positioned(
                //Centers the inner circle
                left: _diameterDifference / 2,
                top: _diameterDifference / 2,
                //Creates inner circle
                child: Container(
                  width: _innerDiameter,
                  height: _innerDiameter,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: PiixColors.infoDefault,
                      //stroke width
                      width: 2.w,
                    ),
                  ),
                  child: Icon(
                    Icons.camera_alt_outlined,
                    size: 24.w,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
