import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/extensions/widget_extend.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/utils/extensions/list_extend.dart';
import 'package:piix_mobile/store_feature/domain/bloc/levels_bloc_deprecated.dart';
import 'package:piix_mobile/store_feature/domain/model/level_model.dart';
import 'package:piix_mobile/store_feature/ui/additional_benefits_per_supplier_deprecated/widgets_deprecated/already_acquired__additional_benefit_banner_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/levels/widgets/level_benefits_expansion_card_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/levels/widgets/level_quotation_button_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/levels/widgets/row_main_level_info_deprecated.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

///This widget render a column with levels tabs, each tab render a each level
///info, contains a level image, level name, level benefits and navigate button
///to quotation level
///
///A stateful widget is used to generate an ephemeral state and have a better
///performance
///
class LevelTabColumnDeprecated extends StatefulWidget {
  const LevelTabColumnDeprecated({Key? key}) : super(key: key);

  @override
  State<LevelTabColumnDeprecated> createState() =>
      _LevelTabColumnDeprecatedState();
}

class _LevelTabColumnDeprecatedState extends State<LevelTabColumnDeprecated>
    with TickerProviderStateMixin {
  double get mediumPadding => ConstantsDeprecated.mediumPadding;

  late TabController tabController;
  String selectedNameLevel = '';
  late List<LevelModel> levelList;
  int selectedTab = 0;

  bool get hasBenefitForm {
    final level = levelList[selectedTab];
    if (level.benefits.isNullOrEmpty) return false;
    return level.benefits!.any(
      (benefit) {
        if (benefit.hasBenefitForm) return true;
        if (benefit.cobenefitsPerSupplier.isEmpty) return false;
        return benefit.cobenefitsPerSupplier.any(
          (coBenefit) => coBenefit.hasBenefitForm,
        );
      },
    );
  }

  @override
  void initState() {
    final levelsBLoC = context.read<LevelsBLoCDeprecated>();
    levelList = levelsBLoC.filteredLevels;
    tabController = TabController(
      initialIndex: 0,
      length: levelList.length,
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (levelList.isEmpty) return const SizedBox();
    final level = levelList[selectedTab].mapOrNull((value) => value);
    if (level == null) return const SizedBox();
    return Card(
      elevation: 3,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar(
            controller: tabController,
            isScrollable: levelList.length > 4,
            indicatorColor: PiixColors.twilightBlue,
            labelPadding: EdgeInsets.zero,
            labelStyle: context.textTheme?.headlineMedium,
            unselectedLabelStyle: context.textTheme?.titleMedium,
            labelColor: PiixColors.primary,
            unselectedLabelColor: PiixColors.primary,
            onTap: (tab) {
              setState(() {
                selectedNameLevel = levelList[tab].name;
                selectedTab = tab;
              });
            },
            tabs: levelList.map((level) {
              return Tab(
                key: Key(level.levelId),
                text: level.name,
              );
            }).toList(),
          ),
          if (level.isPartiallyAcquired)
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.symmetric(
                  vertical: 4.h,
                ),
                child: AlreadyAcquiredAdditionalBenefitBannerDeprecated(
                  label:
                      PiixCopiesDeprecated.haveThisLevelButAnyProtectedNoBanner,
                  color: PiixColors.process,
                  height: 30.h,
                  labelStyle: context.accentTextTheme?.titleLarge?.copyWith(
                    color: PiixColors.space,
                  ),
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(8)),
                ),
              ),
            ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: mediumPadding.w,
              vertical: mediumPadding.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RowMainLevelInfoDeprecated(
                  selectedTab: selectedTab,
                ).padHorizontal(mediumPadding.w).padBottom(20.h),
                if (level.benefits.isNotEmpty) ...[
                  Text(
                    PiixCopiesDeprecated.newBenefits,
                    style: context.textTheme?.headlineSmall,
                  ).padBottom(mediumPadding.h),
                  Text(
                    PiixCopiesDeprecated.eachLevelOfferBenefit,
                    style: context.textTheme?.bodyMedium?.copyWith(
                      color: PiixColors.secondary,
                    ),
                  ).padBottom(mediumPadding.h),
                  LevelBenefitsExpansionCardDeprecated(
                    key: Key(level.levelId),
                    levelList: levelList,
                    selectedTab: selectedTab,
                  ).padBottom(16.h),
                ],
                if (hasBenefitForm)
                  Text(
                    PiixCopiesDeprecated.alreadyBenefitsInLevel,
                    style: context.primaryTextTheme?.labelLarge,
                  ).padBottom(mediumPadding.h),
                Text(
                  PiixCopiesDeprecated.benefitsWithBetterCoverage,
                  style: context.textTheme?.headlineSmall,
                ).padBottom(mediumPadding.h),
                Text(
                  PiixCopiesDeprecated.levelUpLabel,
                  style: context.textTheme?.bodyMedium?.copyWith(
                    color: PiixColors.secondary,
                  ),
                ).padBottom(mediumPadding.h),
                LevelQuotationButtonDeprecated(levelSelect: level)
                    .padBottom(8.h),
                Center(
                  child: Text(
                    level.isPartiallyAcquired
                        ? PiixCopiesDeprecated.haveThisLevelButAnyProtectedNo
                        : PiixCopiesDeprecated.discoverBenefitsofLevel,
                    style: context.textTheme?.labelMedium?.copyWith(
                      color: level.isPartiallyAcquired
                          ? PiixColors.simultaneousColor
                          : PiixColors.darkBlue,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
