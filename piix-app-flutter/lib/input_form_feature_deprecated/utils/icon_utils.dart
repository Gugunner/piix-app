import 'package:flutter/material.dart';
import 'package:piix_mobile/input_form_feature_deprecated/utils/id_utils.dart';

class IconUtils {
  static IconData toIcon(FieldIdDeprecated id) {
    switch (id) {
      case FieldIdDeprecated.uniqueId:
        return Icons.info_outline;
      default:
        return Icons.question_mark_outlined;
    }
  }
}
