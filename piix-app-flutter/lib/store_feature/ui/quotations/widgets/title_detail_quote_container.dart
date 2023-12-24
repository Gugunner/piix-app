import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

@Deprecated('Will be removed in 4.0')

///This widget contains a container with gery decoration for the title
///detail quote
///
class TitleDetailQuoteContainerDeprecated extends StatelessWidget {
  const TitleDetailQuoteContainerDeprecated({
    super.key,
    required this.title,
  });
  final String title;

  double get mediumPadding => ConstantsDeprecated.mediumPadding;
  Radius get radius => const Radius.circular(8);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      padding: EdgeInsets.all(mediumPadding.h),
      margin: EdgeInsets.only(bottom: 8.h),
      decoration: BoxDecoration(
        color: PiixColors.greyWhite,
        borderRadius: BorderRadius.only(
          topLeft: radius,
          topRight: radius,
        ),
      ),
      child: Text(
        title,
        style: context.textTheme?.headlineMedium,
      ),
    );
  }
}
