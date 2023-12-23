import 'package:flutter/material.dart';
import 'package:piix_mobile/form_feature/domain/model/form_field_model_deprecated.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/close_dialog_icon_button_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/utils/extensions/list_extend.dart';
import 'package:piix_mobile/input_form_feature_deprecated/utils/piix_camera_copies.dart';
import 'package:piix_mobile/widgets/button/text_app_button/text_app_button_deprecated.dart';

@Deprecated('Will be removed in 4.0')
class ImageCatalogHeaderDeprecated extends StatelessWidget {
  const ImageCatalogHeaderDeprecated({
    super.key,
    required this.formField,
    this.onDeleteAllImages,
  });

  final FormFieldModelOld formField;
  final VoidCallback? onDeleteAllImages;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      toolbarHeight: 0,
      expandedHeight: kToolbarHeight,
      collapsedHeight: kToolbarHeight,
      floating: true,
      pinned: true,
      backgroundColor: PiixColors.white,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.zero,
        expandedTitleScale: 1.0,
        collapseMode: CollapseMode.parallax,
        title: SizedBox(
          height: context.height * 0.077,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (formField.capturedImages.isNotNullOrEmpty)
                TextAppButtonDeprecated(
                  text: PiixCameraCopiesDeprecated.deleteAll,
                  onPressed: onDeleteAllImages,
                  buttonStyle: ButtonStyle(
                    textStyle: MaterialStatePropertyAll<TextStyle>(
                      context.primaryTextTheme?.titleMedium
                              ?.copyWith(color: PiixColors.error) ??
                          const TextStyle(),
                    ),
                  ),
                )
              else
                const Expanded(
                  child: SizedBox(),
                ),
              const CloseDialogIconButtonDeprecated(),
            ],
          ),
        ),
      ),
    );
  }
}
