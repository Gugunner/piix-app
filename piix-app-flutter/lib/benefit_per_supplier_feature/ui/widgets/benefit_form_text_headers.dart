import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/domain/bloc/benefit_form_provider.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/domain/bloc/benefit_per_supplier_bloc_deprecated.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/utils/benefit_form_utils_deprecated.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/circular_image_container.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/user_bloc_deprecated.dart';
import 'package:provider/provider.dart';

@Deprecated('No longer in use in 4.0')

///This widget shows a text headers for a benefit form.
///
class BenefitFormTextHeadersDeprecated extends ConsumerWidget {
  const BenefitFormTextHeadersDeprecated({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = context.watch<UserBLoCDeprecated>().user;
    final benefitFormNotifier = ref.watch(benefitFormProvider);
    final benefitPerSupplierBLoC =
        context.watch<BenefitPerSupplierBLoCDeprecated>();

    final welcomeText = getWelcomeFormText(
      user: user,
      benefitName: benefitPerSupplierBLoC.currentBenefitName,
      supplierName: benefitPerSupplierBLoC.supplierName,
    );
    final labelStyle = context.textTheme?.titleMedium;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          welcomeText,
          style: labelStyle,
          textAlign: TextAlign.justify,
        ),
        SizedBox(height: 8.h),
        Text(
          PiixCopiesDeprecated.requiredFieldsInstruction,
          style: labelStyle,
          textAlign: TextAlign.left,
        ),
        SizedBox(height: 24.h),
        Center(
          child: CircularImageContainer(
              pathImage: benefitPerSupplierBLoC.supplierLogo),
        ),
        SizedBox(height: 24.h),
        const Divider(),
        Text(
          benefitFormNotifier.benefitForm?.name ?? '',
          style: context.textTheme?.headlineMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
