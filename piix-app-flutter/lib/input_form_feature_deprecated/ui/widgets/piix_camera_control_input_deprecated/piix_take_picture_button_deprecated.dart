import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';

@Deprecated('Will be removed in 4.0')
//TODO: Add documentation
class PiixTakPictureButtonDeprecated extends StatelessWidget {
  const PiixTakPictureButtonDeprecated({
    Key? key,
    required this.onTakePicture,
  }) : super(key: key);

  //TODO: Explain property
  final VoidCallback onTakePicture;

  //TODO: Explain getter
  double get diameter => 60;

  //TODO: Explain getter
  double get size => diameter - 15;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: context.height * 0.039,
      ),
      width: diameter.h,
      height: diameter.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: PiixColors.white.withOpacity(0.3),
        border: Border.all(color: Colors.white),
        boxShadow: [
          BoxShadow(
            color: PiixColors.grey.withOpacity(0.25),
          ),
        ],
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        onPressed: onTakePicture,
        icon: Icon(
          Icons.circle,
          color: PiixColors.grey_white2,
          size: size.h,
        ),
      ),
    );
  }
}
