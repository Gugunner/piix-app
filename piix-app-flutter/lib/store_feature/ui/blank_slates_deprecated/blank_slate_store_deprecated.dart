import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:piix_mobile/navigation_feature/utils/navigator_key_state.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_assets.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/store_feature/utils/skeletons.dart';

@Deprecated('Will be removed in 4.0')

///This widget is a empty blank slate for the store.
///Receives a label, because it is used for benefits, plans and levels
///
class BlankSlateStoreDeprecated extends StatelessWidget {
  const BlankSlateStoreDeprecated({
    Key? key,
    required this.label,
  }) : super(key: key);
  final String label;

  @override
  Widget build(BuildContext context) {
    final width = context.width;
    return SizedBox(
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          //This widget is for empty label
          Text.rich(
            TextSpan(children: [
              const TextSpan(
                text: PiixCopiesDeprecated.currentNotHave,
              ),
              TextSpan(
                text: label,
                style: context.textTheme?.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const TextSpan(
                text: PiixCopiesDeprecated.availableToBuy,
              )
            ]),
            textAlign: TextAlign.center,
            style: context.textTheme?.titleMedium,
          ),
          //This widget is for empty search image
          Padding(
            padding: EdgeInsets.only(top: 19.h, bottom: 16.h),
            child: SvgPicture.asset(
              PiixAssets.searchEmpty,
              height: 97.6.h,
            ),
          ),
          //This widget is for back to store button
          SizedBox(
            height: 32.h,
            width: width.percentageSize(0.569),
            child: ElevatedButton(
              style: Theme.of(context).elevatedButtonTheme.style,
              onPressed: () => NavigatorKeyState().getNavigator()?.pop(),
              child: Text(
                PiixCopiesDeprecated.backToStore.toUpperCase(),
                style: context.primaryTextTheme?.titleMedium?.copyWith(
                  color: PiixColors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
