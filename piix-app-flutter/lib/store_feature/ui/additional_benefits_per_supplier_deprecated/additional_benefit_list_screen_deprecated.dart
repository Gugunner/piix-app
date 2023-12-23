import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/enums/enums.dart';
import 'package:piix_mobile/general_app_feature/domain/bloc/file_system_bloc.dart';
import 'package:piix_mobile/file_feature/domain/model/file_model.dart';
import 'package:piix_mobile/general_app_feature/navigation_deprecated/navigation_provider_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/utils/extensions/string_extend.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/user_bloc_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/ui/widgets/membership/piix_alert_info_deprecated.dart';
import 'package:piix_mobile/store_feature/domain/bloc/additional_benefits_per_supplier_bloc_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/additional_benefits_per_supplier_deprecated/widgets_deprecated/additional_benefit_card_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/widgets/title_tooltip_list_deprecated.dart';
import 'package:piix_mobile/store_feature/utils/additional_benefit_per_supplier.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

///This screen render a list view of additional benefit per supplier by type
///
class AdditionalBenefitListScreenDeprecated extends StatefulWidget {
  static const routeName = '/additional_benefit_list';
  const AdditionalBenefitListScreenDeprecated({
    Key? key,
  }) : super(key: key);

  @override
  State<AdditionalBenefitListScreenDeprecated> createState() =>
      _AdditionalBenefitListScreenDeprecatedState();
}

class _AdditionalBenefitListScreenDeprecatedState
    extends State<AdditionalBenefitListScreenDeprecated> {
  AlertStateDeprecated alertState = AlertStateDeprecated.show;
  List<Future<FileModel?>> logoFutures = [];
  late AdditionalBenefitsPerSupplierBLoCDeprecated
      additionalBenefitsPerSupplierBLoC;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async => _initScreen());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    additionalBenefitsPerSupplierBLoC =
        context.watch<AdditionalBenefitsPerSupplierBLoCDeprecated>();

    final navigationProvider = context.watch<NavigationProviderDeprecated>();
    final typeBenefitName =
        additionalBenefitsPerSupplierBLoC.currentBenefitType?.name ?? '';
    final additionalBenefitList = additionalBenefitsPerSupplierBLoC
        .getAdditionalBenefitsPerSupplierByBenefitType();

    final isSimultaneousBenefit =
        additionalBenefitList.any((benefit) => benefit.isPartiallyAcquired);
    return Scaffold(
      appBar: AppBar(
        title: Text(typeBenefitName),
        centerTitle: true,
      ),
      backgroundColor: PiixColors.greyWhite,
      body: Stack(
        children: [
          ListView.builder(
            itemCount: additionalBenefitList.length,
            padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (index == 0) ...[
                    TitleTooltipListDeprecated(
                      label: typeBenefitName,
                      message: typeBenefitName.infoTooltip(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.h, bottom: 24.h),
                      child: Text(
                        PiixCopiesDeprecated.additionalBenefitListBrief,
                        style: context.textTheme?.bodyMedium,
                      ),
                    ),
                  ],
                  Padding(
                    padding: EdgeInsets.only(bottom: 24.h),
                    child: AdditionalBenefitCardDeprecated(
                      additionalBenefitPerSupplier:
                          additionalBenefitList[index],
                    ),
                  )
                ],
              );
            },
          ),
          if (isSimultaneousBenefit && alertState == AlertStateDeprecated.show)
            PiixAlertInfoDeprecated(
              subtitle: PiixCopiesDeprecated.simultaneousBenefit,
              backgroundColor: PiixColors.simultaneousColor,
              actionText: PiixCopiesDeprecated.knowMore.toUpperCase(),
              actionStyle: context.textTheme?.labelLarge?.copyWith(
                color: PiixColors.space,
              ),
              onAction: () => navigationProvider.navigatesToProtectedTab(),
              onClose: hideAlertState,
            )
        ],
      ),
    );
  }

  Future<void> _initScreen() async {
    final user = context.read<UserBLoCDeprecated>().user;
    if (user == null) return;
    final fileSystemBloc = context.read<FileSystemBLoC>();

    for (final additionalBenefit in additionalBenefitsPerSupplierBLoC
        .additionalBenefitsPerSupplierList) {
      if (additionalBenefit.supplier == null) continue;
      final callService = additionalBenefit.supplier!.logo.isNotEmpty &&
          additionalBenefit.supplier!.logoMemory.isNullOrEmpty;
      if (callService) {
        logoFutures.add(
          fileSystemBloc.getFileFromPath(
            userId: user.userId,
            filePath: additionalBenefit.supplier!.logo,
            propertyName:
                'supplierLogo/${additionalBenefit.benefitPerSupplierId}',
          ),
        );
      }
    }

    if (logoFutures.isNotEmpty) {
      final logoFiles = await Future.wait(logoFutures);
      additionalBenefitsPerSupplierBLoC
          .setAdditionalBenefitPerSupplierLogoFiles(logoFiles);
      additionalBenefitsPerSupplierBLoC
          .groupAdditionalBenefitsPerSupplierByBenefitType();
    }
  }

  void hideAlertState() =>
      setState(() => alertState = AlertStateDeprecated.hide);
}
