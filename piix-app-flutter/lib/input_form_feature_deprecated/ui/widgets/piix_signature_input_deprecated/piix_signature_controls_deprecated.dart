import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/input_form_feature_deprecated/ui/widgets/piix_signature_input_deprecated/piix_signature_input_deprecated.dart';

@Deprecated('Will be removed in 6.0')
//TODO: Add documentation
class PiixSignatureControlsDeprecated extends StatelessWidget {
  const PiixSignatureControlsDeprecated({
    Key? key,
    this.onSignatureClean,
    this.onUseSignature,
    this.drawingState = DrawingStateDeprecated.idle,
  }) : super(key: key);

  //TODO: Explain property
  final VoidCallback? onSignatureClean;
  //TODO: Explain property
  final VoidCallback? onUseSignature;
  //TODO: Explain property
  final DrawingStateDeprecated drawingState;

  //TODO: Explain getter
  bool get useDrawing => drawingState == DrawingStateDeprecated.stop;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: context.height * 0.0085,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          OutlinedButton(
            style: Theme.of(context).outlinedButtonTheme.style?.copyWith(
                  minimumSize: MaterialStatePropertyAll<Size>(
                    Size(
                      context.width * 0.195,
                      context.height * 0.05,
                    ),
                  ),
                ),
            onPressed: onSignatureClean,
            child: Text(
              PiixCopiesDeprecated.clear,
              style: context.primaryTextTheme?.titleMedium
                  ?.copyWith(color: PiixColors.active),
            ),
          ),
          OutlinedButton(
            style: Theme.of(context).outlinedButtonTheme.style?.copyWith(
                minimumSize: MaterialStatePropertyAll<Size>(
                  Size(
                    context.width * 0.195,
                    context.height * 0.05,
                  ),
                ),
                textStyle: MaterialStateProperty.resolveWith<TextStyle>(
                  (states) {
                    if (states.contains(MaterialState.disabled)) {
                      return context.primaryTextTheme?.titleMedium
                              ?.copyWith(color: PiixColors.inactive) ??
                          const TextStyle();
                    }
                    return context.primaryTextTheme?.titleMedium
                            ?.copyWith(color: PiixColors.active) ??
                        const TextStyle();
                  },
                )),
            onPressed: useDrawing ? onUseSignature : null,
            child: const Text(
              PiixCopiesDeprecated.use,
            ),
          )
        ],
      ),
    );
  }
}
