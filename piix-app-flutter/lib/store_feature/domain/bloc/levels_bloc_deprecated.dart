import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/domain/model/benefit_per_supplier_model_deprecated.dart';
import 'package:piix_mobile/utils/api/app_api_log_exception.dart';
import 'package:piix_mobile/general_app_feature/di/service_locator.dart';
import 'package:piix_mobile/file_feature/domain/model/file_model.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_logger/piix_logger.dart';
import 'package:piix_mobile/store_feature/data/repository/levels_deprecated/levels_repository_deprecated.dart';
import 'package:piix_mobile/store_feature/domain/model/level_model.dart';
import 'package:piix_mobile/store_feature/domain/model/level_quote_price_model.dart';
import 'package:piix_mobile/store_feature/domain/model/quote_price_request_model/level_quote_price_request_model_deprecated.dart';
import 'package:piix_mobile/store_feature/domain/model/purchased_levels_model.dart';

@Deprecated('Will be removed in 4.0')

///This BLoC is where all the levels logic is located
///
class LevelsBLoCDeprecated with ChangeNotifier {
  ///Stores the [LevelStateDeprecated] and is used by all the
  ///methods that call an api inside [LevelStateDeprecated]
  LevelStateDeprecated _levelState = LevelStateDeprecated.idle;
  LevelStateDeprecated get levelState => _levelState;
  set levelState(LevelStateDeprecated state) {
    _levelState = state;
    notifyListeners();
  }

  ///Stores a level list in [PurchasedLevelsModel]
  PurchasedLevelsModel? _userEcommerceLevels;
  PurchasedLevelsModel? get userEcommerceLevels => _userEcommerceLevels;
  void setUserEcommerceLevels(PurchasedLevelsModel? value) {
    _userEcommerceLevels = value;
    notifyListeners();
  }

  ///Stores the apackage combo by id [LevelQuotePriceModel]
  LevelModel? _currentLevel;
  LevelModel? get currentLevel => _currentLevel;
  void setCurrentLevel(LevelModel? value) {
    _currentLevel = value;
    notifyListeners();
  }

  ///Stores the apackage combo by id [LevelQuotePriceModel]
  LevelQuotePriceModel? _levelQuotation;
  LevelQuotePriceModel? get levelQuotation => _levelQuotation;
  set levelQuotation(LevelQuotePriceModel? value) {
    _levelQuotation = value;
    notifyListeners();
  }

  ///Stores the level id
  String? _currentLevelId;
  String? get currentLevelId => _currentLevelId;
  set currentLevelId(String? id) {
    _currentLevelId = id;
    notifyListeners();
  }

  ///This method set a level image in a levelList
  ///
  void setLevelsImageFiles(List<FileModel?> files) {
    if (userEcommerceLevels == null) return;
    for (final file in files) {
      if (file?.fileContent?.base64Content == null) continue;
      final fileWithoutExtension = file!.fileContent!.name.split('.')[0];
      final splitTypeAndName = fileWithoutExtension.split('/');
      if (splitTypeAndName.length < 1) continue;
      final levelId = splitTypeAndName[1];
      final levels = userEcommerceLevels!.levelList;
      final currentAdditionalBenefitPerSupplierIndex =
          levels.indexWhere((level) => level.levelId == levelId);
      if (currentAdditionalBenefitPerSupplierIndex < 0) continue;
      final base64Image = file.fileContent!.base64Content;
      final level = userEcommerceLevels!
          .levelList[currentAdditionalBenefitPerSupplierIndex]
          .mapOrNull(
        (value) => value,
      );
      if (level == null) continue;
      userEcommerceLevels!.levelList[currentAdditionalBenefitPerSupplierIndex] =
          level.copyWith(
        membershipLevelImageMemory: base64Image,
      );
    }
    notifyListeners();
  }

  ///This method set a supplier logo image in a levelList
  ///
  void setSupplierLogoImageFiles(List<FileModel?> files, String levelId) {
    if (userEcommerceLevels == null) return;
    final currentAdditionalBenefitIndex = userEcommerceLevels!.levelList
        .indexWhere((level) => level.levelId == levelId);
    for (final file in files) {
      if (file?.fileContent?.base64Content == null) continue;
      final fileWithoutExtension = file!.fileContent!.name.split('.')[0];
      final splitTypeAndName = fileWithoutExtension.split('/');
      if (splitTypeAndName.length < 1) continue;
      final supplierId = splitTypeAndName[1];

      final level = userEcommerceLevels!
          .levelList[currentAdditionalBenefitIndex]
          .mapOrNull(
        (value) {
          final benefitsPerSupplier = <BenefitPerSupplierModel>[];
          for (final benefitPerSupplier in value.benefits) {
            if (benefitPerSupplier.supplier?.supplierId == supplierId) {
              final base64Image = file.fileContent!.base64Content;
              final supplier = benefitPerSupplier.supplier?.copyWith(
                logoMemory: base64Image,
              );
              if (supplier == null) continue;
              final newBenefitPerSupplier = benefitPerSupplier.mapOrNull(
                (value) => null,
                level: (value) => value.copyWith(supplier: supplier),
              );
              if (newBenefitPerSupplier == null) continue;
              benefitsPerSupplier.add(newBenefitPerSupplier);
            }
          }
          return value;
        },
      );
      if (level == null) continue;
      userEcommerceLevels!.levelList[currentAdditionalBenefitIndex] = level;
    }
    notifyListeners();
  }

  ///Instantiated a service locator for [LevelsRepositoryDeprecated]
  ///
  LevelsRepositoryDeprecated get _levelsRepository =>
      getIt<LevelsRepositoryDeprecated>();

  ///Retrieves the detailed information of a levels
  /// by calling [_levelsRepository] getLevelsByMembership
  /// method.
  ///
  /// Stores the level list in [userEcommerceLevels]
  ///  and establishes the [LevelStateDeprecated] accomplished
  /// if the request is successful.
  ///
  /// If the request is not successful it either sets [LevelStateDeprecated]
  /// in [LevelStateDeprecated] as error, conflict, notFound or unexpectedError.
  /// These states can be set since the service response can be conflict,
  ///  not found or unexpectedError;
  ///
  Future<void> getLevelsByMembership({
    required String membershipId,
  }) async {
    try {
      levelState = LevelStateDeprecated.getting;
      final data = await _levelsRepository.getLevelsByMembership(
        membershipId: membershipId,
      );

      if (data is LevelStateDeprecated) {
        levelState = data;
        setUserEcommerceLevels(null);
      } else {
        setUserEcommerceLevels(
          PurchasedLevelsModel.fromJson(data),
        );
        if (userEcommerceLevels!.levelList.isEmpty) {
          levelState = LevelStateDeprecated.empty;
        } else {
          levelState = LevelStateDeprecated.accomplished;
        }
      }
    } catch (e) {
      final loggerInstance = PiixLogger.instance;
      final logMessage = loggerInstance.errorMessage(
        messageName: 'Error in getLevelsByMembership '
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
      levelState = LevelStateDeprecated.error;
    }
  }

  List<LevelModel> get filteredLevels {
    final levels = userEcommerceLevels?.levelList;
    if (levels == null) return [];
    return levels
        .where((level) =>
            level.mapOrNull((value) =>
                !value.isAlreadyAcquired || value.isPartiallyAcquired) ??
            false)
        .toList();
  }

  ///Retrieves the detailed information of a level
  /// by calling [_levelsRepository]
  /// getLevelQuotationByMembership method.
  ///
  /// Stores the package combo by id in [levelQuotation]
  /// and establishes the [LevelStateDeprecated] accomplished
  /// if the request is successful.
  ///
  /// If the request is not successful it either sets [LevelStateDeprecated]
  /// in [LevelStateDeprecated] as error, conflict, notFound or unexpectedError.
  /// These states can be set since the service response can be conflict,
  ///  not found or unexpectedError
  ///
  Future<void> getLevelQuotationByMembership(
      {required LevelQuotePriceRequestModel requestModel}) async {
    try {
      levelState = LevelStateDeprecated.getting;
      final data = await _levelsRepository.getLevelQuotationByMembership(
        requestModel: requestModel,
      );
      if (data is LevelStateDeprecated) {
        levelState = data;
        levelQuotation = null;
      } else {
        levelQuotation = LevelQuotePriceModel.fromJson(data);
        levelState = LevelStateDeprecated.accomplished;
      }
    } catch (e) {
      final loggerInstance = PiixLogger.instance;
      final logMessage = loggerInstance.errorMessage(
        messageName: 'Error in getLevelQuotationByMembership '
            'with id membership ${requestModel.membershipId}'
            ' and level id ${requestModel.levelId} ',
        message: e.toString(),
        isLoggable: isApiException(e),
      );
      loggerInstance.log(
        logMessage: logMessage.toString(),
        error: e,
        level: Level.error,
        sendToCrashlytics: true,
      );
      levelState = LevelStateDeprecated.error;
    }
  }
}
