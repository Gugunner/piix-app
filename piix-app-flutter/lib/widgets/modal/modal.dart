import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/navigation_feature/utils/navigator_key_state.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';
import 'package:piix_mobile/widgets/banner/banner_barrel_file.dart';
import 'package:piix_mobile/widgets/button/app_button_barrel_file.dart';
import 'package:piix_mobile/widgets/loader/app_circular_loader.dart';

///The preconstructed [Widget] for an alert [Dialog].
///
///The [Modal] must always include a [title] and a [child],
///and may include an additional [child] element below the [child].
///
///It always shows a accept button and may also show an cancel button
///if the [onCancel] property is not null. When [onAccept] is null, the
///accept button by default only exits the [Modal].
///
///If [loading] is set to true it shows a [AppCircularLoader] to indicate
///a loading action was confirmed.
abstract class Modal extends StatelessWidget {
  const Modal({
    super.key,
    required this.title,
    this.loading = false,
    this.onAccept,
    this.onAcceptText,
    this.onCancel,
    this.onCancelText,
    this.child,
    this.childGap,
    this.actionGap,
  });

  ///The header of the [Modal]
  final Widget title;

  ///The message of the [Modal]
  final Widget? child;

  ///A flag to indicate whether the
  ///[Modal] shows a loading indicator
  ///or the content.
  final bool loading;

  ///The callback of when the user clicks
  ///the accept button, if null the [Modal]
  ///by default closes with this button.
  final VoidCallback? onAccept;

  ///A custom accept text for the accept button.
  final String? onAcceptText;

  ///The callback of when the user clicks
  ///the cancel button, if null then the [Modal]
  ///does not show the button.
  final VoidCallback? onCancel;

  ///A custom cancel text for the cancel button.
  final String? onCancelText;

  ///The margin between the [title] and the [child].
  final double? childGap;

  ///The margin between the [child] if not null
  ///and the [onAccept].
  final double? actionGap;

  ///The width of any [Modal].
  double get _width => 272.w;

  ///The heigh of the [Modal] when a loader
  ///appears.
  double get _loaderHeight => 184.h;

  ///The padding surrounding the properties of this.
  EdgeInsets get _padding => EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 16.h);

  ///The space between the elements of the modal vertically.
  double get _space => 8.h;

  ///The duration for the fading in animation when a loading indicator appears.
  Duration get _duration => const Duration(milliseconds: 500);

  ///Handles the correct alignment for one or two buttons inside
  ///this.
  MainAxisAlignment get _alignment {
    if (onCancel != null) return MainAxisAlignment.spaceBetween;
    return MainAxisAlignment.center;
  }

  ///Returns the AppLocalization cancel text if no custom
  ///[onAcceptText] is passed.
  String _getAcceptText(BuildContext context) =>
      onAcceptText ?? context.localeMessage.accept;

  ///Returns the AppLocalization cancel text if no custom
  ///[onCancelText] is passed.
  String _getCancelText(BuildContext context) =>
      onCancelText ?? context.localeMessage.cancel;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              // constraints: BoxConstraints(maxHeight: _maxHeight),
              padding: _padding,
              width: _width,
              child: AnimatedSwitcher(
                duration: _duration,
                child: Builder(builder: (context) {
                  //If it is loading a progress indicator appears.
                  if (loading)
                    return SizedBox(
                      height: _loaderHeight,
                      child: const Center(
                        child: AppCircularLoader(),
                      ),
                    );

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //To avoid overlapping the floating [X] button of the
                      //Modal a greater topo margin is required.
                      SizedBox(height: _space * 3),
                      ...[
                        SizedBox(child: title),
                        SizedBox(height: childGap ?? _space),
                        //The child renders before any
                        //buttons.
                        if (child != null) ...[
                          child!,
                          SizedBox(height: actionGap ?? _space),
                        ],
                        SizedBox(
                          width: _width,
                          child: Row(
                            mainAxisAlignment: _alignment,
                            children: [
                              //If a cancel callback is used a second
                              //button appears.
                              if (onCancel != null)
                                AppTextSizedButton(
                                  text: _getCancelText(context).toUpperCase(),
                                  onPressed: () {
                                    onCancel!.call();
                                  },
                                ),
                              AppFilledSizedButton.small(
                                text: _getAcceptText(context).toUpperCase(),
                                //Disables the button when the Modal is showing a
                                //loading indicator.
                                onPressed: loading
                                    ? null
                                    : () {
                                        //If onAccept is not null the
                                        //callback must control navigation.
                                        if (onAccept != null)
                                          return onAccept!.call();
                                        return NavigatorKeyState()
                                            .getNavigator(context)
                                            ?.pop(true);
                                      },
                              ),
                            ],
                          ),
                        )
                      ],
                    ],
                  );
                }),
              ),
            ),
          ),
          Positioned(
            top: 12.h,
            right: 16.w,
            child: CloseXButton(
              () {
                //It can only closa and pop the Modal if no loading
                //is currently executing.
                if (!loading) NavigatorKeyState().getNavigator()?.pop(false);
              },
              color: PiixColors.error,
            ),
          ),
        ],
      ),
    );
  }
}
