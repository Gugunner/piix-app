import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/claim_ticket_feature/utils/claim_ticket_utils.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/piix_html_parser.dart';

@Deprecated('Will be removed in 4.0')

///This widget render a step for a guide.
class PiixStepDeprecated extends StatelessWidget {
  const PiixStepDeprecated(
      {Key? key,
      required this.numberStep,
      required this.contentList,
      required this.titleStep,
      this.isVisible = true})
      : super(key: key);
  final String numberStep;
  final String titleStep;
  final List<String> contentList;
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 24.0.h,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Stack(
                children: [
                  Container(
                    width: 20.w,
                    height: 20.w,
                    decoration: const BoxDecoration(
                      color: PiixColors.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Positioned(
                    left: 6.w,
                    bottom: 3.w,
                    child: Text(
                      numberStep,
                      style: context.accentTextTheme?.titleMedium,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 8.w),
              Text(
                titleStep,
                style: context.primaryTextTheme?.titleSmall,
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 8.0.w,
                  ),
                  child: PiixHtmlParser(
                    html: generateUnOrderedHtmlList(contentList),
                    addDescriptionTag: false,
                    offsetY: -16,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
