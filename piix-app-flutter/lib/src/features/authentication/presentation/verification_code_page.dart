import 'package:flutter/material.dart';
import 'package:piix_mobile/src/common_widgets/web_mobile_tablet_layout_builder.dart';
import 'package:piix_mobile/src/theme/piix_colors.dart';

class VerificationCodePage extends StatelessWidget {
  const VerificationCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebMobileTabletLayoutBuilder(
        twoColumn: Container(
          color: PiixColors.primary,
        ),
        oneColumn: Container(
          color: PiixColors.active,
        ),
        tablet: Container(
          color: PiixColors.highlight,
        ),
        mobile: Container(
          color: PiixColors.assist,
        ),
      ),
    );
  }
}
