import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:piix_mobile/domain/repository/protected_repository_interface.dart';
import 'package:piix_mobile/utils/api/app_api_log_exception.dart';
import 'package:piix_mobile/general_app_feature/di/service_locator.dart';
import 'package:piix_mobile/general_app_feature/domain/model/form_item_model.dart';
import 'package:piix_mobile/general_app_feature/domain/model/selector_model.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_logger/piix_logger.dart';
import 'package:piix_mobile/protected_feature_deprecated/data/repository/protected_repository.dart';
import 'package:piix_mobile/protected_feature_deprecated/domain/model/available_protected_slots_model/available_protected_slots_model.dart';
import 'package:piix_mobile/protected_feature_deprecated/domain/model/available_protected_slots_model/protected_slot_model.dart';

import 'package:piix_mobile/protected_feature_deprecated/domain/model/protected_model.dart';
import 'package:piix_mobile/protected_feature_deprecated/domain/model/request_available_protected_model.dart';

///This class is business logic componet for protected module.
class ProtectedProvider with ChangeNotifier {
  ProtectedProvider({
    this.interface,
  });
  final ProtectedRepositoryInterface? interface;

  ///Controls if the api requests call the real api or instead read from a
  ///fake response.
  bool _appTest = false;
  bool get appTest => _appTest;
  void setAppTest(bool value) {
    _appTest = value;
  }

  ProtectedState _protectedState = ProtectedState.idle;
  ProtectedState get protectedState => _protectedState;
  void setProtectedState(ProtectedState state) {
    _protectedState = state;
    notifyListeners();
  }

  bool get shouldBlockMainUserActions => selectedProtected != null;

  bool get hasNoProtected => (protectedsInfo?.protected ?? []).isEmpty;

  List<FormItemModel> _responseCsvItemsList = [];
  List<FormItemModel> get responseCsvItemsList => _responseCsvItemsList;
  set responseCsvItemsList(List<FormItemModel> list) {
    _responseCsvItemsList = list;
    notifyListeners();
  }

  final Map<String, FormItemModel> _responseCsvItemsMap = {};
  Map<String, FormItemModel> get responseCsvItemsMap {
    _responseCsvItemsList.forEach((element) {
      _responseCsvItemsMap[element.id!] = element;
    });
    return _responseCsvItemsMap;
  }

  AvailableProtectedSlotsModel? _protectedsInfo;
  AvailableProtectedSlotsModel? get protectedsInfo => _protectedsInfo;
  set protectedsInfo(AvailableProtectedSlotsModel? value) {
    _protectedsInfo = value;
    notifyListeners();
  }

  List<ProtectedModel> _protectedWithActiveMembership = [];
  List<ProtectedModel> get protectedWithActiveMembership =>
      _protectedWithActiveMembership;

  List<ProtectedModel> _protectedWithInactiveMembership = [];
  List<ProtectedModel> get protectedWithInactiveMembership =>
      _protectedWithInactiveMembership;

  ProtectedModel? _selectedProtected;
  ProtectedModel? get selectedProtected => _selectedProtected;
  set selectedProtected(ProtectedModel? value) {
    _selectedProtected = value;
    notifyListeners();
  }

  List<SelectorModel> _availableKinshipsToRegisterProtected = [];
  List<SelectorModel> get availableKinshipsToRegisterProtected =>
      _availableKinshipsToRegisterProtected;
  set availableKinshipsToRegisterProtected(List<SelectorModel> list) {
    _availableKinshipsToRegisterProtected = list;
    notifyListeners();
  }

  ProtectedRepository get _protectedRepository => getIt<ProtectedRepository>();

  Future<void> getAvailableProtected({
    required String membershipId,
    bool useFirebase = true,
  }) async {
    try {
      setProtectedState(ProtectedState.retrieving);
      final requestModel =
          RequestAvailableProtectedModel(membershipId: membershipId);
      final data = await _protectedRepository.getAvailableProtectedRequested(
        requestModel: requestModel,
        test: appTest,
        useFirebase: useFirebase,
      );
      if (data is ProtectedState) {
        setProtectedState(data);
        return;
      }
      final availableProtected = AvailableProtectedSlotsModel.fromJson(data);
      protectedsInfo = availableProtected;
      final protectedWithActiveMembership = <ProtectedModel>[];
      final protectedWithInactiveMembership = <ProtectedModel>[];
      for (final protected in availableProtected.protected) {
        final isActive = protected.membership?.isActive ?? false;
        if (isActive) {
          protectedWithActiveMembership.add(protected);
          continue;
        }
        protectedWithInactiveMembership.add(protected);
      }
      _protectedWithActiveMembership = protectedWithActiveMembership;
      _protectedWithInactiveMembership = protectedWithInactiveMembership;
      calculateAvailableKinshipsList(availableProtected.slots.protectedSlots);
      final protectedState = data['state'];
      setProtectedState(protectedState);
    } catch (e) {
      if (useFirebase) {
        final loggerInstance = PiixLogger.instance;
        final logMessage = loggerInstance.errorMessage(
          messageName: 'Error in getAvailableProtected',
          message: e.toString(),
          isLoggable: isApiException(e),
        );
        loggerInstance.log(
          logMessage: logMessage.toString(),
          error: e,
          level: Level.error,
          sendToCrashlytics: true,
        );
      }
      setProtectedState(ProtectedState.error);
    }
  }

  ///Get protected slots and register protected, set kiship list from slots.
  Future<void> getProtectedAndSlotsByMembershipId({
    required String membershipId,
  }) async {
    final response = await interface!
        .getProtectedAndSlotsByMembershipId(membershipId: membershipId);

    if (response.protected.isNotEmpty) {
      _protectedWithActiveMembership = response.protected
          .where((element) => (element.membership?.isActive ?? false))
          .toList();
      _protectedWithInactiveMembership = response.protected
          .where((element) => !(element.membership?.isActive ?? false))
          .toList();
    }
    calculateAvailableKinshipsList(response.slots.protectedSlots);
    _protectedsInfo = response;
    notifyListeners();
  }

  ///This function generate available kinship list
  void calculateAvailableKinshipsList(
      List<ProtectedSlotModel>? protectedSlotModel) {
    final kinshipList = <SelectorModel>[];
    if (protectedSlotModel == null || protectedSlotModel.isEmpty) return;
    for (final protected in protectedSlotModel) {
      if (protected.availableSlots <= 0) continue;
      kinshipList.add(
        SelectorModel(
          id: protected.kinship.kinshipId,
          folio: protected.kinship.kinshipId,
          name: protected.kinship.name,
        ),
      );
    }
    availableKinshipsToRegisterProtected = kinshipList;
  }

  void clearProvider() {
    _protectedWithActiveMembership = [];
    _protectedWithInactiveMembership = [];
    _responseCsvItemsList = [];
    _availableKinshipsToRegisterProtected = [];
    _protectedsInfo = null;
    _selectedProtected = null;
    _protectedState = ProtectedState.idle;
    notifyListeners();
  }
}
