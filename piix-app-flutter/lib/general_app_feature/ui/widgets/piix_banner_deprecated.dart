import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

@Deprecated('Use instead AppOverlayBannerEntry')

///A special class that is used as a singleton inside the app to build
///banners that overlay the entire screen disregarding the current
///Scaffold.
class PiixBannerDeprecated {
  PiixBannerDeprecated._();

  //A unique property that ensure the app only has one
  //instance.
  static final instance = PiixBannerDeprecated._();
  //Initialize a late entry
  OverlayEntry? entry;

  //If the entry is initialized it removes all the content inside and
  //finally it removes any value from the property.
  void removeEntry() {
    if (entry == null) return;
    entry?.remove();
    entry = null;
  }

  ///A simple builder that creates an [OverlayEntry] to be positioned
  ///over any Scaffold.
  ///
  ///Receives a [context] to insert the overlay in the same
  ///building context of the app.
  ///
  ///Receives a list of [Widget] that will be inside a [Stack]
  ///and position each element accordingly.
  void builder(
    BuildContext context, {
    required List<Widget> children,

    ///The number of seconds the banner will exist
    int seconds = 5,
    double? height,
  }) {
    //The number of ticks the [Timer] should allow
    final ticker = seconds;

    ///In which context the overlay needs to be applied.
    final overlay = Overlay.of(context);
    if (entry != null) return;

    ///The content of the Overlay.
    entry = OverlayEntry(
      builder: (context) {
        final padding = MediaQueryData.fromView(ui.window).padding;
        final top = padding.top;
        return Positioned(
          top: top,
          left: 0,
          child: GestureDetector(
            onVerticalDragUpdate: (details) {
              if (details.delta.dy < 0) {
                removeEntry();
              }
            },
            child: Column(
              children: [
                LimitedBox(
                  maxHeight: context.height,
                  maxWidth: context.width,
                  child: Stack(
                    children: [
                      ...children,
                      Positioned(
                        top: 8.h,
                        right: 12.w,
                        child: GestureDetector(
                          onTap: removeEntry,
                          child: Icon(
                            Icons.close,
                            color: PiixColors.white,
                            size: 12.w,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    ///Once the content for the Overlay is defined
    ///it is inserted in the context.
    if (entry != null) {
      overlay.insert(entry!);
      //A simple timer that removes the entry (banner) once its tick value
      //is greater or equal to the ticker value defined at the beginning.
      //The tick advances each second.
      Timer.periodic(const Duration(seconds: 1), (timer) {
        if (timer.tick >= ticker) {
          timer.cancel();
          removeEntry();
        }
      });
    }
  }
}
