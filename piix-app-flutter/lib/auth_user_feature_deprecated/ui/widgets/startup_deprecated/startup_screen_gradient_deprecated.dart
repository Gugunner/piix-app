import 'package:flutter/material.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';

@Deprecated('Remove in 4.0')
class StartupScreenGradientDeprecated extends StatelessWidget {
  const StartupScreenGradientDeprecated({super.key});

  List<Color> get topColors {
    final colors = <Color>[];
    for (var i = 0; i < 12; i++) {
      colors.add(const Color.fromRGBO(63, 61, 61, 0));
    }
    return colors;
  }

  List<Color> get bottomColors {
    final colors = <Color>[];
    for (var i = 0; i < 5; i++) {
      colors.add(PiixColors.white.withOpacity(0.8));
    }
    return colors;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      height: context.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            ...topColors,
            ...bottomColors,
          ],
          tileMode: TileMode.mirror,
        ),
      ),
    );
  }
}
