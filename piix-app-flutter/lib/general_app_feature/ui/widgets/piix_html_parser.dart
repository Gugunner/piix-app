import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

//TODO: Refactor class and check a better architecture for 4.0
///This widget render a benefit html description
///
class PiixHtmlParser extends StatelessWidget {
  const PiixHtmlParser({
    super.key,
    required this.html,
    this.offsetX = -8,
    this.offsetY = -4,
    this.addDescriptionTag = true,
    this.htmlStyle,
  });
  final String html;
  final Map<String, Style>? htmlStyle;
  final double offsetX;
  final double offsetY;
  final bool addDescriptionTag;

  String get makeHtmlDescription {
    if (html.isEmpty) return '';

    if (addDescriptionTag) {
      final hasParagraphTag =
          html.substring(0, 3) == PiixCopiesDeprecated.htmlParagraphTag;

      if (hasParagraphTag) {
        return '''${PiixCopiesDeprecated.htmlDescription} ${html.substring(3, html.length)}''';
      }
      return '''${PiixCopiesDeprecated.htmlDescription}$html ${PiixCopiesDeprecated.htmlParagraphTag}''';
    }
    return '''${PiixCopiesDeprecated.htmlParagraphTag}$html${PiixCopiesDeprecated.htmlParagraphTag}''';
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      child: SizedBox(
        width: context.width,
        child: Transform.translate(
          offset: Offset(offsetX.w, offsetY.h),
          child: Html(
            data: makeHtmlDescription,
            style: htmlStyle ??
                {
                  'p': Style(
                    padding: HtmlPaddings.zero,
                    margin: Margins.zero,
                    color: PiixColors.infoDefault,
                    fontFamily: 'Raleway',
                    fontSize: FontSize(
                      10.sp,
                    ),
                    letterSpacing: 0.01,
                    fontWeight: FontWeight.w400,
                    textAlign: TextAlign.justify,
                    lineHeight: LineHeight.em(1),
                  ),
                  'li': Style(
                    color: PiixColors.infoDefault,
                    fontFamily: 'Raleway',
                    fontSize: FontSize(
                      10.sp,
                    ),
                    letterSpacing: 0.01,
                    fontWeight: FontWeight.w400,
                    textAlign: TextAlign.justify,
                    lineHeight: LineHeight.em(1),
                  ),
                },
          ),
        ),
      ),
    );
  }
}
