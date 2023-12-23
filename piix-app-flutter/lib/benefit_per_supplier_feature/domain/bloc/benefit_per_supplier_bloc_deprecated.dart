import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/data/repository/benefit_per_supplier_repository.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/domain/model/benefit_per_supplier_model_deprecated.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/domain/model/request_benefit_per_supplier_model.dart';
import 'package:piix_mobile/domain/repository/benefit_per_supplier_repository_interface.dart';
import 'package:piix_mobile/utils/api/app_api_log_exception.dart';
import 'package:piix_mobile/general_app_feature/di/service_locator.dart';
import 'package:piix_mobile/general_app_feature/domain/bloc/file_system_bloc.dart';
import 'package:piix_mobile/file_feature/domain/model/file_content_model.dart';
import 'package:piix_mobile/file_feature/domain/model/file_model.dart';
import 'package:piix_mobile/utils/extensions/string_extend.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_logger/piix_logger.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')
enum BenefitPerSupplierTypeDeprecated { benefit, cobenefit, additional }

@Deprecated('Will be removed in 4.0')

/// This BLoC is where benefit info package is obtained and stored.
class BenefitPerSupplierBLoCDeprecated with ChangeNotifier {
  BenefitPerSupplierBLoCDeprecated({this.interface});

  final BenefitPerSupplierRepositoryInterface? interface;

  //TODO: Use delete this property and reuse _detailedBenefitPerSupplier after refactoring ticket_header.dart
  BenefitPerSupplierModel? _benefitInfoFromLocalMembership;
  BenefitPerSupplierModel? get benefitInfoFromLocalMembership =>
      _benefitInfoFromLocalMembership;
  set benefitInfoFromLocalMembership(BenefitPerSupplierModel? value) {
    _benefitInfoFromLocalMembership = value;
    notifyListeners();
  }

  //TODO: Check if this second property is not redundant with the one before
  BenefitPerSupplierModel? _selectedBenefitPerSupplier;
  BenefitPerSupplierModel? get selectedBenefitPerSupplier =>
      _selectedBenefitPerSupplier;
  void setSelectedBenefitPerSupplier(
      BenefitPerSupplierModel? benefitPerSupplier) {
    _selectedBenefitPerSupplier = benefitPerSupplier;
    notifyListeners();
  }

  BenefitPerSupplierModel? _selectedAdditionalBenefitPerSupplier;
  BenefitPerSupplierModel? get selectedAdditionalBenefitPerSupplier =>
      _selectedAdditionalBenefitPerSupplier;
  void setSelectedAdditionalBenefitPerSupplier(
      BenefitPerSupplierModel? benefitPerSupplier) {
    _selectedAdditionalBenefitPerSupplier = benefitPerSupplier;
    notifyListeners();
  }

  BenefitPerSupplierModel? _selectedCobenefitPerSupplier;
  BenefitPerSupplierModel? get selectedCobenefitPerSupplier =>
      _selectedCobenefitPerSupplier;
  void setSelectedCobenefitPerSupplier(
      BenefitPerSupplierModel? cobenefitPerSupplier) {
    if (cobenefitPerSupplier == null) {
      isCobenefit = false;
    } else {
      isCobenefit = true;
    }
    _selectedCobenefitPerSupplier = cobenefitPerSupplier;
    notifyListeners();
  }

  String? _selectedBenefitPerSupplierId;
  String? get selectedBenefitPerSupplierId => _selectedBenefitPerSupplierId;
  set selectedBenefitPerSupplierId(String? value) {
    _selectedBenefitPerSupplierId = value;
    notifyListeners();
  }

  bool _isCobenefit = false;
  bool get isCobenefit => _isCobenefit;
  set isCobenefit(bool value) {
    _isCobenefit = value;
    notifyListeners();
  }

  BenefitPerSupplierStateDeprecated _benefitPerSupplierState =
      BenefitPerSupplierStateDeprecated.idle;
  BenefitPerSupplierStateDeprecated get benefitPerSupplierState =>
      _benefitPerSupplierState;
  set benefitPerSupplierState(BenefitPerSupplierStateDeprecated state) {
    _benefitPerSupplierState = state;
    notifyListeners();
  }

  BenefitPerSupplierRepositoryDeprecated get benefitPerSupplierRepository =>
      getIt<BenefitPerSupplierRepositoryDeprecated>();

  String? get cobenefitName => selectedCobenefitPerSupplier?.benefitName;
  String? get additionalBenefitName =>
      selectedAdditionalBenefitPerSupplier?.benefitName;
  String? get benefitName => selectedBenefitPerSupplier?.benefitName;

  String get currentBenefitName =>
      additionalBenefitName ?? cobenefitName ?? benefitName ?? '';

  String get additionalSupplierName =>
      selectedAdditionalBenefitPerSupplier?.supplierName ?? '';
  String get coBenefitSupplierName =>
      selectedCobenefitPerSupplier?.supplierName ?? '';
  String get benefitSupplierName =>
      selectedBenefitPerSupplier?.supplierName ?? '';

  String get additionalSupplierId =>
      selectedAdditionalBenefitPerSupplier?.supplierId ?? '';
  String get coBenefitSupplierId =>
      selectedCobenefitPerSupplier?.supplierId ?? '';
  String get benefitSupplierId => selectedBenefitPerSupplier?.supplierId ?? '';

  String get supplierId {
    if (additionalSupplierId.isNotEmpty) return additionalSupplierId;
    if (coBenefitSupplierId.isNotEmpty) return coBenefitSupplierId;
    return benefitSupplierId;
  }

  String get supplierName {
    if (additionalSupplierName.isNotEmpty) return additionalSupplierName;
    if (coBenefitSupplierName.isNotEmpty) return coBenefitSupplierName;
    return benefitSupplierName;
  }

  String? get supplierLogo {
    if (selectedAdditionalBenefitPerSupplier?.supplier?.logo != null) {
      return selectedAdditionalBenefitPerSupplier?.supplier?.logoMemory;
    }
    if (selectedCobenefitPerSupplier?.supplier?.logo != null) {
      return selectedCobenefitPerSupplier?.supplier?.logoMemory;
    }
    return selectedBenefitPerSupplier?.supplier?.logoMemory;
  }

  String get benefitTicketName =>
      additionalBenefitName ?? cobenefitName ?? benefitName ?? '';

  String? get additionalBenefitPerSupplierId =>
      selectedAdditionalBenefitPerSupplier?.benefitPerSupplierId;
  String? get cobenefitPerSupplierId =>
      selectedCobenefitPerSupplier?.benefitPerSupplierId;
  String? get benefitPerSupplierId =>
      selectedBenefitPerSupplier?.benefitPerSupplierId;

  ///The benefit per supplier id corresponding to where the user is at,
  ///checks first for an additional benefit per supplier id, if the id is empty,
  ///it checks for cobenefit per supplier id, and if not found finally
  ///return the benefit per supllier id whether empty or no.
  String get currentAdditionalCoBenefitPerSupplierId =>
      additionalBenefitPerSupplierId ??
      cobenefitPerSupplierId ??
      benefitPerSupplierId ??
      '';

  void setBenefitFiles(List<FileModel?> files) {
    for (final file in files) {
      if (file == null) return;
      if (file.fileContent == null) continue;
      final name = file.fileContent!.name.split('.')[0];
      if (name.isEmpty) continue;
      final benefitPerSupplier = selectedBenefitPerSupplier
          ?.mapOrNull((value) => null, detail: (value) => value);
      if (benefitPerSupplier == null) continue;
      if (name == 'pdfWording') {
        setSelectedBenefitPerSupplier(
          benefitPerSupplier.copyWith(pdfWordingMemory: file.fileContent),
        );
        continue;
      }
      if (file.fileContent?.base64Content == null) continue;
      if (name == 'benefitImage') {
        setSelectedBenefitPerSupplier(
          benefitPerSupplier.copyWith(
            benefitImageMemory: file.fileContent!.base64Content,
          ),
        );
        continue;
      }
      if (name == 'supplierLogo') {
        final supplier = benefitPerSupplier.supplier.copyWith(
          logoMemory: file.fileContent!.base64Content,
        );
        setSelectedBenefitPerSupplier(
          benefitPerSupplier.copyWith(
            supplier: supplier,
          ),
        );
        continue;
      }
    }
    notifyListeners();
  }

  void setAdditionalBenefitFiles(List<FileModel?> files) {
    for (final file in files) {
      if (file == null) return;
      if (file.fileContent == null) continue;
      final name = file.fileContent!.name.split('.')[0];
      if (name.isEmpty || selectedAdditionalBenefitPerSupplier == null)
        continue;
      if (name == 'pdfWording') {
        selectedAdditionalBenefitPerSupplier?.maybeMap(
          (_) {},
          additional: (value) {
            setSelectedAdditionalBenefitPerSupplier(
              value.copyWith(
                pdfWordingMemory: file.fileContent!,
              ),
            );
          },
          purchased: (value) {
            setSelectedAdditionalBenefitPerSupplier(
              value.copyWith(
                pdfWordingMemory: file.fileContent!,
              ),
            );
          },
          orElse: () {},
        );
        continue;
      }
      if (file.fileContent?.base64Content == null) continue;
      if (name == 'benefitImage') {
        selectedAdditionalBenefitPerSupplier?.maybeMap(
          (_) {},
          additional: (value) {
            setSelectedAdditionalBenefitPerSupplier(
              value.copyWith(
                benefitImageMemory: file.fileContent!.base64Content,
              ),
            );
          },
          purchased: (value) {
            setSelectedAdditionalBenefitPerSupplier(
              value.copyWith(
                benefitImageMemory: file.fileContent!.base64Content,
              ),
            );
          },
          orElse: () {},
        );
        continue;
      }
      if (name == 'supplierLogo') {
        final supplier =
            selectedAdditionalBenefitPerSupplier?.supplier?.copyWith(
          logoMemory: file.fileContent!.base64Content,
        );
        if (supplier == null) continue;
        selectedAdditionalBenefitPerSupplier?.maybeMap(
          (_) {},
          additional: (value) {
            setSelectedAdditionalBenefitPerSupplier(
              value.copyWith(
                supplier: supplier,
              ),
            );
          },
          purchased: (value) {
            setSelectedAdditionalBenefitPerSupplier(
              value.copyWith(
                supplier: supplier,
              ),
            );
          },
          orElse: () {},
        );
        continue;
      }
    }
  }

  Future<void> getBenefitPerSupplier({
    required String benefitPerSupplierId,
    required String userId,
    required String membershipId,
  }) async {
    try {
      final requestModel = RequestBenefitPerSupplierModel(
        benefitPerSupplierId: benefitPerSupplierId,
        userId: userId,
        membershipId: membershipId,
      );
      benefitPerSupplierState = BenefitPerSupplierStateDeprecated.retrieving;
      final data = await benefitPerSupplierRepository
          .getBenefitPerSupplierRequested(requestModel);
      if (data is BenefitPerSupplierStateDeprecated) {
        benefitPerSupplierState = data;
      } else {
        final benefitPerSupplierData = BenefitPerSupplierModel.fromJson(data);
        if (benefitPerSupplierData.hasCobenefits) {
          benefitPerSupplierData.cobenefitsPerSupplier.sort(
            (a, b) => a.benefitName.compareTo(
              b.benefitName,
            ),
          );
        }
        setSelectedBenefitPerSupplier(benefitPerSupplierData);
        benefitPerSupplierState = data['state'];
      }
    } catch (e) {
      final loggerInstance = PiixLogger.instance;
      final logMessage = loggerInstance.errorMessage(
        messageName: 'Error in getBenefitPerSupplier with'
            'id $benefitPerSupplierId',
        message: e.toString(),
        isLoggable: isApiException(e),
      );
      loggerInstance.log(
        logMessage: logMessage.toString(),
        error: e,
        level: Level.error,
        sendToCrashlytics: true,
      );
      benefitPerSupplierState = BenefitPerSupplierStateDeprecated.error;
    }
  }

  void setCoBenefitFiles(List<FileModel?> files) {
    for (final file in files) {
      if (file == null) return;
      if (file.fileContent == null) continue;
      final name = file.fileContent!.name.split('.')[0];
      if (name.isEmpty) continue;
      final cobenefitPerSupplier = selectedCobenefitPerSupplier
          ?.mapOrNull((value) => null, cobenefit: (value) => value);
      if (cobenefitPerSupplier == null) continue;
      if (name == 'pdfWording') {
        setSelectedCobenefitPerSupplier(
          cobenefitPerSupplier.copyWith(pdfWordingMemory: file.fileContent),
        );
        continue;
      }
      if (file.fileContent?.base64Content == null) continue;
      if (name == 'benefitImage') {
        setSelectedCobenefitPerSupplier(
          cobenefitPerSupplier.copyWith(
            benefitImageMemory: file.fileContent!.base64Content,
          ),
        );
      }
      if (name == 'supplierLogo') {
        final supplier = cobenefitPerSupplier.supplier.copyWith(
          logoMemory: file.fileContent!.base64Content,
        );
        setSelectedCobenefitPerSupplier(
          cobenefitPerSupplier.copyWith(
            supplier: supplier,
          ),
        );
        continue;
      }
    }
    notifyListeners();
  }

  void setCobenefitSupplierLogo(FileModel fileModel) {
    selectedCobenefitPerSupplier?.mapOrNull(
      (value) => null,
      cobenefit: (value) {
        final supplier = value.supplier.copyWith(
          logoMemory: fileModel.fileContent!.base64Content,
        );
        setSelectedCobenefitPerSupplier(
          value.copyWith(
            supplier: supplier,
          ),
        );
      },
    );
  }

  Future<void> getFilesAndImages({
    required BenefitPerSupplierTypeDeprecated type,
    required String userId,
    required BuildContext context,
  }) async {
    final futures = <Future<FileModel?>>[];
    String? benefitImage;
    String? supplierLogo;
    String? pdfWording;
    String? benefitImageMemory = null;
    FileContentModel? pdfWordingMemory;
    String? supplierLogoMemory;
    switch (type) {
      case BenefitPerSupplierTypeDeprecated.benefit:
        selectedBenefitPerSupplier?.mapOrNull(
          (value) => null,
          detail: (value) {
            benefitImage = value.benefitImage;
            supplierLogo = value.supplier.logo;
            pdfWording = value.pdfWording;
            benefitImageMemory = value.benefitImageMemory;
            pdfWordingMemory = value.pdfWordingMemory;
            supplierLogoMemory = value.supplier.logoMemory;
          },
        );
        break;
      case BenefitPerSupplierTypeDeprecated.cobenefit:
        selectedCobenefitPerSupplier?.mapOrNull(
          (value) => null,
          cobenefit: (value) {
            benefitImage = value.benefitImage;
            supplierLogo = value.supplier.logo;
            pdfWording = value.pdfWording;
            benefitImageMemory = value.benefitImageMemory;
            pdfWordingMemory = value.pdfWordingMemory;
            supplierLogoMemory = value.supplier.logoMemory;
          },
        );
        break;
      case BenefitPerSupplierTypeDeprecated.additional:
        selectedAdditionalBenefitPerSupplier?.mapOrNull(
          (value) => null,
          additional: (value) {
            benefitImage = value.benefitImage;
            supplierLogo = value.supplier.logo;
            pdfWording = value.pdfWording;
            benefitImageMemory = value.benefitImageMemory;
            pdfWordingMemory = value.pdfWordingMemory;
            supplierLogoMemory = value.supplier.logoMemory;
          },
          purchased: (value) {
            benefitImage = value.benefitImage;
            supplierLogo = value.supplier.logo;
            pdfWording = value.pdfWording;
            benefitImageMemory = value.benefitImageMemory;
            pdfWordingMemory = value.pdfWordingMemory;
            supplierLogoMemory = value.supplier.logoMemory;
          },
        );
        break;
      default:
        break;
    }

    final fileSystemBLoC = context.read<FileSystemBLoC>();
    if (benefitImageMemory.isNullOrEmpty && benefitImage.isNotNullEmpty) {
      futures.add(fileSystemBLoC.getFileFromPath(
        userId: userId,
        filePath: benefitImage!,
        propertyName: 'benefitImage',
      ));
    }
    if (pdfWordingMemory == null && pdfWording.isNotNullEmpty) {
      futures.add(fileSystemBLoC.getFileFromPath(
        userId: userId,
        filePath: pdfWording!,
        propertyName: 'pdfWording',
      ));
    }
    if (supplierLogoMemory.isNullOrEmpty && supplierLogo.isNotNullEmpty) {
      futures.add(fileSystemBLoC.getFileFromPath(
        userId: userId,
        filePath: supplierLogo!,
        propertyName: 'supplierLogo',
      ));
    }
    final files = await Future.wait(futures);
    if (type == BenefitPerSupplierTypeDeprecated.benefit) {
      setBenefitFiles(files);
      return;
    }
    if (type == BenefitPerSupplierTypeDeprecated.cobenefit) {
      setCoBenefitFiles(files);
      return;
    }
    if (type == BenefitPerSupplierTypeDeprecated.additional) {
      setAdditionalBenefitFiles(files);
      return;
    }
  }

  void clearProvider() {
    _benefitInfoFromLocalMembership = null;
    _selectedAdditionalBenefitPerSupplier = null;
    _selectedBenefitPerSupplier = null;
    _selectedCobenefitPerSupplier = null;
    _selectedBenefitPerSupplierId = null;
    _isCobenefit = false;
    _benefitPerSupplierState = BenefitPerSupplierStateDeprecated.idle;
    notifyListeners();
  }
}
