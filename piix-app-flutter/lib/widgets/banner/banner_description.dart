import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

///A width constrained [Text] that acts as the message
///for a banner.
class BannerDescription extends StatelessWidget {
  const BannerDescription(this.description, {super.key});

  ///The value shown inside the [Text]
  final String description;

  ///The actual color of the [Text].
  @protected
  Color get _color => PiixColors.space;
  //The constrained max width for the [Text].
  @protected
  double get _maxWidth => 224.w;

  ///The maximum number of lines for the [Text] in
  ///case it overflows.
  @protected
  int get _maxLines => 5;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: _maxWidth,
        // minWidth: _maxWidth,
      ),
      child: Text(
        description,
        style: context.bodyMedium?.copyWith(
          color: _color,
        ),
        maxLines: _maxLines,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.start,
      ),
    );
  }
}
