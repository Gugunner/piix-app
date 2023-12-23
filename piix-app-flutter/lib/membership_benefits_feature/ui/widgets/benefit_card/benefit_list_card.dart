// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:piix_mobile/membership_benefits_feature/utils/membership_benefits_model_barrel_file.dart';
import 'package:piix_mobile/widgets/app_card/app_card_deprecated.dart';

class BenefitListCard extends AppCardOld {
  BenefitListCard({
    super.key,
    this.benefitPerSupplierModel,
  }) : super(
          child: _BenefitListCardContent(benefitPerSupplierModel),
          width: 288.w,
        );

  final LastGradeBenefitPerSupplierModel? benefitPerSupplierModel;
}

class _BenefitListCardContent extends ConsumerWidget {
  final LastGradeBenefitPerSupplierModel? benefitPerSupplierModel;
  const _BenefitListCardContent(this.benefitPerSupplierModel);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 64.h,
      width: 288.w,
      child: Builder(builder: (context) {
        if (benefitPerSupplierModel == null) return const SizedBox();
        final benefitType = benefitPerSupplierModel!.benefitType;
        return Column(
          children: [
            Row(
              children: [
                benefitType.benefitType.tag,
                SizedBox(width: 8.w),
                benefitType.branchType.tag,
              ],
            ),
            Text(benefitPerSupplierModel!.benefit.name),
          ],
        );
      }),
    );
  }
}
