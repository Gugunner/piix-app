import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

///A static app bar for the app.
///
///Uses the default values found in  [AppBarTheme] for
///the [ThemeData] and can only declare [leading],
///[title] and [actions] properties.
@Deprecated('Use DefinedAppBar instead')
abstract class StaticAppBar extends ConsumerWidget
    implements PreferredSizeWidget {
  const StaticAppBar({
    super.key,
    this.simple = false,
    this.toolbarHeight = kToolbarHeight,
    this.leading,
    this.title,
    this.actions,
    this.bottom,
  }) : assert(
          !simple ||
              (simple && leading != null ||
                  actions != null ||
                  (title != null && title.length > 0)),
        );

  /// Defines the height of the toolbar component of an [AppBar].
  ///
  /// By default, the value of [toolbarHeight] is [kToolbarHeight].
  /// {@endtemplate}
  final double toolbarHeight;

  /// This widget appears across the bottom of the app bar.
  ///
  /// Typically a [TabBar]. Only widgets that implement
  /// [PreferredSizeWidget] can be used at the bottom
  /// of an app bar.
  final PreferredSizeWidget? bottom;

  ///When true the app bar has no leading or
  ///trailing widgets [actions], it must also contain
  ///a [title]. Use this when the
  ///navigation is starting or resetting with
  ///no other screens in the stack. Preferrably
  ///after the first push or push and replace all.
  ///If there is a navigation stack, the [leading]
  ///will be a return arrow button to navigate back.
  final bool simple;

  ///A widget to display before the toolbar's [title].
  final Widget? leading;

  ///The text to appear at the center of the
  ///app bar as a headline.
  final String? title;

  ///A list of Widgets to display in a row after the title.
  final List<Widget>? actions;

  ///Needs an override with default values to implement [PreferredSizeWidget]
  ///which is needed to make Widget work as an [AppBar]
  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight);
}

@Deprecated('Use DefinedAppBar instead')
class StaticAppBarBuilder extends StaticAppBar {
  const StaticAppBarBuilder({
    super.key,
    super.toolbarHeight,
    super.simple,
    super.leading,
    super.title,
    super.actions,
    super.bottom,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      toolbarHeight: toolbarHeight,
      bottom: bottom,
      leading: leading,
      title: LimitedBox(
        maxHeight: 20.h,
        maxWidth: 224.w,
        child: Text(
          title ?? '',
          style: context.accentTextTheme?.displayMedium?.copyWith(
            color: PiixColors.space,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
      ),
      actions: actions,
    );
  }
}
