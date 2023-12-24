import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/enums/enums.dart';
import 'package:piix_mobile/extensions/widget_extend.dart';
import 'package:piix_mobile/general_app_feature/navigation_deprecated/navigation_provider_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/ui/widgets/membership/piix_alert_info_deprecated.dart';
import 'package:piix_mobile/store_feature/domain/bloc/package_combos_bloc.dart';
import 'package:piix_mobile/store_feature/ui/package_combos/widgets/package_combo_card_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/widgets/title_tooltip_list_deprecated.dart';
import 'package:piix_mobile/store_feature/utils/additional_benefit_per_supplier.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

///This widget render a package combo card list
///
class PackageComboListScreenDeprecated extends StatefulWidget {
  static const routeName = '/package_combos_list';
  const PackageComboListScreenDeprecated({Key? key}) : super(key: key);

  @override
  State<PackageComboListScreenDeprecated> createState() =>
      _PackageComboListScreenDeprecatedState();
}

class _PackageComboListScreenDeprecatedState
    extends State<PackageComboListScreenDeprecated> {
  AlertStateDeprecated alertState = AlertStateDeprecated.show;
  @override
  Widget build(BuildContext context) {
    final navigationProvider = context.watch<NavigationProviderDeprecated>();
    final packageComboBLoC = context.watch<PackageComboBLoC>();
    final packageCombosList = packageComboBLoC.packageCombosList;
    final isSimultaneousCombo = packageCombosList.any(
      (combo) => combo.maybeMap((value) => value.isPartiallyAcquired,
          orElse: () => false),
    );
    return Stack(
      children: [
        ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: packageCombosList.length,
          padding: EdgeInsets.symmetric(
            vertical: 22.5.h,
            horizontal: 16.w,
          ),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (index == 0) ...[
                  //Render a combo title with tooltip icon
                  TitleTooltipListDeprecated(
                    label: PiixCopiesDeprecated.combos,
                    message: PiixCopiesDeprecated.combos.infoTooltip(),
                  ),
                  //Render a combos brief
                  Text(
                    PiixCopiesDeprecated.combosListBrief,
                    style: context.textTheme?.bodyMedium,
                  ).padVertical(20.h),
                ],
                //Render a package combo cards
                PackageComboCardDeprecated(
                  packageCombo: packageCombosList[index],
                ).padBottom(24.h)
              ],
            );
          },
        ),
        if (isSimultaneousCombo && alertState == AlertStateDeprecated.show)
          PiixAlertInfoDeprecated(
            subtitle: PiixCopiesDeprecated.simultaneousCombo,
            backgroundColor: PiixColors.simultaneousColor,
            actionText: PiixCopiesDeprecated.knowMore.toUpperCase(),
            actionStyle: context.textTheme?.labelLarge?.copyWith(
              color: PiixColors.space,
            ),
            onAction: () => navigationProvider.navigatesToProtectedTab(),
            onClose: hideAlertState,
          )
      ],
    );
  }

  void hideAlertState() =>
      setState(() => alertState = AlertStateDeprecated.hide);
}
