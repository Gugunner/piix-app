import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

@Deprecated('Will be removed in 6.0')

///The widget can only be used inside of a [PiixObjectSelectDropDownButton] as
///it is a list of [String] characteristics for the selectable option that is
///translated to [String].
///
/// Each [PiixDropdownMenuCharacteristicsDeprecated] widget can contain at most 500
/// characters either in one [String] element of [values] or divided between
/// all elements of [values] including "\n" characters.
class PiixDropdownMenuCharacteristicsDeprecated extends StatelessWidget {
  const PiixDropdownMenuCharacteristicsDeprecated({
    Key? key,
    required this.value,
    required this.values,
  }) : super(key: key);

  ///The name that is presented as the option for the
  ///[PiixObjectSelectDropDownButton].
  ///This value should be the same as the value of [PiixDropdownMenuRadio] in
  ///order to work.
  final String value;

  ///The list of characteristics that will be presented as a multiple line
  ///[String].
  final List<String> values;

  ///Sets number of additional lines that can be added to the element
  ///to keep all characteristics visible.
  int get baseMaxLines => 6;

  ///Determines number of additional lines needed in the element to keep
  ///all characteristics visible
  int get baseMinLines => 2;

  ///The basic container height to be included when [baseMaxLines] is used.
  double baseContainerHeight(BuildContext context) =>
      stringHeight(context) * baseMaxLines;

  ///Determines the maximum number of characters per line to be calculated
  ///for the height of the widget.
  double get baseStringLength => 22;

  ///Replicates the same fontSize of the [TextTheme] to estimate the height of
  ///the line.
  double stringHeight(BuildContext context) =>
      context.textTheme?.bodyMedium?.fontSize ?? 11.sp;

  ///Receives a single [String] and gets the number of lines for the [Text]
  ///field.
  int estimateMaxLines(String displayCharacteristics) {
    final stringLength = displayCharacteristics.length;
    final maxLines = stringLength ~/ baseStringLength;
    return maxLines + baseMaxLines;
  }

  ///Receives a single [String] and returns the [Container] height for the
  ///widget.
  double estimateLineItemHeight(BuildContext context,
      {required String displayCharacteristics}) {
    final stringLength = displayCharacteristics.length;
    final numberOfLines = (stringLength ~/ baseStringLength);
    final containerHeight =
        (numberOfLines == 0 ? 1 : numberOfLines) * stringHeight(context);
    return (containerHeight);
  }

  ///Iterates the list of [values] and calculates the line height per element by
  ///calling [estimateLineItemHeight] adding at the end an additional container
  ///height based on the number of elements in [values].
  double estimateMultipleLinesHeight(BuildContext context) =>
      values
          .map(
              (c) => estimateLineItemHeight(context, displayCharacteristics: c))
          .reduce((value, element) => value + element) +
      (values.length == 1
          ? baseMinLines * stringHeight(context)
          : values.length < baseMaxLines
              ? (values.length + 1) * stringHeight(context)
              : baseContainerHeight(context));

  @override
  Widget build(BuildContext context) {
    final displayCharacteristics = '-' + values.join('\n-');
    final textStyle = context.textTheme?.bodyMedium?.copyWith(
      color: PiixColors.contrast,
    );
    return Container(
      //Need to estimate height to avoid infinite height if [Flexible] is used.
      height: estimateMultipleLinesHeight(context),
      padding: EdgeInsets.zero,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: textStyle,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(
                bottom: 15.h,
                top: 0,
                left: 0,
              ),
              child: Text(
                displayCharacteristics,
                softWrap: true,
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                maxLines: estimateMaxLines(displayCharacteristics),
                style: textStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
