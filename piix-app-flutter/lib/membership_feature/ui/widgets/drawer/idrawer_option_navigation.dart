import 'package:flutter/material.dart';


///An abstract interface class that can be extended or implemented
///and allows for any class that implements it to be able to be treated as
///a [Widget] note that it is necessary for the class to extend from
///a [StatelessWidget] or [StatefulWidget] so it can build.
///
///This class is used for the [AppDrawer] children.
abstract interface class IDrawerOptionNavigation extends Widget {
  const IDrawerOptionNavigation({super.key});

  ///Return a AppLocalization message
  String getOptionMessage(BuildContext context);
  ///Navigate to another Screen 
  void navigateTo(BuildContext context);
}
