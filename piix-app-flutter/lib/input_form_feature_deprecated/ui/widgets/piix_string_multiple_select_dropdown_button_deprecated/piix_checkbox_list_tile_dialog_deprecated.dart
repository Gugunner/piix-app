import 'package:flutter/material.dart';
import 'package:piix_mobile/form_feature/domain/model/form_field_model_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';

@Deprecated('No longer in use in 4.0')

///The widget can only be used inside of a [PiixStringMultipleSelectDropdownButton] as
///it is a list view of [CheckboxListTile], that checks when an option is tapped or unchecks it
///if the option is tapped again.
///
///The widget creates a dialog that cover the entire screen minus the [SafeAre] and
///also renders a Card where the [ListView] is presented.
///
///It also adds a simple animation to grow the [AnimatedContainer] vertically by
///initializing a height value and then changing it after the widget has finished
///building.
class PiixCheckBoxLisTileDialogDeprecated extends StatefulWidget {
  const PiixCheckBoxLisTileDialogDeprecated({
    super.key,
    required this.formField,
    required this.onChecked,
    required this.stringValues,
    this.left = 0,
    this.top = 0,
    this.entryHeight,
    this.renderBoxHeight,
    this.onCleanEntry,
  });

  ///The values to be presented as options
  final List<String> stringValues;

  ///A data model that contains all the information to render the [Dialog]
  final FormFieldModelOld formField;

  ///The method needed to handle when a tile is tapped
  final Function(String) onChecked;

  ///The position from the left for the [Card] which will not change
  final double left;

  ///The position from the top for the [Card] which will not change
  final double top;

  ///The height the [AnimatedContainer] needs to grow to
  final double? entryHeight;

  ///The height of the widget that renders this dialog
  final double? renderBoxHeight;

  ///The method needed to remove the [Dialog]
  final VoidCallback? onCleanEntry;

  @override
  State<PiixCheckBoxLisTileDialogDeprecated> createState() =>
      _PiixCheckBoxLisTileDialogDeprecatedState();
}

class _PiixCheckBoxLisTileDialogDeprecatedState
    extends State<PiixCheckBoxLisTileDialogDeprecated> {
  double? height;
  //A simple string list of the [stringResponse] split by ','.
  List<String>? get formFieldStringResponses =>
      widget.formField.stringResponse?.split(',');

  @override
  void initState() {
    height = widget.renderBoxHeight;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //Once the widget builds with the initial height it rebuilds
      //with the new height
      height = widget.entryHeight;
      setState(() {});
    });
    super.initState();
  }

  bool get enabled =>
      ((formFieldStringResponses ?? []).length < widget.formField.maxOptions);

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (dialogBuildContext, setDialogState) {
        return Dialog(
          alignment: Alignment.center,
          insetPadding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          child: Stack(
            children: [
              GestureDetector(
                onTap: () {
                  widget.onCleanEntry?.call();
                },
                child: Container(
                  height: context.height,
                  width: context.width,
                  // padding: EdgeInsets.all(50),
                  color: Colors.transparent,
                ),
              ),
              Positioned(
                top: widget.top,
                left: widget.left,
                child: AnimatedContainer(
                  height: height ?? context.height * 0.55,
                  width: context.width * 0.95,
                  duration: const Duration(milliseconds: 80),
                  curve: Curves.easeIn,
                  child: Card(
                    elevation: 4,
                    shadowColor: Colors.black,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(0),
                      ),
                    ),
                    margin: EdgeInsets.zero,
                    color: PiixColors.white,
                    child: ListView.builder(
                      itemBuilder: (dialogBuildContext, index) {
                        final value = widget.stringValues[index];
                        final idx = formFieldStringResponses?.indexWhere(
                                (stringResponse) => value == stringResponse) ??
                            -1;
                        return Center(
                          child: CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            title: Text(
                              value,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                    color: PiixColors.black,
                                  ),
                            ),
                            enabled: enabled || idx > -1,
                            value: idx > -1,
                            onChanged: (_) {
                              widget.onChecked(value);
                              setDialogState(() {});
                            },
                            activeColor: PiixColors.azure,
                            checkColor: PiixColors.white,
                          ),
                        );
                      },
                      itemCount: widget.stringValues.length,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
