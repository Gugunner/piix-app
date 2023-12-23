import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/domain/bloc/benefit_form_provider.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/ui/widgets/benefit_form/save_form_button_deprecated.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/ui/widgets/benefit_form_text_headers.dart';
import 'package:piix_mobile/extensions/widget_extend.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/form_feature/ui/form_field_input_builder_deprecated.dart';

final GlobalKey repaintBenefitFormKey = GlobalKey();
final benefitFormKey = GlobalKey<FormState>();

@Deprecated('No longer in use in 4.0')

///This screen contains all form fields for benefit form, and title and save
///button form
///
class BenefitFormDataDeprecated extends ConsumerWidget {
  const BenefitFormDataDeprecated({
    super.key,
    required this.onSubmitForm,
    required this.onConfirm,
  });
  final VoidCallback onSubmitForm;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final benefitFormNotifier = ref.watch(benefitFormProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SingleChildScrollView(
              child: RepaintBoundary(
                key: repaintBenefitFormKey,
                child: Container(
                  color: PiixColors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16.h),
                      const BenefitFormTextHeadersDeprecated(),
                      SizedBox(height: 15.h),
                      Form(
                        key: benefitFormKey,
                        child: Column(
                          children: [
                            ...benefitFormNotifier.benefitFormFields.map(
                              (formField) => FormFieldInputBuilderDeprecated(
                                formField: formField,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ).padHorizontal(22.w),
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: PiixColors.greyWhite,
            child: SaveFormButton(
              onSubmit: onSubmitForm,
            ),
          ),
        ),
      ],
    );
  }
}
