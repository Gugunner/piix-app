import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

///A round bubble with a center number value [count].
final class AlertBubble extends StatelessWidget {
  const AlertBubble(this.count, {super.key}) : assert(count <= 130);

  final int count;

  ///The default color of the bubble.
  @protected
  Color get _color => PiixColors.error;

  ///The widht of the [Container].
  @protected
  double get _width => 20.w;

  ///The height of the [Container].
  @protected
  double get _height => 20.w;

  ///The maximum value [count] can have.
  @protected
  int get _maxCount => 99;

  ///Returns the [_maxCount] if [count] exceeds its value if
  ///not it returns [count].
  @protected
  int get _limitedCount => count > _maxCount ? _maxCount : count;

  @override
  Widget build(BuildContext context) {
    if (count == 0) return const SizedBox();
    return Container(
      decoration: BoxDecoration(
        color: _color,
        shape: BoxShape.circle,
      ),
      width: _width,
      height: _height,
      child: Center(
        child: Text(
          '${_limitedCount}',
          style: context.bodyMedium?.copyWith(
            color: PiixColors.space,
          ),
          maxLines: 1,
        ),
      ),
    );
  }
}
