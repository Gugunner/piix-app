import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/widgets/banner/banner_barrel_file.dart';

///Declares and gives a type to all banners used in Piix.
abstract interface class IAppBanner {
  ///Banners should be launched and logic handled in this method.
  void onLaunch(BuildContext context);

  ///Banners should be closed and any state control be handled
  ///in this method.
  void removeEntry();
}

///Acts as the parent for all the banner widgets and contains the main
///logic to create and launch a banner as well as to close and remove a banner
///through the [entry].
// ignore: must_be_immutable
abstract class AppOverlayBanner implements IAppBanner {
  AppOverlayBanner({this.maintainState = false});

  //Whether this banner entry must be included in the tree even if there is a
  ///fully [opaque] banner entry above it.
  /// By default, if there is an entirely [opaque] banner entry over this one,
  /// then this one will not be included in the widget tree. To ensure that
  /// your overlay entry is still built even if it is not visible,
  /// set [maintainState] to true. This is more expensive, so should be done
  /// with care. Check [OverlayEntry] maintainState documentation
  /// for more information.
  final bool maintainState;

  ///The entry that is overlaid in a Screen and contains
  ///the Banner.
  OverlayEntry? entry = null;

  ///Creates the entry Widget structure.
  OverlayEntry createEntry(BuildContext context);

  ///Builds the overlay banner and calls the creation of the entry
  ///in the app.
  @override
  void onLaunch(BuildContext context) {
    entry = entry ?? createEntry(context);
    if (entry == null) return;
    if (maintainState) entry!.maintainState = maintainState;
    Overlay.of(context).insert(entry!);
  }

  ///The banner overlay is removed from the app.
  @override
  void removeEntry() {
    if (entry == null) return;
    entry?.remove();
    entry = null;
  }
}

///The values that reflect what causes a banner to appear.
enum BannerCause {
  success(
    backgroundColor: PiixColors.success,
    icon: Icons.check_circle_outline,
  ),
  warning(
    backgroundColor: PiixColors.process,
    icon: Icons.warning,
  ),
  error(
    backgroundColor: PiixColors.error,
    icon: Icons.info_outline,
  );

  const BannerCause({required this.backgroundColor, required this.icon});

  final Color backgroundColor;
  final IconData icon;
}

///Creates a Banner and its [OverlayEntry] to
///mount it in the parent [Widget].
///
/// To launch the Banner call [onLaunch].
/// To close the Banner call [removeEntry].
class AppOverlayBannerEntry extends AppOverlayBanner {
  AppOverlayBannerEntry(
    this.cause, {
    required this.description,
    this.addIcon = true,
    super.maintainState,
    this.title,
    this.actionText,
    this.action,
    this.onClose,
  });

  ///The cause that triggered a banner either.
  final BannerCause cause;

  ///The message inside the banner.
  final String description;

  ///Choos whether to show or not the banner cause icon.
  final bool addIcon;

  ///The header inside the banner.
  final String? title;

  ///The text shown in the button.
  final String? actionText;

  ///The callback to execute if the button is pressed.
  final VoidCallback? action;

  ///The callback to execute when the banner is closed.
  final VoidCallback? onClose;

  ///Returns either the null action or the action wrapped
  ///inside an anonymous function which also calls [removeEntry].
  VoidCallback? get dismissableAction {
    if (action == null) return action;
    return () {
      removeEntry();
      action!.call();
    };
  }

  @override
  OverlayEntry createEntry(BuildContext context) {
    return OverlayEntry(
      builder: (overlayContext) => _BannerStack(
        BannerBuilder(
          description: description,
          cause: cause,
          title: title,
          action: dismissableAction,
          actionText: actionText,
          addIcon: addIcon,
        ),
        onClose: () {
          onClose?.call();
          removeEntry();
        },
      ),
    );
  }
}

///The contour form of the banner conformed by a [Stack]
///where its main element is the [child].
class _BannerStack extends StatelessWidget {
  const _BannerStack(
    this.child, {
    required this.onClose,
  });

  ///The top offset of the [CloseXButton].
  double get top => 12.h;

  ///The left offset of the [CloseXButton].
  double get right => 12.w;

  ///The main component in the [Stack].
  final Widget child;

  ///The callback to call when closing the banner.
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    ///The offset from the top so the banner does not occupy the
    ///OS information space.
    ///
    final bannerOffset = MediaQuery.of(context).padding.top;
    return Positioned(
      top: bannerOffset,
      child: Stack(
        children: [
          child,
          Positioned(
            right: right,
            top: top,
            child: CloseXButton(onClose),
          ),
        ],
      ),
    );
  }
}
