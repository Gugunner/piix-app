import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';

///A decoration for rating card
Decoration get ratingCardDecoration {
  return BoxDecoration(
    color: PiixColors.greyWhite,
    borderRadius: BorderRadius.circular(9),
    boxShadow: [
      const BoxShadow(
          color: PiixColors.shadowBlack,
          offset: Offset(0, 2),
          blurRadius: 0,
          spreadRadius: 1)
    ],
  );
}
