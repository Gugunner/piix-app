import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/ui/common/piix_rating_bar_deprecated.dart';
import 'package:piix_mobile/ui/common/piix_tooltip_deprecated.dart';

@Deprecated('Will be removed in 4.0')

/// A widget to receive question and rating input from users.
///
///[highlight] can be use to show a general score.
class RatingQuestionDeprecated extends StatelessWidget {
  RatingQuestionDeprecated(
      {Key? key,
      this.onRatingUpdate,
      this.ratingValue,
      this.highlight,
      this.question,
      this.isGeneralRating = false})
      : super(key: key);
  final String? question;
  final String? highlight;
  final double? ratingValue;
  final Function(double)? onRatingUpdate;
  final bool isGeneralRating;

  final GlobalKey _ratingKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 25.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text.rich(
                  TextSpan(
                      text: question,
                      style: context.textTheme?.titleMedium?.copyWith(
                        color: PiixColors.primary,
                      ),
                      children: [
                        TextSpan(
                            text: isGeneralRating
                                ? PiixCopiesDeprecated.generalQualification
                                : highlight,
                            style: context.textTheme?.headlineSmall?.copyWith(
                              color: PiixColors.primary,
                            )),
                        TextSpan(
                          text: !isGeneralRating ? '?' : null,
                        )
                      ]),
                  textAlign: TextAlign.center,
                ),
              ),
              if (isGeneralRating)
                Padding(
                  padding: EdgeInsets.only(left: 4.0.w),
                  child: InkWell(
                    onTap: () => _showTooltip(context),
                    child: Icon(
                      Icons.info_outline,
                      key: _ratingKey,
                      size: 14.h,
                      color: PiixColors.twilightBlue,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 16.h),
          PiixRatingBarDeprecated(
            ratingValue: ratingValue,
            onRatingUpdate: onRatingUpdate,
            itemSize: isGeneralRating ? 20.h : 30.h,
          ),
        ],
      ),
    );
  }

  void _showTooltip(BuildContext context) {
    PiixTooltipDeprecated(
      offsetKey: _ratingKey,
      backgroundColor: PiixColors.infoDefault,
      content: SizedBox(
        width: 240.w,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              PiixCopiesDeprecated.generalQualification,
              style: context.primaryTextTheme?.titleSmall?.copyWith(
                color: PiixColors.space,
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            Text(
              PiixCopiesDeprecated.generalQualificationDescription,
              style: context.textTheme?.labelMedium?.copyWith(
                color: PiixColors.space,
              ),
            ),
          ],
        ),
      ),
    ).controller?.showTooltip();
  }
}
