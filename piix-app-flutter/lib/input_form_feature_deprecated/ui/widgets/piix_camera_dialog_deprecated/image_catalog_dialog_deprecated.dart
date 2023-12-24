import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/form_feature/domain/model/form_field_model_deprecated.dart';
import 'package:piix_mobile/form_feature/domain/model/form_model_deprecated.dart';
import 'package:piix_mobile/form_feature/domain/provider/form_provider_deprecated.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/bottom_form_action_bar_deprecated.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/piix_banner_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/utils/extensions/list_extend.dart';
import 'package:piix_mobile/input_form_feature_deprecated/ui/widgets/piix_camera_control_input_deprecated/piix_picture_thumbnail_selection_card_deprecated.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/app_confirm_dialog.dart';
import 'package:piix_mobile/input_form_feature_deprecated/ui/widgets/piix_camera_dialog_deprecated/image_catalog_header_deprecated.dart';
import 'package:piix_mobile/input_form_feature_deprecated/utils/piix_camera_copies.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/piix_banner_content_deprecated.dart';

@Deprecated('Will be removed in 4.0')
class ImageCatalogDialogDeprecated extends ConsumerStatefulWidget {
  const ImageCatalogDialogDeprecated({
    super.key,
    required this.formField,
  });

  final FormFieldModelOld formField;

  @override
  ConsumerState<ImageCatalogDialogDeprecated> createState() =>
      _ImageCatalogDialogState();
}

class _ImageCatalogDialogState
    extends ConsumerState<ImageCatalogDialogDeprecated> {
  int get minimumPhotos => formField.minPhotos;
  late FormNotifier formNotifier;
  late FormFieldModelOld formField;

  @override
  void initState() {
    super.initState();
    formField = widget.formField;
  }

  void onDeleteImage(
    int index,
  ) {
    //Refresh UI of the dialog
    formNotifier.removeCapturedImage(formField, index);

    final bannerInstance = PiixBannerDeprecated.instance;
    const banner = PiixBannerContentDeprecated(
      title: PiixCameraCopiesDeprecated.confirmPhotoDeleted,
      iconData: Icons.check_circle,
      cardBackgroundColor: PiixColors.successMain,
    );
    bannerInstance.builder(
      context,
      children: banner.build(context),
    );
  }

  void onDeleteAllImages() async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AppConfirmDialogDeprecated(
          title: PiixCameraCopiesDeprecated.shouldDeleteAllPhotos,
          message: PiixCameraCopiesDeprecated.youCannotRecoverPhotos,
          cancelText: PiixCopiesDeprecated.cancel.toUpperCase(),
          confirmText: PiixCameraCopiesDeprecated.delete.toUpperCase(),
        );
      },
    );

    if (shouldDelete ?? false) {
      formNotifier.removeAllImages(formField);

      final bannerInstance = PiixBannerDeprecated.instance;
      const banner = PiixBannerContentDeprecated(
        title: PiixCameraCopiesDeprecated.confirmAllPhotosDeleted,
        iconData: Icons.check_circle,
        cardBackgroundColor: PiixColors.successMain,
      );
      bannerInstance.builder(
        context,
        children: banner.build(context),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(formNotifierProvider);
    formNotifier = ref.watch(formNotifierProvider.notifier);
    ref.listen<FormModelOld?>(formNotifierProvider, (_, __) {
      //Each time the formNotifierProvider changes
      //it reassigns the formField with the updated formField
      formField = ref
          .read(formNotifierProvider)!
          .formFieldBy(widget.formField.formFieldId)!;
    });
    final images = formField.capturedImages ?? [];
    final bannerInstance = PiixBannerDeprecated.instance;
    return WillPopScope(
      onWillPop: () async {
        final bannerInstance = PiixBannerDeprecated.instance;
        bannerInstance.removeEntry();
        return true;
      },
      child: Scaffold(
        backgroundColor: PiixColors.white,
        body: Stack(
          children: [
            Container(
              width: context.width,
              height: context.height,
              padding: EdgeInsets.symmetric(
                horizontal: 24.w,
                vertical: 24,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 8.h,
                  ),
                  //Shows the list of photos taken by the user
                  Expanded(
                    child: CustomScrollView(
                      slivers: [
                        ImageCatalogHeaderDeprecated(
                          formField: formField,
                          onDeleteAllImages: onDeleteAllImages,
                        ),
                        SliverToBoxAdapter(
                          child: SizedBox(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 12.h,
                                ),
                                SizedBox(
                                  child: Text(
                                    formField.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge
                                        ?.copyWith(
                                          color: PiixColors.twilightBlue,
                                        ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                SizedBox(
                                  child: Text(
                                    PiixCameraCopiesDeprecated
                                        .picturesYouHaveTaken,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                          color: PiixColors.mainText,
                                          height: 18.sp / 14.sp,
                                          letterSpacing: 0.01,
                                        ),
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) => Column(
                              children: [
                                PiixPictureThumbnailSelectionCardDeprecated(
                                  image: images[index],
                                  index: index,
                                  onDelete: () => onDeleteImage(
                                    index,
                                  ),
                                ),
                                SizedBox(
                                  height: 32.h,
                                ),
                                const Divider(
                                  color: PiixColors.secondaryMain,
                                ),
                              ],
                            ),
                            childCount: images.length,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: BottomFormActionBarDeprecated(
                  hasSecondAction: true,
                  actionOneText: PiixCameraCopiesDeprecated.usePhotos,
                  actionTwoText: PiixCopiesDeprecated.backText.toUpperCase(),
                  onActionOnePressed: images.isNotNullOrEmpty
                      ? () {
                          bannerInstance.removeEntry();
                          Navigator.pop(context);
                        }
                      : null,
                  onActionTwoPressed: () {
                    bannerInstance.removeEntry();
                    Navigator.pop(context);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
