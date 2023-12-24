import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/domain/model/benefit_per_supplier_model_deprecated.dart';
import 'package:piix_mobile/enums/enums.dart';
import 'package:piix_mobile/store_feature/utils/combos.dart';
import 'package:piix_mobile/ui/common/piix_tag_store.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/utils/piix_memberships_util_deprecated.dart';

@Deprecated('Will be removed in 4.0')

///This widget render all types of benefit in a tags
///
class PackageComboTagsRowDeprecated extends StatelessWidget {
  const PackageComboTagsRowDeprecated({
    super.key,
    required this.additionalBenefitsPerSupplier,
    this.type = ComboRow.list,
  });
  final List<BenefitPerSupplierModel> additionalBenefitsPerSupplier;
  final ComboRow type;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: [
        ...additionalBenefitsPerSupplier
            .getAdditionalBenefitsNames()
            .map((name) => SizedBox(
                  child: PiixTagStoreDeprecated(
                    text: getBenefitTypeCopy(name),
                    backgroundColor: getBenefitTypeColor(name),
                    icon: Icon(
                      getBenefitTypeIcon(name),
                      color: PiixColors.white,
                      size: 14.sp,
                    ),
                  ),
                )),
        if (type == ComboRow.detail)
          ...additionalBenefitsPerSupplier.getUniqueBranchTypes().map(
                (branchType) => SizedBox(
                  child: PiixTagStoreDeprecated(
                    backgroundColor: PiixColors.secondary_dark,
                    icon: Icon(
                      branchType.icon,
                      color: PiixColors.white,
                      size: 14.sp,
                    ),
                    horizontalPadding: 8.w,
                  ),
                ),
              ),
      ],
    );
  }
}
