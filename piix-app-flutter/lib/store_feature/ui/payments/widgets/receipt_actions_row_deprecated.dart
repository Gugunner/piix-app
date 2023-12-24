import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:piix_mobile/extensions/widget_extend.dart';
import 'package:piix_mobile/navigation_feature/utils/navigator_key_state.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/piix_banner_deprecated.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/piix_banner_content_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/native/native_constants.dart';
import 'package:piix_mobile/native/storage_platform_channel.dart';
import 'package:piix_mobile/store_feature/ui/payments/widgets/payment_line_builder_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/payments/widgets/receipt_instruction_dialog_deprecated.dart';
import 'package:piix_mobile/store_feature/utils/payment_methods.dart';
import 'package:piix_mobile/ui/common/piix_confirm_alert_deprecated.dart';

@Deprecated('Will be removed in 4.0')
enum ReceiptActionsDeprecated {
  download,
  instructions,
}

@Deprecated('Will be removed in 4.0')

///This row contains action for a receipt payment, download capture line
///and instructions dialog
///
class ReceiptActionsRowDeprecated extends StatelessWidget {
  const ReceiptActionsRowDeprecated({
    super.key,
    required this.expirationDate,
    required this.paymentMethodId,
    required this.paymentMethodName,
  });
  final DateTime expirationDate;
  final String paymentMethodId;
  final String paymentMethodName;

  List<ReceiptActionsDeprecated> get actions => [
        ReceiptActionsDeprecated.download,
        ReceiptActionsDeprecated.instructions
      ];
  ReceiptActionsDeprecated get download => ReceiptActionsDeprecated.download;
  ReceiptActionsDeprecated get instructions =>
      ReceiptActionsDeprecated.instructions;

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: actions.map((action) {
          final index = actions.indexOf(action);
          final interGap = index == 0 ? 16 : 0;
          return GestureDetector(
            onTap: toggleOnTap(action, context),
            child: Column(
              children: [
                Icon(
                  action.getIcon,
                  size: 25.h,
                  color: PiixColors.clearBlue,
                ),
                Text(
                  action.getLabel,
                  style: context.accentTextTheme?.headlineLarge?.copyWith(
                    color: PiixColors.active,
                  ),
                ),
              ],
            ).padRight(interGap.w),
          );
        }).toList());
  }

  //This method depending on the action returns the specific onTap function
  Function() toggleOnTap(
      ReceiptActionsDeprecated action, BuildContext context) {
    switch (action) {
      case ReceiptActionsDeprecated.download:
        return () => handleScreenShot(context);
      case ReceiptActionsDeprecated.instructions:
        return () => handleInstructionDialog(context: context);
    }
  }

  //This function open a info plans dialog
  void handleInstructionDialog({
    required BuildContext context,
  }) =>
      showDialog<void>(
        context: context,
        barrierColor: PiixColors.mainText.withOpacity(0.62),
        builder: (context) => ReceiptInstructionDialogDeprecated(
          expirationDate: expirationDate,
          paymentMethodId: paymentMethodId,
          paymentMethodName: paymentMethodName,
        ),
      );

  void handleScreenShot(BuildContext context) async {
    final storagePlatformChanel = StoragePlatformChannel();
    try {
      final permissionStatus = await storagePlatformChanel.storagePermission();
      if (Platform.isIOS) {
        takeScreenShot(context);
        return;
      }
      if (permissionStatus == NativeConstants.permissionDenied) {
        openAlertDialog(context);
        return;
      }
      if (permissionStatus == NativeConstants.permissionGranted) {
        takeScreenShot(context);
        return;
      }
    } catch (e) {
      final bannerInstance = PiixBannerDeprecated.instance;
      const banner = PiixBannerContentDeprecated(
        title: 'Ocurrio un error inesperado',
        subtitle: 'No se pudo guardar la imagen',
        iconData: Icons.error_outline,
        cardBackgroundColor: PiixColors.errorMain,
      );
      bannerInstance.builder(
        context,
        children: banner.build(context),
      );
      return;
    }
  }

  void takeScreenShot(BuildContext context) async {
    final boundary =
        repaintKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    final image = await boundary.toImage();
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    if (byteData != null) {
      final pngBytes = byteData.buffer.asUint8List();
      final result = await ImageGallerySaver.saveImage(
          Uint8List.fromList(pngBytes),
          name: 'piix-payment-capture-line-${DateTime.now()}.png');
      final isSuccess = result['isSuccess'];
      if (isSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(PiixCopiesDeprecated.paymentLineSaved)));
      }
    }
  }

  void openAlertDialog(BuildContext context) {
    final storagePlatformChanel = StoragePlatformChannel();
    showDialog<bool>(
      context: context,
      builder: (_) => PiixConfirmAlertDialogDeprecated(
          title: PiixCopiesDeprecated.permissionRejected,
          titleStyle: context.headlineSmall?.copyWith(
            color: PiixColors.mainText,
            height: 14.sp / 14.sp,
          ),
          message: PiixCopiesDeprecated.openAppSettings,
          onCancel: () => Navigator.pop(context, false),
          onConfirm: () async {
            NavigatorKeyState().getNavigator()?.pop();
            await storagePlatformChanel.openAppSettings();
          }),
    );
  }
}
