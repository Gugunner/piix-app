import 'package:flutter/material.dart';
import 'package:piix_mobile/widgets/app_bar/logo_app_bar.dart';

class LogoAppBarScreen extends StatelessWidget {
  static const routeName = '/logo_app_bar_screen';

  const LogoAppBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LogoAppBar(),
      body: const SingleChildScrollView(),
    );
  }
}
