import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/extensions/widget_extend.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/store_feature/domain/bloc/levels_bloc_deprecated.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

///This widget render a texts thats contains a number of benefits in a level and
///number of protected have the user.
///
class LevelBenefitsTileDeprecated extends StatelessWidget {
  const LevelBenefitsTileDeprecated({super.key});

  @override
  Widget build(BuildContext context) {
    final levelsBLoC = context.read<LevelsBLoCDeprecated>();
    final levelQuotation = levelsBLoC.levelQuotation!;
    final levelInfo = levelQuotation.level;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          levelInfo.name,
          style: context.primaryTextTheme?.headlineSmall,
        ).padBottom(4.h),
        Text(
          PiixCopiesDeprecated.levelLabel,
          style: context.textTheme?.bodyMedium,
        ),
        Text(
          '${PiixCopiesDeprecated.newBenefitsReverse}: '
          '${levelQuotation.comparisonInformation.newBenefits.length}',
          style: context.textTheme?.bodyMedium,
        ),
      ],
    );
  }
}
