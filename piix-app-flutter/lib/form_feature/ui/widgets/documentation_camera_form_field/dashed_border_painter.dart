// ignore_for_file: omit_local_variable_types, prefer_final_locals
import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';

///Paints a dashed line rounded rectangle border.
///
///By configuring the [dashLength]
class RoundOutlinedDashedBorderPainter extends CustomPainter {
  const RoundOutlinedDashedBorderPainter({
    this.color = PiixColors.infoDefault,
    this.strokeWidth = 8,
    this.dashLength = 12,
    this.gap = 4,
  });

  final Color? color;
  final double dashLength;
  final double gap;
  final double strokeWidth;

  Paint get _paint => Paint()
    ..color = color ?? PiixColors.infoDefault
    ..style = PaintingStyle.stroke
    ..strokeWidth = strokeWidth;

  void _paintTopRightCorner(Canvas canvas, double startX, double startY) {
    final path = Path();
    path.moveTo(startX, startY);
    path.cubicTo(startX, startY, startX + dashLength, startY,
        startX + gap + dashLength / 2, dashLength / 2);
    canvas.drawPath(path, _paint);
  }

  void _paintBottomRightCorner(Canvas canvas, double startX, double startY) {
    final path = Path();
    path.moveTo(startX, startY);
    path.cubicTo(startX, startY, startX + dashLength, startY,
        startX + dashLength / 2 + gap, startY - dashLength / 2);
    canvas.drawPath(path, _paint);
  }

  void _paintTopLeftCorner(Canvas canvas, double startX, double startY) {
    final path = Path();
    path.moveTo(startX, dashLength / 2);
    path.cubicTo(startX, dashLength / 2, startX, startY, dashLength, startY);
    canvas.drawPath(path, _paint);
  }

  void _paintBottomLeftCorner(Canvas canvas, double startX, double startY) {
    final path = Path();
    path.moveTo(startX, startY - dashLength / 2);
    path.cubicTo(
        startX, startY - dashLength / 2, startX, startY, dashLength, startY);
    canvas.drawPath(path, _paint);
  }

  void _paintBorder(
      Canvas canvas, double startX, double startY, bool horizontal) {
    if (horizontal) {
      canvas.drawLine(
          Offset(startX, startY), Offset(startX + dashLength, startY), _paint);
      return;
    }
    canvas.drawLine(
        Offset(startX, startY), Offset(startX, startY + dashLength), _paint);
  }

  void _paintLeftBorder(Canvas canvas, Size size) {
    double startX = 0, startY = 0;
    while (startY < size.height) {
      if ((startY + dashLength + gap) >= size.height) {
        final startY = size.height;
        _paintBottomLeftCorner(canvas, startX, startY);
      } else if (startY == 0) {
        _paintTopLeftCorner(canvas, startX, startY);
        startY = dashLength / 2 - 2 * gap;
      } else {
        _paintBorder(canvas, startX, startY, false);
      }
      startY += dashLength + gap;
    }
  }

  void _paintRightBorder(Canvas canvas, Size size) {
    double startX = size.width, startY = 0;
    while (startY < size.height) {
      if ((startY + dashLength + gap) >= size.height) {
        final startY = size.height;
        final startX = size.width - dashLength / 2 - gap;
        _paintBottomRightCorner(canvas, startX, startY);
      } else if (startY == 0) {
        final startX = size.width - dashLength / 2 - gap;
        _paintTopRightCorner(canvas, startX, startY);
        startY = dashLength / 2 - 2 * gap;
      } else {
        _paintBorder(canvas, startX, startY, false);
      }
      startY += dashLength + gap;
    }
  }

  void _paintBottomBorder(Canvas canvas, Size size) {
    double startX = 0, startY = size.height;
    while (startX < size.width) {
      if ((startX + dashLength + gap) >= size.width) {
        startX = size.width - dashLength / 2 - gap;
        _paintBottomRightCorner(canvas, startX, startY);
      } else if (startX == 0) {
        _paintBottomLeftCorner(canvas, startX, startY);
        startX = dashLength / 2 - gap;
      } else {
        _paintBorder(canvas, startX, startY, true);
      }
      startX += dashLength + gap;
    }
  }

  void _paintTopBorder(Canvas canvas, Size size) {
    double startX = 0, startY = 0;
    while (startX < size.width) {
      if ((startX + dashLength + gap) >= size.width) {
        startX = size.width - dashLength / 2 - gap;
        _paintTopRightCorner(canvas, startX, startY);
      } else if (startX == 0) {
        _paintTopLeftCorner(canvas, startX, startY);
        startX = dashLength / 2 - gap;
      } else {
        _paintBorder(canvas, startX, startY, true);
      }
      startX += dashLength + gap;
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    _paintTopBorder(canvas, size);
    _paintRightBorder(canvas, size);
    _paintBottomBorder(canvas, size);
    _paintLeftBorder(canvas, size);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
