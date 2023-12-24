import 'package:flutter/material.dart';
import 'package:piix_mobile/widgets/app_bar/info_tooltip_app_bar.dart';

class TooltipAppBarScreen extends StatelessWidget {
  static const routeName = '/information_app_bar_screen';
  const TooltipAppBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: InfoTooltipAppBar(
        appBarTitle: 'Tooltip App Bar',
        tooltipTitle: '',
        tooltipDescription: 'This is a tooltip test. '
            'Lorem Ipsum Sicum Dolos, '
            'lorem ipsum sicum dolos '
            'lorem ipsum sicum dolos '
            'lorem ipsum sicum dolos '
            'lorem ipsum sicum dolos '
            'lorem ipsum sicum dolos '
            'lorem ipsum sicum dolos '
            'lorem ipsum sicum dolos ',
      ),
      body: const SingleChildScrollView(),
    );
  }
}
