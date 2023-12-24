import 'package:flutter/material.dart';
import 'package:piix_mobile/widgets/button/app_button_barrel_file.dart';

///An app wrapper button that allows to call all original
///Flutter Material [Radio] widgets with a scalable size approach.
final class AppRadioButton<T> extends Radio implements IAppListTileButton{
  const AppRadioButton({
    super.key,
    required super.value,
    required super.groupValue,
    required super.onChanged,
    super.mouseCursor,
    super.toggleable = false,
    super.activeColor,
    super.fillColor,
    super.focusColor,
    super.hoverColor,
    super.overlayColor,
    super.splashRadius,
    super.materialTapTargetSize,
    super.visualDensity,
    super.focusNode,
    super.autofocus = false,

  ///The default scale value that
  ///is used by the app general design.
    this.scale = 1.65,
  });

  ///Modify this value to increase or decrease
  ///the size of the radio.
  final double? scale;

  @override
  State<AppRadioButton<T>> createState() => _AppRadioButtonState<T>();
}

///Builds a [Radio] widget wrapped inside a [Transform] widget with the scale
///constructor to resize the button based on a [scale].
final class _AppRadioButtonState<T> extends State<AppRadioButton<T>> {
  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: widget.scale,
      child: Radio.adaptive(
        value: widget.value,
        groupValue: widget.groupValue,
        onChanged: widget.onChanged,
        mouseCursor: widget.mouseCursor,
        toggleable: widget.toggleable,
        activeColor: widget.activeColor,
        fillColor: widget.fillColor,
        focusColor: widget.focusColor,
        hoverColor: widget.hoverColor,
        overlayColor: widget.overlayColor,
        splashRadius: widget.splashRadius,
        materialTapTargetSize: widget.materialTapTargetSize,
        visualDensity: widget.visualDensity,
        focusNode: widget.focusNode,
        autofocus: widget.autofocus,
      ),
    );
  }
}
