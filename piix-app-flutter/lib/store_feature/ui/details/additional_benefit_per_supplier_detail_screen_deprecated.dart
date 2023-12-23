import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/domain/bloc/file_system_bloc.dart';
import 'package:piix_mobile/file_feature/domain/model/file_model.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/user_bloc_deprecated.dart';
import 'package:piix_mobile/store_feature/domain/bloc/additional_benefits_per_supplier_bloc_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/additional_benefits_per_supplier_deprecated/widgets_deprecated/additional_benefit_image_container_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/additional_benefits_per_supplier_deprecated/widgets_deprecated/already_acquired__additional_benefit_banner_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/details/widgets/additional_benefit_per_supplier_card_deprecated.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

///This is an additional benefit per supplier screen
///includes all information for current additional benefit per supplier
///
class AdditionalBenefitPerSupplierDetailScreenDeprecated
    extends StatefulWidget {
  static const routeName = '/additional_benefit_per_supplier_detail';
  const AdditionalBenefitPerSupplierDetailScreenDeprecated({
    super.key,
  });

  @override
  State<AdditionalBenefitPerSupplierDetailScreenDeprecated> createState() =>
      _AdditionalBenefitPerSupplierDetailScreenDeprecatedState();
}

class _AdditionalBenefitPerSupplierDetailScreenDeprecatedState
    extends State<AdditionalBenefitPerSupplierDetailScreenDeprecated> {
  List<Future<FileModel?>> filesFutures = [];
  late AdditionalBenefitsPerSupplierBLoCDeprecated
      additionalBenefitsPerSupplierBLoC;

  double get paddingVertical => 25;
  double get paddingHorizontal => 16;
  double get imageHeight => 84;
  //This is a padding horizontal for  additional benefit per supplier card
  double get additionalBenefitPaddingCard => 12.5;
  //This is a factor to stack additional benefit card on additionañ benefit
  // per supplier image
  double get stackPositionedFactor => 0.9;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async => _initScreen());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    additionalBenefitsPerSupplierBLoC =
        context.watch<AdditionalBenefitsPerSupplierBLoCDeprecated>();
    final currentAdditionalBenefitPerSupplier =
        additionalBenefitsPerSupplierBLoC.currentAdditionalBenefitPerSupplier
            ?.mapOrNull(
      (value) => null,
      additional: (value) => value,
    );
    final paddingTop =
        (currentAdditionalBenefitPerSupplier?.isAlreadyAcquired ?? false)
            ? 55
            : 25;
    return Scaffold(
      appBar: AppBar(
        title: const Text(PiixCopiesDeprecated.benefitDetail),
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: PiixColors.greyWhite,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(bottom: paddingVertical.h),
              child: Column(
                children: [
                  //This is a benefit image widget
                  Align(
                    heightFactor: stackPositionedFactor,
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: paddingHorizontal.w,
                        right: paddingHorizontal.w,
                        top: paddingTop.h,
                      ),
                      //TODO: Add shimmer effect to image
                      child: AdditionalBenefitImageContainerDeprecated(
                        imageMemory: currentAdditionalBenefitPerSupplier
                            ?.benefitImageMemory,
                        imageHeight: imageHeight.h,
                        imageWidth: context.width,
                      ),
                    ),
                  ),
                  //This is a additional benefit per supplier card
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: additionalBenefitPaddingCard.w),
                      child: const AdditionalBenefitPerSupplierCardDeprecated(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (currentAdditionalBenefitPerSupplier?.isAlreadyAcquired ?? false)
            //This is a already acquire benefit banner
            const Align(
              alignment: Alignment.topCenter,
              child: AlreadyAcquiredAdditionalBenefitBannerDeprecated(
                label: PiixCopiesDeprecated.alreadyAcquiredBenefit,
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _initScreen() async {
    final userBLoC = context.read<UserBLoCDeprecated>();
    final fileSystemBloc = context.read<FileSystemBLoC>();
    final currentAdditionalBenefitPerSupplier =
        additionalBenefitsPerSupplierBLoC.currentAdditionalBenefitPerSupplier;
    if (currentAdditionalBenefitPerSupplier != null) {
      final hasBenefitImage =
          currentAdditionalBenefitPerSupplier.benefitImageMemory.isEmpty;
      final hasPdfFile =
          currentAdditionalBenefitPerSupplier.pdfWordingMemory == null;

      final hasSupplierLogo =
          currentAdditionalBenefitPerSupplier.supplier?.logo != null &&
              currentAdditionalBenefitPerSupplier.supplier?.logoMemory == null;

      final callService = hasBenefitImage || hasPdfFile || hasSupplierLogo;
      if (callService) {
        if (currentAdditionalBenefitPerSupplier.benefitImageMemory.isEmpty) {
          filesFutures.add(
            fileSystemBloc.getFileFromPath(
              userId: userBLoC.user!.userId,
              filePath: currentAdditionalBenefitPerSupplier.benefitImage,
              propertyName: 'benefitImage/'
                  '${currentAdditionalBenefitPerSupplier.benefitPerSupplierId}',
            ),
          );
        }

        if (currentAdditionalBenefitPerSupplier.pdfWordingMemory == null) {
          filesFutures.add(fileSystemBloc.getFileFromPath(
            userId: userBLoC.user!.userId,
            filePath: currentAdditionalBenefitPerSupplier.pdfWording,
            propertyName: 'pdfWording/'
                '${currentAdditionalBenefitPerSupplier.benefitPerSupplierId}',
          ));
        }

        if (currentAdditionalBenefitPerSupplier.supplier?.logoMemory == null) {
          filesFutures.add(fileSystemBloc.getFileFromPath(
            userId: userBLoC.user!.userId,
            filePath: currentAdditionalBenefitPerSupplier.supplier?.logo ?? '',
            propertyName: 'supplierLogo/'
                '${currentAdditionalBenefitPerSupplier.benefitPerSupplierId}',
          ));
        }
      }
      if (filesFutures.isNotEmpty) {
        final files = await Future.wait(filesFutures);
        additionalBenefitsPerSupplierBLoC
            .setAdditionalBenefitPerSupplierFiles(files);
      }
    }
  }
}
