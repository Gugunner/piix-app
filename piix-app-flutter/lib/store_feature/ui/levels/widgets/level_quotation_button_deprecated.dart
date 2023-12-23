import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/navigation_feature/utils/navigator_key_state.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/store_feature/domain/bloc/levels_bloc_deprecated.dart';
import 'package:piix_mobile/store_feature/domain/model/level_model.dart';
import 'package:piix_mobile/store_feature/ui/quotations/level/level_quotation_home_screen_deprecated.dart';
import 'package:piix_mobile/store_feature/utils/store_copies.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

///This is a quptation level button, navigate to quotation screen and set a
///current level id
///
class LevelQuotationButtonDeprecated extends StatelessWidget {
  const LevelQuotationButtonDeprecated({
    super.key,
    required this.levelSelect,
  });
  final LevelModel levelSelect;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: context.width * 0.579,
        height: 32.h,
        child: ElevatedButton(
          style: Theme.of(context).elevatedButtonTheme.style,
          onPressed: () => handleNavigationToLevelQuotation(context),
          child: Text(
            StoreCopiesDeprecated.quoteAndCompare.toUpperCase(),
            style: context.accentTextTheme?.labelMedium?.copyWith(
              color: PiixColors.space,
            ),
          ),
        ),
      ),
    );
  }

  void handleNavigationToLevelQuotation(BuildContext context) {
    final levelsBLoC = context.read<LevelsBLoCDeprecated>();
    levelsBLoC.setCurrentLevel(levelSelect);
    NavigatorKeyState()
        .getNavigator(context)
        ?.pushNamed(LevelQuotationHomeScreenDeprecated.routeName);
  }
}
