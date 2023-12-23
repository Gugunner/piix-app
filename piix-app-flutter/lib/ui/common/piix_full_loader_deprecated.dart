import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/domain/bloc/ui_bloc.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:provider/provider.dart';

@Deprecated('Use AppLoadingWidget')
class PiixFullLoaderDeprecated extends StatelessWidget {
  const PiixFullLoaderDeprecated({Key? key, this.loadText}) : super(key: key);
  final String? loadText;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final uiBLoc = context.watch<UiBLoC>();
    return Container(
      width: size.width,
      color: PiixColors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CircularProgressIndicator.adaptive(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              loadText ?? uiBLoc.loadText,
              textAlign: TextAlign.center,
              style: context.textTheme?.titleMedium,
            ),
          )
        ],
      ),
    );
  }
}
