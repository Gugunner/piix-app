import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';

@Deprecated('Use AppLoadingWidget')

///Widget for loading forms and other screens that to not have a template screen
class PiixSimpleProgressLoaderDeprecated extends StatelessWidget {
  const PiixSimpleProgressLoaderDeprecated({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: PiixColors.white,
      height: MediaQuery.of(context).size.height * 0.96,
      width: MediaQuery.of(context).size.width,
      child: const Stack(
        children: [
          LinearProgressIndicator(
            color: PiixColors.clearBlue,
            backgroundColor: PiixColors.twilightBlue,
            minHeight: 8,
          )
        ],
      ),
    );
  }
}
