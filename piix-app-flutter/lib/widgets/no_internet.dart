import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

/// Creates a widget that show a no internet message.
class NoInternet extends StatelessWidget {
  const NoInternet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Text(
          PiixCopiesDeprecated.noConnection,
          style: context.textTheme?.titleMedium,
        ),
      ),
    );
  }
}
