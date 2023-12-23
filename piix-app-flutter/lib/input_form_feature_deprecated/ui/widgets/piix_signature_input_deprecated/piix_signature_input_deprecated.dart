import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piix_mobile/form_feature/domain/model/form_field_model_deprecated.dart';
import 'package:piix_mobile/form_feature/domain/provider/form_provider_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/input_form_feature_deprecated/ui/widgets/piix_signature_input_deprecated/piix_signature_controls_deprecated.dart';
import 'package:piix_mobile/input_form_feature_deprecated/ui/widgets/piix_signature_input_deprecated/piix_signature_header_deprecated.dart';
import 'package:signature/signature.dart';

@Deprecated('Will be removed in 6.0')

///A collection of values that reflect what happens when the user
///is drawing using [PiixSignatureFormFieldDeprecated].
enum DrawingStateDeprecated {
  idle,
  paint,
  stop,
  clean,
  use,
  error,
}

@Deprecated('Will be removed in 6.0')

///Widget used as container that allows the user to manually sign or write
///inside of it for "signedName" dataTypeId formFields [FormFieldModelOld].
///
/// All calculations are made using getters, if any additional information is to
/// be inserted, consider using service locators or dependency injections. The
/// only property received in the constructor is a [formField] which is derived
/// from a [FormFieldModelOld] and contains all the information to retrieve
/// and store user response.
///
/// This uses a [SignatureController] to be able to manipulate when the user
/// starts drawing or ends drawing, this is applied when the user touches the
/// form field or when the user stops touching the form field respectively.
class PiixSignatureFormFieldDeprecated extends ConsumerStatefulWidget {
  const PiixSignatureFormFieldDeprecated({
    Key? key,
    required this.formField,
  }) : super(key: key);

  ///A data model that contains all the information to render the
  ///[PiixSignatureFormFieldDeprecated]
  final FormFieldModelOld formField;

  @override
  ConsumerState<PiixSignatureFormFieldDeprecated> createState() =>
      _PiixSignatureFormFieldState();
}

class _PiixSignatureFormFieldState
    extends ConsumerState<PiixSignatureFormFieldDeprecated> {
  ///The controller that is used to monitor user interaction
  late SignatureController _signatureController;

  ///A simple state to know what the user is doing.
  DrawingStateDeprecated drawingState = DrawingStateDeprecated.idle;

  FormFieldModelOld get formField => widget.formField;

  @override
  void initState() {
    super.initState();
    //The signature controller must be initialized before it can be used
    _signatureController = SignatureController(
      exportBackgroundColor: Colors.white,
      onDrawStart: onSignatureStart,
      onDrawEnd: onSignatureEnd,
    );
  }

  @override
  void dispose() {
    //The controller needs to me dispose to avoid memory leaks
    _signatureController.dispose();
    super.dispose();
  }

  ///When the user touches the form field it is translated as the user is
  ///painting.
  void onSignatureStart() {
    setState(() {
      drawingState = DrawingStateDeprecated.paint;
    });
  }

  ///When the user stops touching the form field it is translated as the user
  ///is stopping.
  void onSignatureEnd() {
    setState(() {
      drawingState = DrawingStateDeprecated.stop;
    });
  }

  ///The user may need to clean everything is drawn and this needs
  ///to clear the [_signatureController] data, clean the [formField] property
  ///[stringResponse] and translate the state as cleaned.
  void onSignatureClean() {
    setState(() {
      drawingState = DrawingStateDeprecated.clean;
    });
    ref.read(formNotifierProvider.notifier).updateFormField(
          formField: formField,
          value: null,
          type: ResponseType.string,
        );
    _signatureController.clear();
  }

  ///When the user finishes painting it's signature, the user can
  ///store the paint in the [formField] property [stringResponse]
  ///
  /// The image is stored as a base64 [String], it is translated as using.
  /// If an error occurs when storing the base64 [String], it is translated
  /// as error.
  void onUseSignature() async {
    try {
      final imagePngBytes = await _signatureController.toPngBytes();
      if (imagePngBytes == null) {
        throw Exception('Image PNG Bytes in signature field is null');
      }
      final base64Data = base64Encode(imagePngBytes);
      ref.read(formNotifierProvider.notifier).updateFormField(
            formField: formField,
            value: base64Data,
            type: ResponseType.string,
          );
      setState(() {
        drawingState = DrawingStateDeprecated.use;
      });
    } catch (e) {
      setState(() {
        drawingState = DrawingStateDeprecated.error;
      });
    }
  }

  ///A simple way of knowing if the user is considered to have started drawing
  ///even if it stopped or finished.
  bool get isDrawing => drawingState != DrawingStateDeprecated.idle;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: context.height * 0.0085,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PiixSignatureHeaderDeprecated(formField: formField),
          Text(
            '${PiixCopiesDeprecated.requiredField} ${PiixCopiesDeprecated.signature}',
            style: context.textTheme?.bodyMedium?.copyWith(
              color: drawingState == DrawingStateDeprecated.use
                  ? PiixColors.insurance
                  : PiixColors.infoDefault,
            ),
          ),
          Container(
            padding: EdgeInsets.zero,
            decoration: decoration,
            height: context.height * 0.38,
            width: context.width * 0.88,
            margin: EdgeInsets.only(
              top: context.height * 0.0085,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  child: IgnorePointer(
                    ignoring: drawingState == DrawingStateDeprecated.use,
                    child: Center(
                      child: Signature(
                        controller: _signatureController,
                        height: context.height * 0.38,
                        width: context.width * 0.86,
                        backgroundColor:
                            drawingState != DrawingStateDeprecated.use
                                ? Colors.transparent
                                : PiixColors.brownGrey.withOpacity(
                                    0.18,
                                  ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // if (isDrawing)
          PiixSignatureControlsDeprecated(
            onSignatureClean: onSignatureClean,
            onUseSignature: onUseSignature,
            drawingState: drawingState,
          ),
        ],
      ),
    );
  }
}

///An extension used to decorate the [PiixSignatureFormFieldDeprecated] styles, texts and
///colors
extension _PiixSignatureFormFieldDecorator on _PiixSignatureFormFieldState {
  ///A simple evaluation to know if the [_signatureController] has no
  ///information
  ///and the example image can be shown.
  bool get showExample =>
      drawingState == DrawingStateDeprecated.idle ||
      drawingState == DrawingStateDeprecated.clean;

  ///Based on the [formField] property [signatureType] choose the
  ///url to load the example image.
  String get urlExampleImage {
    switch (formField.signatureType) {
      case SignatureType.SIGNING:
        return ConstantsDeprecated.completeNameUrl;
      case SignatureType.NAME_AND_PLACE:
      default:
        return ConstantsDeprecated.placeAndDateUrl;
    }
  }

  ///The decoration used by [PiixSignatureFormFieldDeprecated]
  BoxDecoration get decoration => BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: PiixColors.brownGrey),
        image: showExample
            ? DecorationImage(
                image: NetworkImage(urlExampleImage, scale: 0.5),
                colorFilter: ColorFilter.mode(
                    const Color(0Xd9d9d9).withOpacity(0.6), BlendMode.dstOut),
                opacity: 0.9,
                fit: BoxFit.contain)
            : null,
      );
}
