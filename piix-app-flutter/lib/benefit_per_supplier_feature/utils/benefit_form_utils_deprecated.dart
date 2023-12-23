import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piix_mobile/auth_feature/domain/model/user_app_model.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/data/repository/benefit_form_repository_deprecated.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/domain/bloc/benefit_form_provider.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/domain/bloc/benefit_per_supplier_bloc_deprecated.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/domain/model/benefit_per_supplier_model_deprecated.dart';
import 'package:piix_mobile/email_feature/data/repository/email_system_repository.dart';
import 'package:piix_mobile/general_app_feature/di/service_locator.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/form_feature/domain/model/form_model_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/membership_provider_deprecated.dart';

///Gets the welcome text for the form.
String getWelcomeFormText({
  required UserAppModel? user,
  required String benefitName,
  required String supplierName,
}) {
  return 'Hola, ${user?.displayName ?? '-'}, completa la siguiente '
      'información para que puedas hacer efectivo tu beneficio de '
      '${benefitName.toUpperCase()}, prestado por el proveedor '
      '${supplierName.toUpperCase()}';
}

Future<void> onSendBenefitForm({
  required UserAppModel user,
  required String packageId,
  required FormModelOld benefitForm,
  required ByteData screenshotForm,
  required WidgetRef ref,
}) async {
  final benefitNotifier = ref.read(benefitFormProvider);
  final benefitPerSupplierBLoC = getIt<BenefitPerSupplierBLoCDeprecated>();
  final answers = await benefitNotifier.processBenefitFormAnswers(
    benefitForm: benefitForm,
    screenshotForm: screenshotForm,
  );
  if (answers.isEmpty) {
    throw Exception(
        'Answers are empty due to errors in processBenefitFormAnswers');
  }
  await benefitNotifier.sendBenefitForm(
    user: user,
    packageId: packageId,
    benefitForm: benefitForm,
    answers: answers,
    benefitPerSupplierId: benefitPerSupplierBLoC.benefitPerSupplierId,
    cobenefitPerSupplierId: benefitPerSupplierBLoC.cobenefitPerSupplierId,
    additionalBenefitPerSupplierId:
        benefitPerSupplierBLoC.additionalBenefitPerSupplierId,
  );
  if (benefitNotifier.benefitFormState != BenefitFormStateDeprecated.sent) {
    return;
  }
  final selectedCobenefitPerSupplier =
      benefitPerSupplierBLoC.selectedCobenefitPerSupplier;
  if (benefitPerSupplierBLoC.selectedCobenefitPerSupplier != null) {
    benefitPerSupplierBLoC.setSelectedCobenefitPerSupplier(
      selectedCobenefitPerSupplier?.copyWith(
        userHasAlreadySignedTheBenefitForm: true,
      ),
    );
    if (benefitPerSupplierBLoC.selectedCobenefitPerSupplier == null) return;
    final newBenefitPerSupplier = benefitPerSupplierBLoC
        .selectedBenefitPerSupplier
        ?.setCobenefitPerSupplier(
            benefitPerSupplierBLoC.selectedCobenefitPerSupplier!);
    benefitPerSupplierBLoC.setSelectedBenefitPerSupplier(newBenefitPerSupplier);
    return;
  }
  final selectedBenefitPerSupplier =
      benefitPerSupplierBLoC.selectedBenefitPerSupplier;
  benefitPerSupplierBLoC.setSelectedBenefitPerSupplier(
    selectedBenefitPerSupplier?.copyWith(
      userHasAlreadySignedTheBenefitForm: true,
    ),
  );
  final membershipInfoBLoC = getIt<MembershipProviderDeprecated>();
  final membership = membershipInfoBLoC.selectedMembership;
  if (membership == null) return;
  final benefitsPerSupplier = membership.benefitsPerSupplier;
  final index = benefitsPerSupplier.indexWhere((element) =>
      element.benefitPerSupplierId ==
      benefitPerSupplierBLoC.selectedBenefitPerSupplier!.benefitPerSupplierId);
  if (index < 0) return;
  final newBenefitPerSupplier = benefitsPerSupplier[index]
      .copyWith(userHasAlreadySignedTheBenefitForm: true);
  membership.benefitsPerSupplier[index] = newBenefitPerSupplier;
  membershipInfoBLoC.setSelectedMembership(membership);
  return;
}

extension BenefitFormStateExtended on BenefitFormStateDeprecated {
  String? get alertTitle {
    switch (this) {
      case BenefitFormStateDeprecated.notFound:
      case BenefitFormStateDeprecated.retrievedError:
      case BenefitFormStateDeprecated.sendError:
        return PiixCopiesDeprecated.appFailure;
      case BenefitFormStateDeprecated.sent:
        return PiixCopiesDeprecated.successfulSave;
      default:
        return null;
    }
  }

  IconData? get alertIcon {
    switch (this) {
      case BenefitFormStateDeprecated.notFound:
      case BenefitFormStateDeprecated.retrievedError:
      case BenefitFormStateDeprecated.sendError:
        return Icons.error;
      case BenefitFormStateDeprecated.sent:
        return Icons.check;

      default:
        return null;
    }
  }

  Color? get alertColor {
    switch (this) {
      case BenefitFormStateDeprecated.notFound:
      case BenefitFormStateDeprecated.retrievedError:
      case BenefitFormStateDeprecated.sendError:
        return PiixColors.errorMain;
      case BenefitFormStateDeprecated.sent:
        return PiixColors.successMain;
      default:
        return null;
    }
  }

  String? get alertButtonText {
    switch (this) {
      case BenefitFormStateDeprecated.notFound:
      case BenefitFormStateDeprecated.retrievedError:
      case BenefitFormStateDeprecated.sendError:
        return PiixCopiesDeprecated.tryAgain;
      case BenefitFormStateDeprecated.sent:
        return PiixCopiesDeprecated.okButton;
      default:
        return null;
    }
  }
}

///This method gets a alert message depends of different states
///
String? alertMessage(
    BenefitFormStateDeprecated benefitFormState, EmailState emailState) {
  if (benefitFormState == BenefitFormStateDeprecated.notFound) {
    return PiixCopiesDeprecated.formNotFound;
  } else if (benefitFormState == BenefitFormStateDeprecated.retrievedError) {
    return PiixCopiesDeprecated.formNotRetrieved;
  } else if (benefitFormState == BenefitFormStateDeprecated.sendError) {
    return PiixCopiesDeprecated.saveErrorForm;
  } else if (emailState == EmailState.idle) {
    return PiixCopiesDeprecated.formSentNoEmailRegistered;
  } else if (emailState == EmailState.conflict ||
      emailState == EmailState.error) {
    return PiixCopiesDeprecated.formSentNoEmailSent;
  } else if (emailState == EmailState.sent) {
    return PiixCopiesDeprecated.formSent;
  } else if (benefitFormState == BenefitFormStateDeprecated.sent) {
    return PiixCopiesDeprecated.succesSaveForm;
  }
  return null;
}
