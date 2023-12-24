import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/domain/model/benefit_per_supplier_model_deprecated.dart';
import 'package:piix_mobile/domain/model/benefits_by_type.dart';
import 'package:piix_mobile/utils/api/app_api_log_exception.dart';
import 'package:piix_mobile/general_app_feature/di/service_locator.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_logger/piix_logger.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/data/repository/membership_info_repository_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/model/membership_info_model.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/model/membership_model/membership_model_deprecated.dart';

@Deprecated('Will be removed in 4.0')

/// This BLoC is where all the package info logic is located.
class MembershipProviderDeprecated with ChangeNotifier {
  bool get isMainUserOfSelectedMembership =>
      selectedMembership?.isMainUser ?? false;
  bool get isActiveMembership => selectedMembership?.isActive ?? false;
  bool get showBottomAlerts =>
      isMainUserOfSelectedMembership && !isActiveMembership;
  bool get isSOSDisabled =>
      selectedMembership?.claimChatNumber == null &&
      selectedMembership?.claimPhoneNumber == null;
  bool get activateStore => selectedMembership?.activeStore ?? false;

  MembershipModelDeprecated? _selectedMembership;
  MembershipModelDeprecated? get selectedMembership => _selectedMembership;
  void setSelectedMembership(MembershipModelDeprecated? membership) {
    _selectedMembership = membership;
    setBenefitsByTypes(
      benefitsPerSupplier: selectedMembership?.benefitsPerSupplier,
    );
    notifyListeners();
  }

  MembershipModelDeprecated? _protectedMembership;
  MembershipModelDeprecated? get protectedMembership => _protectedMembership;
  void setProtectedMembership(MembershipModelDeprecated? membership) {
    _protectedMembership = membership;
    setBenefitsByTypes(
      benefitsPerSupplier: selectedMembership?.benefitsPerSupplier,
      isProtected: true,
    );
    notifyListeners();
  }

  bool get hasBenefitForms => _benefitsByTypes.any(
        (benefitByType) => (benefitByType.benefits ?? []).any((element) {
          final benefit = element.mapOrNull((value) => value);
          return benefit!.hasBenefitForm &&
              !benefit.userHasAlreadySignedTheBenefitForm;
        }),
      );

  List<BenefitsByType> _benefitsByTypes = [];
  List<BenefitsByType> _protectedBenefitsByTypes = [];
  List<BenefitsByType> get benefitsByTypes {
    if (_protectedBenefitsByTypes.isNotEmpty) return _protectedBenefitsByTypes;
    return _benefitsByTypes;
  }

  set protectedBenefitsByTypes(List<BenefitsByType> value) {
    _protectedBenefitsByTypes = value;
    notifyListeners();
  }

  set benefitsByTypes(List<BenefitsByType> value) {
    _benefitsByTypes = value;
    notifyListeners();
  }

  ///Stores the [MembershipInfoStateDeprecated] and is used by all the
  ///methods that call an api inside [MembershipProviderDeprecated]
  MembershipInfoStateDeprecated _membershipInfoState =
      MembershipInfoStateDeprecated.idle;
  MembershipInfoStateDeprecated get membershipInfoState => _membershipInfoState;
  set membershipInfoState(MembershipInfoStateDeprecated state) {
    _membershipInfoState = state;
    notifyListeners();
  }

  ///An injection that uses singleton to call the instantiated
  ///[MembershipInfoRepositoryDeprecated]
  MembershipInfoRepositoryDeprecated get _membershipInfoRepository =>
      getIt<MembershipInfoRepositoryDeprecated>();

  ///Retrieves the detailed information of a membership by calling
  ///[_membershipInfoRepository] getMembershipInfoRequested method.
  ///
  /// Stores the membership information in [membershipInfo] and establishes the
  /// [MembershipInfoStateDeprecated] retrieved if the request is successful.
  ///
  /// If the request is not successful it either sets [MembershipInfoStateDeprecated] in
  /// [membershipInfoState] as error or notFound.
  Future<void> getMembershipInfo({
    required MembershipModelDeprecated membership,
    bool isProtected = false,
  }) async {
    try {
      final membershipId = membership.membershipId;
      final requestModel =
          RequestMembershipInfoModel(membershipId: membershipId);
      membershipInfoState = MembershipInfoStateDeprecated.retrieving;
      final data = await _membershipInfoRepository
          .getMembershipInfoRequested(requestModel);
      if (data is MembershipInfoStateDeprecated) {
        membershipInfoState = data;
      } else {
        final blendedMembership = membership.blendMembership(data);
        if (isProtected) {
          setProtectedMembership(blendedMembership);
        } else {
          setSelectedMembership(blendedMembership);
        }
        membershipInfoState = data['state'];
      }
    } catch (e) {
      final loggerInstance = PiixLogger.instance;
      final logMessage = loggerInstance.errorMessage(
        messageName: 'Error in getMembershipInfo with id '
            '${membership.membershipId}',
        message: e.toString(),
        isLoggable: isApiException(e),
      );
      loggerInstance.log(
        logMessage: logMessage.toString(),
        error: e,
        level: Level.error,
        sendToCrashlytics: true,
      );
      membershipInfoState = MembershipInfoStateDeprecated.error;
    }
  }

  /// Get benefits filtered by type.
  void setBenefitsByTypes({
    required List<BenefitPerSupplierModel>? benefitsPerSupplier,
    bool isProtected = false,
  }) {
    final groupBenefits = benefitsPerSupplier
        ?.groupListsBy((element) => element.benefitType?.benefitType.name);
    if (groupBenefits == null) return;
    if (isProtected) {
      _protectedBenefitsByTypes = [];
    } else {
      _benefitsByTypes = [];
    }
    groupBenefits.forEach(
      (key, value) {
        value.sort(
          (a, b) => a.benefit.name.compareTo(b.benefit.name),
        );
        if (isProtected) {
          _protectedBenefitsByTypes.add(
            BenefitsByType(
              type: key,
              name: value[0].benefitType?.name,
              benefits: value,
            ),
          );
        } else {
          _benefitsByTypes.add(
            BenefitsByType(
              type: key,
              name: value[0].benefitType?.name,
              benefits: value,
            ),
          );
        }
      },
    );
    notifyListeners();
  }

  void clearProvider() {
    _selectedMembership = null;
    _protectedMembership = null;
    _benefitsByTypes = [];
    _membershipInfoState = MembershipInfoStateDeprecated.idle;
    notifyListeners();
  }
}
