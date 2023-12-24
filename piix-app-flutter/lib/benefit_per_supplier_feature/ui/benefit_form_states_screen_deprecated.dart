import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/data/repository/benefit_form_repository_deprecated.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/domain/bloc/benefit_form_provider.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/ui/widgets/benefit_form/benefit_form_alert_deprecated.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/ui/widgets/benefit_form_data_deprecated.dart';
import 'package:piix_mobile/general_app_feature/data/repository/file_system_repository_deprecated.dart';
import 'package:piix_mobile/general_app_feature/domain/bloc/file_system_bloc.dart';
import 'package:piix_mobile/ui/common/blue_gradient_container.dart';
import 'package:piix_mobile/ui/common/piix_full_loader_deprecated.dart';
import 'package:piix_mobile/ui/common/white_gradient_container_deprecated.dart';
import 'package:provider/provider.dart';

@Deprecated('No longer in use in 4.0')

///This screens depends a benefit form states shows different screen.
///
class BenefitFormStatesScreen extends ConsumerWidget {
  const BenefitFormStatesScreen({
    super.key,
    required this.onSubmitForm,
    required this.onConfirm,
  });
  final VoidCallback onSubmitForm;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final benefitFormNotifier = ref.watch(benefitFormProvider);
    final fileSystemBLoC = context.watch<FileSystemBLoC>();
    final fileState = fileSystemBLoC.fileState;
    final benefitFormState = benefitFormNotifier.benefitFormState;
    return Stack(
      children: [
        const BlueGradientContainerDeprecated(hasHeightSpacer: false),
        const WhiteGradientContainerDeprecated(),
        Align(
          alignment: Alignment.center,
          child: Builder(
            builder: (context) {
              if (benefitFormState == BenefitFormStateDeprecated.retrieving ||
                  benefitFormState == BenefitFormStateDeprecated.sending ||
                  fileState == FileStateDeprecated.retrieving) {
                return const PiixFullLoaderDeprecated();
              }
              if (benefitFormNotifier.benefitFormState ==
                  BenefitFormStateDeprecated.retrieved) {
                return BenefitFormDataDeprecated(
                  onConfirm: onConfirm,
                  onSubmitForm: onSubmitForm,
                );
              }
              return const SizedBox();
            },
          ),
        ),
        if (benefitFormNotifier.benefitFormState ==
                BenefitFormStateDeprecated.sent ||
            benefitFormNotifier.benefitFormState ==
                BenefitFormStateDeprecated.retrievedError ||
            benefitFormNotifier.benefitFormState ==
                BenefitFormStateDeprecated.notFound ||
            benefitFormNotifier.benefitFormState ==
                BenefitFormStateDeprecated.sendError)
          BenefitFormAlert(
            onPressed: onConfirm,
          )
      ],
    );
  }
}
