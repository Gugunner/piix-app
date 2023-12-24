import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/extensions/widget_extend.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/store_feature/domain/bloc/plans_bloc_deprecated.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

///This tile contains the number of protected to add in plan quotation
///
class PlanProtectedTileDeprecated extends StatelessWidget {
  const PlanProtectedTileDeprecated({super.key});

  @override
  Widget build(BuildContext context) {
    final plansBLoC = context.read<PlansBLoCDeprecated>();
    final planQuotation = plansBLoC.planQuotation;
    final protectedAdded = planQuotation!.plans
        .map((e) => e.protectedAcquired)
        .reduce((value, element) => value + element);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          PiixCopiesDeprecated.protectedText,
          style: context.primaryTextTheme?.headlineSmall,
        ).padBottom(4.h),
        Text(
          '${PiixCopiesDeprecated.numberProtectedToAdd}: ${protectedAdded}',
          style: context.textTheme?.bodyMedium,
        )
      ],
    );
  }
}
