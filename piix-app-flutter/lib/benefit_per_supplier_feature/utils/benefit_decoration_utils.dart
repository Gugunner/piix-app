import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';

Map<String, Style> get wordingZeroStyle => {
      'p': Style(
        color: PiixColors.infoDefault,
        fontFamily: 'Raleway',
        fontSize: FontSize(
          12.sp,
        ),
        letterSpacing: 0.1,
        fontWeight: FontWeight.w400,
        textAlign: TextAlign.justify,
        lineHeight: LineHeight.em(1),
      ),
      'ol': Style(
        color: PiixColors.secondaryText,
        fontFamily: 'Raleway',
        fontSize: FontSize(
          12.sp,
        ),
        letterSpacing: 0.1,
        fontWeight: FontWeight.w400,
        textAlign: TextAlign.justify,
        lineHeight: LineHeight.em(1),
      ),
    };
