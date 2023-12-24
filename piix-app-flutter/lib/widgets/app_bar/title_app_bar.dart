import 'package:flutter/material.dart';
import 'package:piix_mobile/widgets/app_bar/app_bar_title.dart';
import 'package:piix_mobile/widgets/app_bar/defined_app_bar.dart';

///A simple [title] for the app bar based on a [Text] widget.
///
///It may contain a back arrow or not depending on where in the stack is
///the [Scaffold] that contains it.
final class TitleAppBar extends DefinedAppBar {
  TitleAppBar(this.text, {super.key, super.leading})
      : super(
          title: AppBarTitle(text),
        );

  final String text;
}
