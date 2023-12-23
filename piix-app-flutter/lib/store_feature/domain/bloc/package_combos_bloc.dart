import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:piix_mobile/enums/enums.dart';
import 'package:piix_mobile/utils/api/app_api_log_exception.dart';
import 'package:piix_mobile/general_app_feature/di/service_locator.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_logger/piix_logger.dart';
import 'package:piix_mobile/store_feature/data/repository/package_combos/package_combos_repository.dart';
import 'package:piix_mobile/store_feature/domain/model/quote_price_request_model/combo_quote_price_request_model.dart';
import 'package:piix_mobile/store_feature/domain/model/combo_model.dart';

///This BLoC is where all te package combos logic is located
///
class PackageComboBLoC with ChangeNotifier {
  ///Stores the [PackageCombosState] and is used by all the
  ///methods that call an api inside [PackageCombosState]
  PackageCombosState _packageComboState = PackageCombosState.idle;
  PackageCombosState get packageComboState => _packageComboState;
  set packageComboState(PackageCombosState state) {
    _packageComboState = state;
    notifyListeners();
  }

  ///Stores the [GeneralQuotationStateDeprecated] and is used by quotation methods
  GeneralQuotationStateDeprecated _packageComboQuotationState =
      GeneralQuotationStateDeprecated.idle;
  GeneralQuotationStateDeprecated get packageComboQuotationState =>
      _packageComboQuotationState;
  set packageComboQuotationState(GeneralQuotationStateDeprecated state) {
    _packageComboQuotationState = state;
    notifyListeners();
  }

  ///Stores the list of all [ComboModel]
  List<ComboModel> _packageCombosList = [];
  List<ComboModel> get packageCombosList => _packageCombosList;
  void setPackageCombosList(List<ComboModel> list) {
    _packageCombosList = list;
    notifyListeners();
  }

  ///Store the current [ComboModel]
  ComboModel? _currentPackageCombo;
  ComboModel? get currentPackageCombo => _currentPackageCombo;
  void setCurrentPackageCombo(ComboModel? value) {
    _currentPackageCombo = value;
    notifyListeners();
  }

  ///Stores the apackage combo by id [ComboModel]
  ComboModel? _packageComboWithPrices;
  ComboModel? get packageComboWithPrices => _packageComboWithPrices;
  void setPackageComboWithPrices(ComboModel? value) {
    _packageComboWithPrices = value;
    notifyListeners();
  }

  ///Stores the apackage combo  id
  String? _currentPackageComboId;
  String? get currentPackageComboId => _currentPackageComboId;
  set currentPackageComboId(String? id) {
    _currentPackageComboId = id;
    notifyListeners();
  }

  ///Instantiated a service locator for [PackageCombosRepository]
  ///
  PackageCombosRepository get _packageComboRepository =>
      getIt<PackageCombosRepository>();

  ///Retrieves the detailed information of a package combo
  /// by calling [_packageComboRepository] getPackageCombosByMembership
  /// method.
  ///
  /// Stores the package combo list in [packageCombosList]
  ///  and establishes the [PackageCombosState] accomplished
  /// if the request is successful.
  ///
  /// If the request is not successful it either sets [PackageCombosState]
  /// in [packageComboState] as error, conflict, notFound or unexpectedError.
  /// These states can be set since the service response can be conflict,
  ///  not found or unexpectedError;
  ///
  Future<void> getPackageCombosByMembership({
    required String membershipId,
  }) async {
    try {
      packageComboState = PackageCombosState.getting;
      final data = await _packageComboRepository.getPackageCombosByMembership(
          membershipId: membershipId);

      if (data is PackageCombosState) {
        packageComboState = data;
      } else {
        final List<dynamic> dataList = data;
        final combos = dataList.map(
          (d) {
            d['modelType'] = 'default';
            return ComboModel.fromJson(d);
          },
        ).toList();
        setPackageCombosList(combos);
        if (packageCombosList.isNotEmpty) {
          packageComboState = PackageCombosState.accomplished;
        } else {
          packageComboState = PackageCombosState.empty;
        }
      }
    } catch (e) {
      final loggerInstance = PiixLogger.instance;
      final logMessage = loggerInstance.errorMessage(
        messageName: 'Error in getPackageCombosByMembership '
            'with id $membershipId',
        message: e.toString(),
        isLoggable: isApiException(e),
      );
      loggerInstance.log(
        logMessage: logMessage.toString(),
        error: e,
        level: Level.error,
        sendToCrashlytics: true,
      );
      packageComboState = PackageCombosState.error;
    }
  }

  ///Retrieves the detailed information of a package combo
  /// by calling [_packageComboRepository]
  /// getPackageCombosWithDetailsAndPriceByMembership method.
  ///
  /// Stores the package combo by id in [packageComboById]
  ///  and establishes the [PackageCombosState] accomplished
  /// if the request is successful.
  ///
  /// If the request is not successful it either sets [PackageCombosState]
  /// in [packageComboState] as error, conflict, notFound or unexpectedError.
  /// These states can be set since the service response can be conflict,
  ///  not found or unexpectedError
  ///
  Future<void> getPackageCombosWithDetailsAndPriceByMembership(
      {required ComboQuotePriceRequestModel requestModel}) async {
    try {
      packageComboQuotationState = GeneralQuotationStateDeprecated.getting;
      final data = await _packageComboRepository
          .getPackageCombosWithDetailsAndPriceByMembership(
        requestModel: requestModel,
      );
      if (data is GeneralQuotationStateDeprecated) {
        packageComboQuotationState = data;
      } else {
        if (data == null) {
          setPackageComboWithPrices(data);
          packageComboQuotationState = GeneralQuotationStateDeprecated.empty;
        } else {
          setPackageComboWithPrices(ComboModel.fromJson(data));
          packageComboQuotationState =
              GeneralQuotationStateDeprecated.accomplished;
        }
      }
    } catch (e) {
      final loggerInstance = PiixLogger.instance;
      final logMessage = loggerInstance.errorMessage(
        messageName: 'Error in '
            'getPackageCombosWithDetailsAndPriceByMembership '
            'with id membership ${requestModel.membershipId}'
            ' and package combo id ${requestModel.packageComboId} ',
        message: e.toString(),
        isLoggable: isApiException(e),
      );
      loggerInstance.log(
        logMessage: logMessage.toString(),
        error: e,
        level: Level.error,
        sendToCrashlytics: true,
      );
      packageComboQuotationState = GeneralQuotationStateDeprecated.error;
    }
  }
}
