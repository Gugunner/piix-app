import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/domain/model/benefit_per_supplier_model_deprecated.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/utils/branch_type_enum.dart';
import 'package:piix_mobile/extensions/widget_extend.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/utils/piix_memberships_util_deprecated.dart';
import 'package:piix_mobile/ui/common/piix_tag_store.dart';

@Deprecated('Will be removed in 4.0')

///This widget render an additional benefits per supplier tags, includes type
///tag and icon tag
///
class BenefitTagsRowDeprecated extends StatelessWidget {
  const BenefitTagsRowDeprecated({
    super.key,
    required this.additionalBenefitPerSupplier,
    this.reverse = false,
  });
  final BenefitPerSupplierModel? additionalBenefitPerSupplier;
  final bool reverse;

  MainAxisAlignment get mainAxisAlignment =>
      reverse ? MainAxisAlignment.end : MainAxisAlignment.start;
  TextDirection get textDirection =>
      reverse ? TextDirection.rtl : TextDirection.ltr;
  double get paddingLeft => reverse ? 8.w : 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      textDirection: textDirection,
      children: [
        PiixTagStoreDeprecated(
          text: getBenefitTypeCopy(
              additionalBenefitPerSupplier?.benefitType?.name ?? ''),
          backgroundColor: getBenefitTypeColor(
              additionalBenefitPerSupplier?.benefitType?.name ?? ''),
          icon: Icon(
            getBenefitTypeIcon(
                additionalBenefitPerSupplier?.benefitType?.name ?? ''),
            color: PiixColors.white,
            size: 14.sp,
          ),
          labelStyle: context.textTheme?.bodyMedium?.copyWith(
            color: PiixColors.space,
          ),
        ).padOnly(right: 8.w, left: paddingLeft),
        PiixTagStoreDeprecated(
          backgroundColor: PiixColors.coolGrey,
          icon: Icon(
            additionalBenefitPerSupplier?.benefitType?.branchType.icon ??
                BranchType.emergency.icon,
            color: PiixColors.white,
            size: 14.sp,
          ),
          horizontalPadding: 10,
        ),
      ],
    );
  }
}
