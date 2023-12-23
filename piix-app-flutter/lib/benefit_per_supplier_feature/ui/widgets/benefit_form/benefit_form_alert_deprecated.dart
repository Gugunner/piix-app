import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/domain/bloc/benefit_form_provider.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/utils/benefit_form_utils_deprecated.dart';
import 'package:piix_mobile/email_feature/domain/bloc/email_system_bloc.dart';
import 'package:piix_mobile/ui/common/piix_alert.dart';
import 'package:provider/provider.dart';

///This is alert for benefit form
///
class BenefitFormAlert extends ConsumerWidget {
  const BenefitFormAlert({super.key, this.onPressed});
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final benefitFormNotifier = ref.watch(benefitFormProvider);
    final emailSystemBLoC = context.watch<EmailSystemBLoC>();
    final benefitFormState = benefitFormNotifier.benefitFormState;
    final emailState = emailSystemBLoC.emailState;
    return PiixAlert(
      title: benefitFormState.alertTitle,
      message: alertMessage(benefitFormState, emailState),
      icon: benefitFormState.alertIcon,
      iconColor: benefitFormState.alertColor,
      buttonText: benefitFormState.alertButtonText,
      onPressed: onPressed,
      closeButton: true,
    );
  }
}
