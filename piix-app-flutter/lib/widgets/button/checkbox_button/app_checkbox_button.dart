import 'package:flutter/material.dart';
import 'package:piix_mobile/widgets/button/app_button_barrel_file.dart';

///An app wrapper button that allows to call all original
///Flutter Material [Checkbox] widgets with a scalable size approach.
final class AppCheckboxButton extends Checkbox implements IAppListTileButton {
  const AppCheckboxButton({
    super.key,
    required super.value,
    required super.onChanged,
    super.tristate,
    super.autofocus,
    super.isError,
    super.mouseCursor,
    super.activeColor,
    super.fillColor,
    super.checkColor,
    super.focusColor,
    super.hoverColor,
    super.splashRadius,
    super.materialTapTargetSize,
    super.visualDensity,
    super.focusNode,
    super.shape,
    super.side,

    ///The default scale value that
    ///is used by the app general design.
    this.scale = 1.65,
  });

  ///Modify this value to increase or decrease
  ///the size of the checkbox.
  final double? scale;

  @override
  State<AppCheckboxButton> createState() => _AppCheckboxButtonState();
}

final class _AppCheckboxButtonState extends State<AppCheckboxButton> {
  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: widget.scale,
      child: Checkbox.adaptive(
        value: widget.value,
        onChanged: widget.onChanged,
        tristate: widget.tristate,
        autofocus: widget.autofocus,
        isError: widget.isError,
        mouseCursor: widget.mouseCursor,
        activeColor: widget.activeColor,
        fillColor: widget.fillColor,
        checkColor: widget.checkColor,
        focusColor: widget.focusColor,
        hoverColor: widget.hoverColor,
        splashRadius: widget.splashRadius,
        materialTapTargetSize: widget.materialTapTargetSize,
        visualDensity: widget.visualDensity ?? VisualDensity.compact,
        focusNode: widget.focusNode,
        shape: widget.shape,
        side: widget.side,
      ),
    );
  }
}
