import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/domain/bloc/benefit_form_provider.dart';
import 'package:piix_mobile/form_feature/domain/provider/form_provider_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

/// Button to save the form.
class SaveFormButton extends ConsumerWidget {
  const SaveFormButton({
    super.key,
    required this.onSubmit,
  });

  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final benefitFormNotifier = ref.watch(benefitFormProvider);
    final formNotifier = ref.read(formNotifierProvider.notifier);
    return Column(
      // mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          height: context.height * 0.023,
        ),
        Center(
          child: SizedBox(
            height: 34.h,
            width: 196.w,
            child: ElevatedButton(
              style: Theme.of(context).elevatedButtonTheme.style,
              onPressed: formNotifier.requiredFieldsFilled(
                      benefitFormNotifier.benefitFormFields)
                  ? onSubmit
                  : null,
              child: Text(
                PiixCopiesDeprecated.save,
                style: context.primaryTextTheme?.titleMedium?.copyWith(
                  color: PiixColors.space,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: context.height * 0.023,
        ),
      ],
    );
  }
}
