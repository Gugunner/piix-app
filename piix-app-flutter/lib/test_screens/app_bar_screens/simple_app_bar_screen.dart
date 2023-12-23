import 'package:flutter/material.dart';
import 'package:piix_mobile/widgets/app_bar/title_app_bar.dart';

class SimpleAppBarScreen extends StatelessWidget {
  static const routeName = '/simple_app_bar';
  const SimpleAppBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleAppBar(
        'Simple App Bar',
      ),
      body: const SingleChildScrollView(),
    );
  }
}
