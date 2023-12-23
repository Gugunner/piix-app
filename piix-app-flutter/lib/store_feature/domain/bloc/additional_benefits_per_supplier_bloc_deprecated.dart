import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/domain/model/benefit_per_supplier_model_deprecated.dart';
import 'package:piix_mobile/membership_benefits_feature/domain/model/benefit_type_model.dart';
import 'package:piix_mobile/enums/enums.dart';
import 'package:piix_mobile/utils/api/app_api_log_exception.dart';
import 'package:piix_mobile/general_app_feature/di/service_locator.dart';
import 'package:piix_mobile/file_feature/domain/model/file_model.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_logger/piix_logger.dart';
import 'package:piix_mobile/store_feature/data/repository/additional_benefits_per_supplier/additional_benefits_per_supplier_repository_deprecated.dart';
import 'package:piix_mobile/store_feature/domain/model/quote_price_request_model/additional_benefit_per_supplier_quote_price_request_model_deprecated.dart';
import 'package:piix_mobile/store_feature/utils/additional_benefit_per_supplier.dart';
import 'package:piix_mobile/store_feature/utils/combos.dart';

const List<String> _benefitTypes = ['A', 'S', 'X', 'Z'];

@Deprecated('Will be removed in 4.0')

/// This BLoC is where all the additional benefit per supplier logic is located.
class AdditionalBenefitsPerSupplierBLoCDeprecated with ChangeNotifier {
  ///Controls if the api requests call the real api or instead read from a
  ///fake response.
  bool _appTest = false;
  bool get appTest => _appTest;
  void setAppTest(bool value) {
    _appTest = value;
  }

  ///Stores the [AdditionalBenefitsPerSupplierStateDeprecated] and is used by all the
  ///methods that call an api inside [AdditionalBenefitsPerSupplierBLoCDeprecated]
  AdditionalBenefitsPerSupplierStateDeprecated
      _additionalBenefitPerSupplierState =
      AdditionalBenefitsPerSupplierStateDeprecated.idle;
  AdditionalBenefitsPerSupplierStateDeprecated
      get additionalBenefitPerSupplierState =>
          _additionalBenefitPerSupplierState;
  set additionalBenefitPerSupplierState(
      AdditionalBenefitsPerSupplierStateDeprecated state) {
    _additionalBenefitPerSupplierState = state;
    notifyListeners();
  }

  ///Stores the [GeneralQuotationStateDeprecated] and is used by quotation methods
  GeneralQuotationStateDeprecated _additionalBenefitQuotationState =
      GeneralQuotationStateDeprecated.idle;
  GeneralQuotationStateDeprecated get additionalBenefitQuotationState =>
      _additionalBenefitQuotationState;
  set additionalBenefitQuotationState(GeneralQuotationStateDeprecated state) {
    _additionalBenefitQuotationState = state;
    notifyListeners();
  }

  ///Stores the list of all [AdditionalBenefitsPerSupplier]
  List<BenefitPerSupplierModel> _additionalBenefitsPerSupplierList = [];
  List<BenefitPerSupplierModel> get additionalBenefitsPerSupplierList =>
      _additionalBenefitsPerSupplierList;
  void setAdditionalBenefitsPerSupplierList(
      List<BenefitPerSupplierModel> list) {
    _additionalBenefitsPerSupplierList = list.sortBenefits;
    notifyListeners();
  }

  BenefitTypeModel? _currentBenefitType;
  BenefitTypeModel? get currentBenefitType => _currentBenefitType;
  set currentBenefitType(BenefitTypeModel? value) {
    _currentBenefitType = value;
    notifyListeners();
  }

  BenefitPerSupplierModel? _currentAdditionalBenefitPerSupplier;
  BenefitPerSupplierModel? get currentAdditionalBenefitPerSupplier =>
      _currentAdditionalBenefitPerSupplier;
  void setCurrentAdditionalBenefitPerSupplier(BenefitPerSupplierModel? value) {
    _currentAdditionalBenefitPerSupplier = value;
    notifyListeners();
  }

  ///Stores the additional benefit per suplier by id [AdditionalBenefitsPerSupplier]
  String? _currentAdditionalBenefitPerSupplierId;
  String? get currentAdditionalBenefitPerSupplierId =>
      _currentAdditionalBenefitPerSupplierId;
  set currentAdditionalBenefitPerSupplierId(String? id) {
    _currentAdditionalBenefitPerSupplierId = id;
    notifyListeners();
  }

  List<List<BenefitPerSupplierModel>>
      _additionalBenefitsPerSupplierByBenefitType = [];

  ///Get the list of additional benefits per supplier to show
  List<List<BenefitPerSupplierModel>>
      get additionalBenefitsPerSupplierByBenefitType =>
          _additionalBenefitsPerSupplierByBenefitType;
  void groupAdditionalBenefitsPerSupplierByBenefitType() {
    final groupByType = <List<BenefitPerSupplierModel>>[];
    for (final benefitType in _benefitTypes) {
      final additionalBenefitsPerSupplierType =
          additionalBenefitsPerSupplierList.filterByType(benefitType);
      if (additionalBenefitsPerSupplierType.isNotEmpty) {
        groupByType.add(additionalBenefitsPerSupplierType);
      }
    }
    _additionalBenefitsPerSupplierByBenefitType = groupByType;
  }

  ///Get additional benefit per supplier list by type.
  ///
  List<BenefitPerSupplierModel>
      getAdditionalBenefitsPerSupplierByBenefitType() {
    final benefitTypeId = _currentBenefitType?.benefitType.name ?? '';
    final benefitTypeIndex =
        _benefitTypes.indexWhere((benefitType) => benefitType == benefitTypeId);
    if (benefitTypeId.isEmpty ||
        benefitTypeIndex < 0 ||
        _additionalBenefitsPerSupplierByBenefitType.isEmpty)
      return additionalBenefitsPerSupplierList;
    return additionalBenefitsPerSupplierByBenefitType[benefitTypeIndex];
  }

  ///This method set a supplier image logo in a additional benefit per supplier list
  ///
  void setAdditionalBenefitPerSupplierLogoFiles(List<FileModel?> list) {
    list.forEach((file) {
      final _name = file?.fileContent?.name.split('.')[0].split('/');
      if ((_name ?? []).length > 1) {
        final _id = _name?[1];
        final currentAdditionalBenefitIndex =
            additionalBenefitsPerSupplierList.indexWhere((additionalBenefit) =>
                additionalBenefit.benefitPerSupplierId == _id);
        if (currentAdditionalBenefitIndex > -1) {
          final base64Image = file?.fileContent?.base64Content;
          final additionalBenefitPerSupplier =
              additionalBenefitsPerSupplierList[currentAdditionalBenefitIndex];
          additionalBenefitPerSupplier.mapOrNull(
            (value) => null,
            additional: (value) {
              final supplier = value.supplier.copyWith(
                logoMemory: base64Image ?? '',
              );
              additionalBenefitsPerSupplierList[currentAdditionalBenefitIndex] =
                  value.copyWith(
                supplier: supplier,
              );
            },
            purchased: (value) {
              final supplier = value.supplier.copyWith(
                logoMemory: base64Image ?? '',
              );
              additionalBenefitsPerSupplierList[currentAdditionalBenefitIndex] =
                  value.copyWith(
                supplier: supplier,
              );
            },
          );
        }
      }
    });
    notifyListeners();
  }

  ///This method set a benefit image, and pdf in current additional benefit
  ///per supplier
  ///
  void setAdditionalBenefitPerSupplierFiles(List<FileModel?> files) {
    for (final file in files) {
      if (file?.fileContent == null) continue;
      final fileWithoutExtension = file?.fileContent?.name.split('.')[0];
      if (fileWithoutExtension == null) continue;
      final splitAndTypeName = fileWithoutExtension.split('/');
      if (splitAndTypeName.isEmpty || splitAndTypeName.length < 1) continue;
      if (currentAdditionalBenefitPerSupplier == null) continue;
      final type = splitAndTypeName[0];
      if (type == 'pdfWording') {
        currentAdditionalBenefitPerSupplier?.mapOrNull(
          (value) => null,
          additional: (value) {
            setCurrentAdditionalBenefitPerSupplier(
              value.copyWith(pdfWordingMemory: file!.fileContent),
            );
          },
          purchased: (value) {
            setCurrentAdditionalBenefitPerSupplier(
              value.copyWith(pdfWordingMemory: file!.fileContent),
            );
          },
        );
        continue;
      }
      if (type == 'benefitImage') {
        currentAdditionalBenefitPerSupplier?.mapOrNull(
          (value) => null,
          additional: (value) {
            setCurrentAdditionalBenefitPerSupplier(
              value.copyWith(
                  benefitImageMemory: file!.fileContent!.base64Content),
            );
          },
          purchased: (value) {
            setCurrentAdditionalBenefitPerSupplier(
              value.copyWith(
                  benefitImageMemory: file!.fileContent!.base64Content),
            );
          },
        );
        continue;
      }
      if (type == 'supplierLogo') {
        final supplier =
            currentAdditionalBenefitPerSupplier?.supplier?.copyWith(
          logoMemory: file!.fileContent!.base64Content,
        );
        if (supplier == null) continue;
        currentAdditionalBenefitPerSupplier?.mapOrNull(
          (value) => null,
          additional: (value) {
            setCurrentAdditionalBenefitPerSupplier(
              value.copyWith(
                supplier: supplier,
              ),
            );
          },
          purchased: (value) {
            setCurrentAdditionalBenefitPerSupplier(
              value.copyWith(
                supplier: supplier,
              ),
            );
          },
        );
        continue;
      }
    }
    notifyListeners();
  }

  double get finalDiscount {
    if (currentAdditionalBenefitPerSupplier == null ||
        currentAdditionalBenefitPerSupplier?.productRates == null) return 0.0;
    return currentAdditionalBenefitPerSupplier?.productRates?.finalDiscount ??
        0.0;
  }

  double get finalTotalPremium {
    if (currentAdditionalBenefitPerSupplier == null ||
        currentAdditionalBenefitPerSupplier?.productRates == null) return 0.0;
    return currentAdditionalBenefitPerSupplier
            ?.productRates?.finalTotalPremium ??
        0.0;
  }

  ///An injection that uses singleton to call the instantiated
  ///[AdditionalBenefitsPerSupplierRepositoryDeprecated]
  ///
  AdditionalBenefitsPerSupplierRepositoryDeprecated
      get _additionalBenefitsPerSupplierRepository =>
          getIt<AdditionalBenefitsPerSupplierRepositoryDeprecated>();

  ///Retrieves the detailed information of a additional benefits per supplier
  /// by calling [_additionalBenefitsPerSupplierRepository] getAdditionalBenefitsPerSupplierByMembership
  /// method.
  ///
  /// Stores the additional benefit per supplier list in [additionalBenefitsPerSupplierList]
  ///  and establishes the [AdditionalBenefitsPerSupplierStateDeprecated] accomplished
  /// if the request is successful.
  ///
  /// If the request is not successful it either sets [AdditionalBenefitsPerSupplierStateDeprecated]
  /// in [additionalBenefitPerSupplierState] as error, userNotMatchError,
  /// notFound or unexpectedError.
  /// These states can be set since the service response can be userNotMatchError,
  ///  not found or unexpectedError in the line number 100
  ///
  Future<void> getAdditionalBenefitsPerSupplierByMembership({
    required String membershipId,
  }) async {
    try {
      additionalBenefitPerSupplierState =
          AdditionalBenefitsPerSupplierStateDeprecated.getting;
      final data = await _additionalBenefitsPerSupplierRepository
          .getAdditionalBenefitsPerSupplierByMembershipRequested(
        membershipId: membershipId,
      );
      if (data is AdditionalBenefitsPerSupplierStateDeprecated) {
        additionalBenefitPerSupplierState = data;
        return;
      }
      final dataList = data.map<BenefitPerSupplierModel>((d) {
        d['modelType'] = 'additional';
        return BenefitPerSupplierModel.fromJson(d);
      }).toList();
      setAdditionalBenefitsPerSupplierList(dataList);
      if (additionalBenefitsPerSupplierList.isEmpty) {
        additionalBenefitPerSupplierState =
            AdditionalBenefitsPerSupplierStateDeprecated.empty;
        return;
      }
      additionalBenefitPerSupplierState =
          AdditionalBenefitsPerSupplierStateDeprecated.accomplished;
      groupAdditionalBenefitsPerSupplierByBenefitType();
    } catch (e) {
      final loggerInstance = PiixLogger.instance;
      final logMessage = loggerInstance.errorMessage(
        messageName: 'Error in getAdditionalBenefitsPerSupplierByMembership '
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
      additionalBenefitPerSupplierState =
          AdditionalBenefitsPerSupplierStateDeprecated.error;
    }
  }

  ///Retrieves the detailed information of a additional benefits per supplier
  /// by calling [_additionalBenefitsPerSupplierRepository]
  /// getAdditionalBenefitPerSupplierWithDetailsandPriceByMembership method.
  ///
  /// Stores the additional benefit per supplier by id in [currentAdditionalBenefitsPerSupplier]
  ///  and establishes the [AdditionalBenefitsPerSupplierStateDeprecated] accomplished
  /// if the request is successful.
  ///
  /// If the request is not successful it either sets [AdditionalBenefitsPerSupplierStateDeprecated]
  /// in [additionalBenefitPerSupplierState] as error, userNotMatchError,
  /// notFound or unexpectedError.
  /// These states can be set since the service response can be userNotMatchError,
  ///  not found or unexpectedError in the line number 149
  ///
  Future<void> getAdditionalBenefitPerSupplierDetailsAndPrice(
      {required AdditionalBenefitPerSupplierQuotePriceRequestModel
          requestModel}) async {
    try {
      additionalBenefitQuotationState = GeneralQuotationStateDeprecated.getting;
      final data = await _additionalBenefitsPerSupplierRepository
          .getAdditionalBenefitPerSupplierDetailsAndPriceRequested(
        requestModel: requestModel,
      );
      if (data is GeneralQuotationStateDeprecated) {
        additionalBenefitQuotationState = data;
        return;
      }
      if (data == null) {
        setCurrentAdditionalBenefitPerSupplier(data);
        additionalBenefitQuotationState = GeneralQuotationStateDeprecated.empty;
        return;
      }

      final quotedAdditionalBenefitPerSupplier =
          BenefitPerSupplierModel.fromJson(data);

      quotedAdditionalBenefitPerSupplier.mapOrNull(
        (value) => null,
        additional: (value) {
          final additionalBenefitPerSupplier =
              currentAdditionalBenefitPerSupplier?.mapOrNull(
            (value) => null,
            additional: (value) => value,
          );
          if (additionalBenefitPerSupplier == null) return value;
          return value.copyWith(
            supplier: additionalBenefitPerSupplier.supplier,
            benefitImage: additionalBenefitPerSupplier.benefitImage,
            benefitImageMemory: additionalBenefitPerSupplier.benefitImageMemory,
            pdfWording: additionalBenefitPerSupplier.pdfWording,
            pdfWordingMemory: additionalBenefitPerSupplier.pdfWordingMemory,
            wordingZero: additionalBenefitPerSupplier.wordingZero,
            wordingOne: additionalBenefitPerSupplier.wordingOne,
            wordingTwo: additionalBenefitPerSupplier.wordingTwo,
          );
        },
      );
      setCurrentAdditionalBenefitPerSupplier(
          quotedAdditionalBenefitPerSupplier);
      additionalBenefitQuotationState =
          GeneralQuotationStateDeprecated.accomplished;
    } catch (e) {
      final loggerInstance = PiixLogger.instance;
      final logMessage = loggerInstance.errorMessage(
        messageName: 'Error in '
            'getAdditionalBenefitPerSupplierDetailsAndPrice '
            'with id membership ${requestModel.membershipId}'
            ' and additional benefit per supplier id '
            '${requestModel.additionalBenefitPerSupplierId} ',
        message: e.toString(),
        isLoggable: isApiException(e),
      );
      loggerInstance.log(
        logMessage: logMessage.toString(),
        error: e,
        level: Level.error,
        sendToCrashlytics: true,
      );
      additionalBenefitQuotationState = GeneralQuotationStateDeprecated.error;
    }
  }
}
