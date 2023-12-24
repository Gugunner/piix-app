import 'dart:io';

import 'package:flutter/material.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/input_form_feature_deprecated/ui/widgets/piix_camera_dialog_deprecated/preview_image_error_widget_deprecated.dart';

@Deprecated('Will be removed in 4.0')
class PreviewImageWidgetDeprecated extends StatelessWidget {
  const PreviewImageWidgetDeprecated({
    Key? key,
    required this.image,
  }) : super(key: key);

  final File image;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      height: context.height,
      child: Image.file(
        image,
        width: context.width,
        height: context.height,
        fit: BoxFit.fitHeight,
        errorBuilder: (context, error, stackTrace) {
          return const PreviewImageErrorWidgetDeprecated();
        },
      ),
    );
  }
}
