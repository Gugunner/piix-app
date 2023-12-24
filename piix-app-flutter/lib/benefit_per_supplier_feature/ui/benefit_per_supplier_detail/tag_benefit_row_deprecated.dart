import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/domain/bloc/benefit_form_provider.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/domain/bloc/benefit_per_supplier_bloc_deprecated.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/domain/model/benefit_per_supplier_model_deprecated.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/ui/benefit_form_screen_deprecated.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/utils/branch_type_enum.dart';
import 'package:piix_mobile/extensions/widget_extend.dart';
import 'package:piix_mobile/protected_feature_deprecated/domain/bloc/protected_provider.dart';
import 'package:piix_mobile/ui/common/piix_tag.dart';
import 'package:piix_mobile/ui/common/piix_tag_store.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/utils/piix_memberships_util_deprecated.dart';
import 'package:provider/provider.dart';

@Deprecated('No longer in use in 4.0')

/// Shows a container with all tags of benefit (type benefit tag, benefit
/// icon tag, sign tag).
class TagBenefitRowDeprecated extends ConsumerWidget {
  const TagBenefitRowDeprecated({
    Key? key,
    required this.benefitPerSupplier,
    this.isCoBenefit = false,
  }) : super(key: key);
  final BenefitPerSupplierModel benefitPerSupplier;
  final bool isCoBenefit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final benefitFormNotifier = ref.read(benefitFormProvider);
    final benefitPerSupplierBLoC =
        context.watch<BenefitPerSupplierBLoCDeprecated>();
    final protectedBLoC = context.watch<ProtectedProvider>();
    final shouldBlockActions = protectedBLoC.shouldBlockMainUserActions;
    final benefitTypeName = benefitPerSupplier.benefitType?.name ?? '';
    final benefitType = benefitPerSupplier.benefitType;
    return Padding(
      padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(12)),
      child: Row(
        children: [
          SizedBox(
            child: PiixTagStoreDeprecated(
              text: getBenefitTypeCopy(benefitTypeName),
              backgroundColor: getBenefitTypeColor(benefitTypeName),
              icon: Icon(
                getBenefitTypeIcon(benefitTypeName),
                color: PiixColors.white,
                size: 14.sp,
              ),
            ).padOnly(right: 4.w),
          ),
          PiixTagStoreDeprecated(
            backgroundColor: PiixColors.coolGrey,
            icon: Icon(
              benefitType?.branchType.icon ?? BranchType.emergency.icon,
              color: PiixColors.white,
              size: 14.sp,
            ),
          ),
          const Spacer(
            flex: 2,
          ),
          if (benefitPerSupplier.hasBenefitForm &&
              !benefitPerSupplier.userHasAlreadySignedTheBenefitForm &&
              !shouldBlockActions)
            Expanded(
              flex: 3,
              child: PiixTagDeprecated(
                text: getSignLabelByFlags(
                    benefitPerSupplier.userHasAlreadySignedTheBenefitForm,
                    benefitPerSupplier.needsBenefitFormSignature,
                    addHereToText: true),
                backgroundColor: getColorLabelByFlags(
                  benefitPerSupplier.userHasAlreadySignedTheBenefitForm,
                  benefitPerSupplier.needsBenefitFormSignature,
                ),
                action: () {
                  benefitFormNotifier.currentBenefitFormId =
                      benefitPerSupplier.benefitFormId;
                  benefitPerSupplierBLoC.isCobenefit = true;
                  Navigator.of(context).pushNamed(
                    BenefitFormScreenDeprecated.routeName,
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
