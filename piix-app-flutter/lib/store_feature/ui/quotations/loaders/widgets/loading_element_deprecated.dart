import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:piix_mobile/extensions/widget_extend.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

@Deprecated('Will be removed in 4.0')

///Render a column with loader image, loader text, and circular progress
///indicator
///
class LoadingElementDeprecated extends StatelessWidget {
  const LoadingElementDeprecated({
    Key? key,
    required this.pathImage,
    required this.text,
  }) : super(key: key);
  final String pathImage;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(pathImage).padBottom(35.h),
          Text(
            text,
            style: context.textTheme?.headlineSmall,
            textAlign: TextAlign.center,
          ).padBottom(20.h),
          const CircularProgressIndicator.adaptive()
        ],
      ),
    );
  }
}
