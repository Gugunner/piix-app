import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/camera_feature/camera_utils_barrel_file.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';

///Use as the [painter] of a [CustomPaint] to draw the silhouettes
///handled by the [cameraSilhouette].
final class CameraSilhouettePainter extends CustomPainter {
  const CameraSilhouettePainter({this.cameraSilhouette = CameraSilhouette.id});

  final CameraSilhouette cameraSilhouette;

  ///Fills all the color surrounding the silhouettes.
  Color get _backgroundColor => PiixColors.contrast.withOpacity(0.5);

  ///The default [Paint] configuration with fill [PaintingStyle]
  ///using the [_backgroundColor].
  Paint get _backgroundPaint => Paint()..color = _backgroundColor;

  ///A custom [Paint] configuration that dictates to only draw the
  ///surrounding stroke of the [canvas].
  Paint get _borderPaint => Paint()
    ..color = PiixColors.contrast
    ..strokeWidth = 2.w
    ..style = PaintingStyle.stroke;

  ///Creates a full [Path] of [size].
  Path _screenRect(Size size) =>
      Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height));

  ///Paints a border for the identification silhouette.
  void _paintIdentificationBorder(Canvas canvas) {
    canvas.drawRRect(
        RRect.fromRectXY(Rect.fromLTWH(65.w, 104.h, 190.w, 266.h), 12.w, 12.w),
        _borderPaint);
  }

  ///Paints the identification silhouette by substracting the [Path]
  ///of the [idenfitication] from the [_screenRect].
  void _paintIdentificationSilhouette(Canvas canvas, Size size) {
    canvas.drawPath(
      Path.combine(
        PathOperation.difference,
        _screenRect(size),
        Path()
          ..addRRect(RRect.fromRectXY(
              Rect.fromLTWH(66.w, 105.h, 188.w, 264.h), 12.w, 12.w))
          ..close(),
      ),
      _backgroundPaint,
    );
  }

  ///Paints a border for the user and identification silhouette.
  void _paintSelfieBorder(Canvas canvas) {
    canvas.drawOval(
      Rect.fromCenter(center: Offset(86.w, 224.h), width: 160.w, height: 218.h),
      _borderPaint,
    );

    canvas.drawRRect(
      RRect.fromRectXY(Rect.fromLTWH(171.w, 136.h, 142.w, 90.h), 8.w, 8.w),
      _borderPaint,
    );
  }

  ///Paints the user and identification silhouette by substracting the [Path]
  ///of the [selfie]  and [idenfitication] from the [_screenRect].
  void _paintSelfieSilhouette(Canvas canvas, Size size) {
    canvas.drawPath(
      Path.combine(
        PathOperation.difference,
        _screenRect(size),
        Path()
          ..addOval(
            Rect.fromCenter(
                center: Offset(87.w, 225.h), width: 158.w, height: 216.h),
          )
          ..close(),
      )..addRRect(
          RRect.fromRectXY(Rect.fromLTWH(172.w, 137.h, 140.w, 88.h), 8.w, 8.w)),
      _backgroundPaint,
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    switch (cameraSilhouette) {
      case CameraSilhouette.id:
        _paintIdentificationSilhouette(canvas, size);
        _paintIdentificationBorder(canvas);
        break;
      case CameraSilhouette.selfie:
        _paintSelfieSilhouette(canvas, size);
        _paintSelfieBorder(canvas);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    ///Keep in false to avoid listening during production and
    ///rebuilding the drawing to further optimize memory allocation.
    return false;
  }
}
