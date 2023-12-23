import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:piix_mobile/form_feature/domain/model/form_field_model_deprecated.dart';
import 'package:piix_mobile/form_feature/domain/provider/form_provider_deprecated.dart';
import 'package:piix_mobile/form_feature/domain/model/form_model_deprecated.dart';
import 'package:piix_mobile/membership_verification_feature/data/membership_verification_service_repository.dart';
import 'package:piix_mobile/utils/app_copies_barrel_file.dart';
import 'package:piix_mobile/utils/log_utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'membership_verification_provider.g.dart';

@Deprecated('The enumerable is no longe in use')

///State that handles what should be shown in the
///documentation form texts and instructions.
enum CommunityType {
  none(),
  association(
    helperText: CommunityTypeCopies.associationHelperText,
    document: CommunityTypeCopies.associationDocument,
    formFieldName: CommunityTypeCopies.associationName,
    loadImageInstructions: CommunityTypeCopies.associationLoadImageInstructions,
    communityNameInstructions:
        CommunityTypeCopies.associationCommunityNameInstructions,
    idNumberInstructions: CommunityTypeCopies.associationIdNumberInstructions,
  ),
  congregation(
    helperText: CommunityTypeCopies.congregationHelperText,
    document: CommunityTypeCopies.congregationDocument,
    formFieldName: CommunityTypeCopies.congregationName,
    loadImageInstructions:
        CommunityTypeCopies.congregationLoadImageInstructions,
    communityNameInstructions:
        CommunityTypeCopies.congregationCommunityNameInstructions,
    idNumberInstructions: CommunityTypeCopies.congregationIdNumberInstructions,
  ),
  enterprise(
    helperText: CommunityTypeCopies.enterpriseHelperText,
    document: CommunityTypeCopies.enterpriseDocument,
    formFieldName: CommunityTypeCopies.enterpriseName,
    loadImageInstructions: CommunityTypeCopies.enterpriseLoadImageInstructions,
    communityNameInstructions:
        CommunityTypeCopies.enterpriseCommunityNameInstructions,
    idNumberInstructions: CommunityTypeCopies.entrepriseIdNumberInstructions,
  ),
  union(
    helperText: CommunityTypeCopies.unionHelperText,
    document: CommunityTypeCopies.unionDocument,
    formFieldName: CommunityTypeCopies.unionName,
    loadImageInstructions: CommunityTypeCopies.unionLoadImageInstructions,
    communityNameInstructions:
        CommunityTypeCopies.unionCommunityNameInstructions,
    idNumberInstructions: CommunityTypeCopies.unionIdNumberInstructions,
  ),
  localGovernment(
    helperText: CommunityTypeCopies.localGovernmentHelperText,
    document: CommunityTypeCopies.localGovernmentDocument,
    formFieldName: CommunityTypeCopies.localGovernmentName,
    loadImageInstructions:
        CommunityTypeCopies.localGovernmentLoadImageInstructions,
    communityNameInstructions:
        CommunityTypeCopies.localGovernmentCommunityNameInstructions,
    idNumberInstructions:
        CommunityTypeCopies.localGovernmentIdNumberInstructions,
  );

  final String? helperText;
  final String? formFieldName;
  final String? document;
  final String? loadImageInstructions;
  final String? communityNameInstructions;
  final String? idNumberInstructions;

  const CommunityType({
    this.helperText,
    this.formFieldName,
    this.document,
    this.loadImageInstructions,
    this.communityNameInstructions,
    this.idNumberInstructions,
  });

  bool get showCommunityInstructions => this != CommunityType.none;
}

@Deprecated('No longer in use')
@Riverpod(keepAlive: true)
class CommunityDeprecatedPod extends _$CommunityDeprecatedPod {
  @override
  CommunityType build() => CommunityType.none;

  void setCommunityType(CommunityType type) {
    state = type;
  }

  void updateCommunityType(
    FormFieldModelOld formField,
    BuildContext context,
  ) {
    //If the form field has no id, then the community specific
    //copies and instructions can't be shown
    if (formField.idResponse == null) {
      setCommunityType(CommunityType.none);
      return;
    }
    final communityType = CommunityType.values.firstWhere(
        (v) => v.name == formField.idResponse,
        orElse: () => CommunityType.none);
    final form = ref.read(formNotifierProvider);
    //According to the communityType the specific copies and texts
    //are added to the form fields
    final uniqueIdFormField = form
        ?.formFieldBy('uniqueId')
        ?.copyWith(name: communityType.formFieldName ?? '')
        .setHelperText(communityType.helperText ?? '');
    final documentFormField = form
        ?.formFieldBy('user_validation_documents')
        ?.setDocument(communityType.document ?? '');
    //If the uniqueId or user_validation_documents form field is not present,
    //then the community specific
    //copies and instructions can't be shown
    if (uniqueIdFormField == null || documentFormField == null) {
      setCommunityType(CommunityType.none);
      return;
    }
    //Replace the updated formFields in the form
    ref
        .read(formNotifierProvider.notifier)
        .replaceFormFields([uniqueIdFormField, documentFormField]);
    //If everything is correct then it updates the community type to
    //rebuild the UI
    setCommunityType(communityType);
  }
}

@riverpod
class MembershipVerificationServicePod
    extends _$MembershipVerificationServicePod with LogApiCall, LogAppCall {
  @override
  FutureOr<void> build() => _startMembershipVerification();

  Future<void> _startMembershipVerification() async {
    final repository =
        ref.read(membershipVerificationServiceRepositoryPodProvider.notifier);
    try {
      await repository.startMembershipVerification();
    } catch (error) {
      if (error is! DioException) {
        logError(error, className: 'SignUpSignInService');
        rethrow;
      }
      logDioException(error, className: 'SignUpSignInService');
      rethrow;
    }
  }
}
