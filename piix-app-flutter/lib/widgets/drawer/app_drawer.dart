import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/membership_feature/membership_ui_barrel_file.dart';

///A defined [Drawer] that uses [CustomScrollView] to add a [SliverList] of
///items to create a [header], and a body conformed of [children] and a
///[footer].
///
///For practicality and reuse the [header], [footer] and [children] are
///optional properties so the [AppDrawer] can be customized.
///
///
final class AppDrawer extends Drawer {
  AppDrawer({super.key, this.header, this.footer, this.children})
      : super(
            width: 236.w,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 0),
              child: CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildListDelegate([
                      if (header != null) header,
                      if (children != null) ...children,
                    ]),
                  ),
                  if (footer != null)
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: footer,
                      ),
                    )
                ],
              ),
            ));

  ///Pass a custom header to the [AppDrawer].
  final Widget? header;

  ///Pass a custom footer that is fixed after the [children]
  ///and uses all remaining space (if any) of the [AppDrawer].
  final Widget? footer;
  ///Pass a list of [Widget] that constitute the [body] of 
  ///the [AppDrawer]
  final List<IDrawerOptionNavigation>? children;
}
