import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

///A width constrained [Text] that acts as the header
///for a banner.
class BannerTitle extends StatelessWidget {
  const BannerTitle(this.text, {super.key});

  ///The actual value shown in the [Text].
  final String text;

  ///The actual color of the [Text].
  @protected
  Color get _color => PiixColors.space;
  ///The constrained max width for the [Text].
  @protected
  double get _maxWidth => 240.w;
  ///The maximum number of lines for the [Text] in
  ///case it overflows.
  @protected
  int get _maxLines => 1;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: _maxWidth,
        minWidth: _maxWidth,
      ),
      child: Text(
        text,
        style: context.primaryTextTheme?.headlineSmall?.copyWith(
          color: _color,
        ),
        maxLines: _maxLines,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.start,
      ),
    );
  }
}
