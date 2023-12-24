import 'package:flutter/material.dart';
import 'package:piix_mobile/widgets/banner/app_banner.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_banner_provider.g.dart';

///A specific provider that works as a single instance to set and
///build an app banner based on the [BannerType].
@Riverpod(keepAlive: true)
class BannerPod extends _$BannerPod {
  @override
  AppOverlayBannerEntry? build() => null;

  ///Sets the banner content values and
  ///[cause] of banner to be built and
  ///calls [_buildBanner].
  void setBanner(
    BuildContext context, {
    required BannerCause cause,
    required String description,
    bool addIcon = true,
    String? title,
    String? actionText,
    VoidCallback? action,
    VoidCallback? onClose,
  }) {
    ///Checks if either the [state] or the [OverlayEntry] are already set.
    if (state?.entry != null) return;
    state = AppOverlayBannerEntry(
      cause,
      description: description,
      addIcon: addIcon,
      title: title,
      actionText: actionText,
      action: action,
      onClose: onClose,
    );
    _buildBanner(context);
  }

  ///Builds the banner and mounts it in the [context]
  void _buildBanner(BuildContext context) {
    state?.onLaunch(context);
  }

  ///Removes the banner from the [context].
  ///
  ///Use it every time you are Navigating out of the
  ///current [context].
  void removeBanner() {
    state?.removeEntry();
    state = null;
  }
}
