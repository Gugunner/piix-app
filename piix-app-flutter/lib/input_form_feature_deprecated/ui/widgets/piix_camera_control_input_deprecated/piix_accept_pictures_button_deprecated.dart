import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

@Deprecated('Will be removed in 4.0')
//TODO: Add documentation
class PiixAcceptPicturesButtonDeprecated extends StatelessWidget {
  const PiixAcceptPicturesButtonDeprecated({
    Key? key,
    this.backgroundColor,
    this.pictureCount = 0,
    this.onPressed,
  }) : super(key: key);

  final Color? backgroundColor;
  //TODO: Explain property
  final int pictureCount;
  final VoidCallback? onPressed;

  //TODO: Explain getter
  bool get moreThanOnePicture => pictureCount > 1;

  //TODO: Explain getter
  String get usablePictures =>
      '$pictureCount Foto${moreThanOnePicture ? 's' : ''}';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor ?? PiixColors.white,
          borderRadius: const BorderRadius.all(Radius.circular(4)),
        ),
        child: Center(
          child: Text(
            '$usablePictures',
            style: context.textTheme?.headlineSmall,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
