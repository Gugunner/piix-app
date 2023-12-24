import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/store_feature/utils/ribbons_clips_paths.dart';

@Deprecated('Will be removed in 4.0')

///This widget receives a clip path to draw the ribbon
///
class RibbonDetailContainerDeprecated extends StatelessWidget {
  const RibbonDetailContainerDeprecated({
    Key? key,
    required this.discount,
  }) : super(key: key);
  final double discount;

  @override
  Widget build(BuildContext context) {
    //ClipPath is is a widget that clips its child using a path. It calls a
    //callback on a delegate when the widget is painted. This callback then
    //returns an enclosed path, and the ClipPath widget prevents the child
    //from painting outside the path
    return ClipPath(
      child: Container(
          height: 33.6.h,
          width: double.infinity,
          color: PiixColors.highlight,
          padding: EdgeInsets.only(top: 8.h),
          child: Text.rich(
            TextSpan(children: [
              TextSpan(
                text: '${PiixCopiesDeprecated.currrentComboDiscount} ',
                style: context.textTheme?.bodyMedium?.copyWith(
                  color: PiixColors.space,
                ),
              ),
              TextSpan(
                text: '${discount.toStringAsFixed(0)}%',
                style: context.textTheme?.bodyMedium?.copyWith(
                  color: PiixColors.space,
                  fontWeight: FontWeight.bold,
                ),
              )
            ]),
            textAlign: TextAlign.center,
          )),
      //This class draws a ribbon using a freehand tool
      clipper: DiscountRibbonDetailDrawing(),
    );
  }
}
