import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/domain/bloc/benefit_per_supplier_bloc_deprecated.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/domain/model/benefit_per_supplier_model_deprecated.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/ui/benefit_per_supplier_detail/cobenefit_list_tiles_deprecated.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/ui/benefit_per_supplier_detail/widgets/benefit_per_supplier_detail_card.dart';
import 'package:piix_mobile/claim_ticket_feature/domain/providers/claim_ticket_provider.dart';
import 'package:piix_mobile/general_app_feature/domain/bloc/connectivity_bloc.dart';
import 'package:piix_mobile/file_feature/domain/model/file_model.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/membership_provider_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/user_bloc_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/ui/widgets/membership/piix_bottom_alert_info_deprecated.dart';
import 'package:piix_mobile/share_widgets/piix_footer_deprecated.dart';
import 'package:piix_mobile/ui/common/clamping_scale_deprecated.dart';
import 'package:piix_mobile/widgets/no_internet.dart';
import 'package:piix_mobile/ui/common/piix_refresh.dart';
import 'package:provider/provider.dart';

@Deprecated('No longer in use 4.0')

/// Screen that shows the details of a benefit
class BenefitPerSupplierDetailScreenDeprecated extends StatefulWidget {
  static const routeName = '/benefit-detail';
  const BenefitPerSupplierDetailScreenDeprecated({
    super.key,
  });

  @override
  _BenefitPerSupplierDetailScreenDeprecatedState createState() =>
      _BenefitPerSupplierDetailScreenDeprecatedState();
}

class _BenefitPerSupplierDetailScreenDeprecatedState
    extends State<BenefitPerSupplierDetailScreenDeprecated> {
  late BenefitPerSupplierBLoCDeprecated benefitPerSupplierBLoC;
  late MembershipProviderDeprecated membershipInfoBLoC;
  late ConnectivityBLoC connectivityBLoC;
  late UserBLoCDeprecated userBLoC;
  late ClaimTicketProvider claimTicketProvider;
  List<Future<FileModel?>> futures = [];
  bool isLoading = true;
  BenefitPerSupplierTypeDeprecated? benefitPerSupplierType;
  @override
  void initState() {
    benefitPerSupplierBLoC = context.read<BenefitPerSupplierBLoCDeprecated>();
    membershipInfoBLoC = context.read<MembershipProviderDeprecated>();
    if (benefitPerSupplierBLoC.selectedAdditionalBenefitPerSupplier != null) {
      benefitPerSupplierType = BenefitPerSupplierTypeDeprecated.additional;
    } else if (benefitPerSupplierBLoC.selectedCobenefitPerSupplier != null) {
      benefitPerSupplierType = BenefitPerSupplierTypeDeprecated.cobenefit;
    } else {
      benefitPerSupplierType = BenefitPerSupplierTypeDeprecated.benefit;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _initScreen();
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  Future<void> _initScreen() async {
    benefitPerSupplierBLoC = context.read<BenefitPerSupplierBLoCDeprecated>();

    if (benefitPerSupplierType == BenefitPerSupplierTypeDeprecated.additional) {
      await additionalInitScreen();
      return;
    }
    if (benefitPerSupplierType == BenefitPerSupplierTypeDeprecated.cobenefit) {
      await cobenefitInitScreen();
      return;
    }
    await benefitInitScreen();
  }

  Future<void> cobenefitInitScreen() async {
    try {
      await benefitPerSupplierBLoC.getFilesAndImages(
        type: BenefitPerSupplierTypeDeprecated.cobenefit,
        userId: userBLoC.user?.userId ?? '',
        context: context,
      );
    } catch (e) {
      if (e == ConstantsDeprecated.networkFailed) {
        connectivityBLoC.isConnectionAvailable = false;
      }
    }
  }

  Future<void> additionalInitScreen() async {
    final additionalBenefitPerSupplier =
        benefitPerSupplierBLoC.selectedAdditionalBenefitPerSupplier;
    if (additionalBenefitPerSupplier != null) {
      //TODO: Once the additional benefit per supplier model is passed to the
      //BenefitPerSuplierModel all this code will be gone
      final callService =
          (additionalBenefitPerSupplier.pdfWordingMemory == null) ||
              (additionalBenefitPerSupplier.benefitImageMemory.isEmpty) ||
              (additionalBenefitPerSupplier.supplier?.logo != null &&
                  additionalBenefitPerSupplier.supplier?.logoMemory == null);
      //
      if (callService) {
        //After remove
        try {
          await benefitPerSupplierBLoC.getFilesAndImages(
            type: BenefitPerSupplierTypeDeprecated.additional,
            userId: userBLoC.user?.userId ?? '',
            context: context,
          );
          connectivityBLoC.isConnectionAvailable = true;
        } catch (e) {
          if (e == ConstantsDeprecated.networkFailed) {
            connectivityBLoC.isConnectionAvailable = false;
          }
        }
      } //After remove
    }
  }

  Future<void> benefitInitScreen() async {
    claimTicketProvider.clearProvider();
    final membership = membershipInfoBLoC.selectedMembership;
    final benefitPerSupplier =
        benefitPerSupplierBLoC.selectedBenefitPerSupplier;
    if (benefitPerSupplier == null || membership == null) return;
    try {
      await benefitPerSupplierBLoC.getBenefitPerSupplier(
        benefitPerSupplierId: benefitPerSupplier.benefitPerSupplierId,
        userId: userBLoC.user?.userId ?? '',
        membershipId: membership.membershipId,
      );
      await benefitPerSupplierBLoC.getFilesAndImages(
        type: BenefitPerSupplierTypeDeprecated.benefit,
        userId: userBLoC.user?.userId ?? '',
        context: context,
      );
      connectivityBLoC.isConnectionAvailable = true;
    } catch (e) {
      if (e == ConstantsDeprecated.networkFailed) {
        connectivityBLoC.isConnectionAvailable = false;
      }
    }
  }

  void handlePopCobenefitPerSupplier() {
    if (benefitPerSupplierBLoC.selectedBenefitPerSupplier == null ||
        benefitPerSupplierBLoC.selectedCobenefitPerSupplier == null) return;
    if (claimTicketProvider.selectedTicket == null) return;
    final newCobenefitPerSupplier = benefitPerSupplierBLoC
        .selectedCobenefitPerSupplier
        ?.setTicket(claimTicketProvider.selectedTicket);
    if (newCobenefitPerSupplier == null) return;
    final newBenefitPerSupplier = benefitPerSupplierBLoC
        .selectedBenefitPerSupplier
        ?.setCobenefitPerSupplier(newCobenefitPerSupplier);
    benefitPerSupplierBLoC.setSelectedBenefitPerSupplier(newBenefitPerSupplier);
  }

  Future<bool> handlePop() async {
    if (benefitPerSupplierBLoC.isCobenefit) {
      handlePopCobenefitPerSupplier();
      benefitPerSupplierBLoC.setSelectedCobenefitPerSupplier(null);
    } else {
      benefitPerSupplierBLoC.clearProvider();
    }
    claimTicketProvider.clearProvider();
    return true;
  }

  BenefitPerSupplierModel? get selectedBenefitPerSupplier {
    if (benefitPerSupplierType == null) return null;
    if (benefitPerSupplierType == BenefitPerSupplierTypeDeprecated.additional)
      return benefitPerSupplierBLoC.selectedAdditionalBenefitPerSupplier;
    if (benefitPerSupplierType == BenefitPerSupplierTypeDeprecated.cobenefit)
      return benefitPerSupplierBLoC.selectedCobenefitPerSupplier;
    return benefitPerSupplierBLoC.selectedBenefitPerSupplier;
  }

  @override
  Widget build(BuildContext context) {
    connectivityBLoC = context.watch<ConnectivityBLoC>();
    userBLoC = context.watch<UserBLoCDeprecated>();
    benefitPerSupplierBLoC = context.watch<BenefitPerSupplierBLoCDeprecated>();
    claimTicketProvider = context.watch<ClaimTicketProvider>();
    final isCobenefit = selectedBenefitPerSupplier?.isCobenefit ?? false;
    return ClampingScaleDeprecated(
      child: WillPopScope(
        onWillPop: handlePop,
        child: Scaffold(
          appBar: AppBar(
            titleTextStyle: Theme.of(context).appBarTheme.titleTextStyle,
            title: Text(
              selectedBenefitPerSupplier?.benefitName ?? '',
            ),
          ),
          body: Builder(
            builder: (_) {
              if (!connectivityBLoC.fullConnection) {
                return const NoInternet();
              }
              if (!connectivityBLoC.isConnectionAvailable) {
                return PiixRefresh(onRefresh: _initScreen);
              }
              return Stack(
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.h,
                      ),
                      child: Column(
                        children: <Widget>[
                          const SizedBox(
                            height: 12.0,
                          ),
                          BenefitPerSupplierDetailCardDeprecated(
                            isLoading: isLoading,
                            benefitPerSupplier: selectedBenefitPerSupplier,
                          ),
                          if (!isCobenefit)
                            const CobenefitListTilesDeprecated(),
                          const SizedBox(
                            height: kMinInteractiveDimension,
                          ),
                          const PiixFooterDeprecated()
                        ],
                      ),
                    ),
                  ),
                  if (!membershipInfoBLoC.isActiveMembership)
                    PiixBottomAlertInfoDeprecated(
                      color: PiixColors.process,
                      child: Text(
                        PiixCopiesDeprecated.membershipIsActivating,
                        textAlign: TextAlign.center,
                        style: context.accentTextTheme?.titleLarge?.copyWith(
                          color: PiixColors.space,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
