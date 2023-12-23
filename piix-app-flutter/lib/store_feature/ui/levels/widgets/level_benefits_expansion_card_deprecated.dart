import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/domain/bloc/benefit_per_supplier_bloc_deprecated.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/domain/model/benefit_per_supplier_model_deprecated.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/ui/benefit_per_supplier_detail/benefit_per_supplier_detail_screen_deprecated.dart';
import 'package:piix_mobile/extensions/widget_extend.dart';
import 'package:piix_mobile/general_app_feature/domain/bloc/file_system_bloc.dart';
import 'package:piix_mobile/file_feature/domain/model/file_model.dart';
import 'package:piix_mobile/navigation_feature/utils/navigator_key_state.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/piix_html_parser.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/user_bloc_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/utils/piix_memberships_util_deprecated.dart';
import 'package:piix_mobile/store_feature/domain/bloc/levels_bloc_deprecated.dart';
import 'package:piix_mobile/store_feature/domain/model/level_model.dart';
import 'package:piix_mobile/store_feature/ui/levels/widgets/level_cobenefits_list_deprecated.dart';
import 'package:piix_mobile/ui/common/piix_tag_store.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

///This widget render a level expansion tile, includes a additional benefits
///info
///
class LevelBenefitsExpansionCardDeprecated extends StatefulWidget {
  const LevelBenefitsExpansionCardDeprecated({
    super.key,
    required this.levelList,
    required this.selectedTab,
  });
  final List<LevelModel> levelList;
  final int selectedTab;

  @override
  State<LevelBenefitsExpansionCardDeprecated> createState() =>
      _LevelBenefitsExpansionCardDeprecatedState();
}

class _LevelBenefitsExpansionCardDeprecatedState
    extends State<LevelBenefitsExpansionCardDeprecated> {
  List<Future<FileModel?>> logoProviderFutures = [];
  Color get greyWhite => PiixColors.white;
  Color get darkSkyBlue => PiixColors.darkSkyBlue;
  double get mediumPadding => ConstantsDeprecated.mediumPadding;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async => _initScreen());
    super.initState();
  }

  LevelModel get level => widget.levelList[widget.selectedTab];

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Column(
        children: level.maybeMap(
          (value) => value.benefits.map((benefitPerSupplier) {
            return Theme(
              data: Theme.of(context).copyWith(
                  dividerColor: Colors.transparent,
                  listTileTheme:
                      ListTileTheme.of(context).copyWith(dense: true)),
              child: Container(
                color: PiixColors.tertiaryText,
                child: ExpansionTile(
                  collapsedBackgroundColor: greyWhite,
                  backgroundColor: greyWhite,
                  textColor: PiixColors.infoDefault,
                  iconColor: darkSkyBlue,
                  collapsedIconColor: darkSkyBlue,
                  tilePadding:
                      EdgeInsets.symmetric(horizontal: mediumPadding.w),
                  title: Text(
                    benefitPerSupplier.benefitName,
                    style: context.textTheme?.bodyMedium,
                  ),
                  childrenPadding: EdgeInsets.only(
                    left: mediumPadding.w,
                    right: mediumPadding.w,
                    bottom: mediumPadding.h,
                  ),
                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PiixTagStoreDeprecated(
                      text: getBenefitTypeCopy(
                          benefitPerSupplier.benefitType?.name),
                      backgroundColor: getBenefitTypeColor(
                          benefitPerSupplier.benefitType?.name),
                      icon: Icon(
                        getBenefitTypeIcon(
                            benefitPerSupplier.benefitType?.name),
                        color: PiixColors.white,
                        size: 14.sp,
                      ),
                    ),
                    PiixHtmlParser(
                      html: benefitPerSupplier.wordingZero,
                    ),
                    Text.rich(TextSpan(
                      children: [
                        TextSpan(
                          text: '${PiixCopiesDeprecated.supplier}: ',
                          style: context.primaryTextTheme?.titleSmall?.copyWith(
                            color: PiixColors.secondary,
                          ),
                        ),
                        TextSpan(text: '${benefitPerSupplier.supplierName}'),
                      ],
                      style: context.textTheme?.bodyMedium?.copyWith(
                        color: PiixColors.secondary,
                      ),
                    )).padBottom(16.h),
                    if (benefitPerSupplier.hasCobenefits)
                      LevelCobenefitsListDeprecated(
                        cobenefitsPerSupplier:
                            benefitPerSupplier.cobenefitsPerSupplier,
                      ),
                    Text(
                      PiixCopiesDeprecated.knowTheCoverage,
                      style: context.primaryTextTheme?.labelLarge?.copyWith(
                        color: PiixColors.secondary,
                      ),
                    ).padBottom(8.h),
                    Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                            onTap: () =>
                                showDetailInfo(context, benefitPerSupplier),
                            child: Text(
                              PiixCopiesDeprecated.viewThisBenefit,
                              style: context.textTheme?.labelLarge?.copyWith(
                                color: PiixColors.active,
                              ),
                            ))),
                  ],
                ),
              ),
            );
          }).toList(),
          orElse: () => [
            const SizedBox(),
          ],
        ),
      ),
    );
  }

  Future<void> _initScreen() async {
    final userBLoC = context.read<UserBLoCDeprecated>();
    final levelsBLoC = context.read<LevelsBLoCDeprecated>();
    final fileSystemBloc = context.read<FileSystemBLoC>();
    if (userBLoC.user == null) return;
    level.maybeMap(
        (value) => value.benefits.forEach((benefit) {
              final callService = benefit.supplier?.logo != null &&
                  benefit.supplier?.logoMemory == null;
              if (callService) {
                logoProviderFutures.add(
                  fileSystemBloc.getFileFromPath(
                    userId: userBLoC.user!.userId,
                    filePath: benefit.supplier!.logo,
                    propertyName:
                        'supplierLogo/${benefit.supplier?.supplierId}',
                  ),
                );
              }
            }),
        orElse: () {});
    if (logoProviderFutures.isEmpty) return;
    final supplierLogoFiles = await Future.wait(logoProviderFutures);
    levelsBLoC.setSupplierLogoImageFiles(
      supplierLogoFiles,
      level.levelId,
    );
  }

  void showDetailInfo(
      BuildContext context, BenefitPerSupplierModel benefitPerSupplier) {
    final benefitPerSupplierBLoC =
        context.read<BenefitPerSupplierBLoCDeprecated>();
    if (benefitPerSupplier.supplier == null) return;
    final additionalBenefitPerSupplier = BenefitPerSupplierModel.purchased(
      benefitPerSupplierId: benefitPerSupplier.benefitPerSupplierId,
      folio: '',
      wordingZero: benefitPerSupplier.wordingZero,
      benefitImage: benefitPerSupplier.benefitImage,
      pdfWording: benefitPerSupplier.pdfWording,
      supplier: benefitPerSupplier.supplier!,
      benefit: benefitPerSupplier.benefit,
      benefitType: benefitPerSupplier.benefitType,
      fromStore: true,
    );
    benefitPerSupplierBLoC.setSelectedAdditionalBenefitPerSupplier(
      additionalBenefitPerSupplier,
    );
    NavigatorKeyState()
        .getNavigator(context)
        ?.pushNamed(BenefitPerSupplierDetailScreenDeprecated.routeName);
  }
}
