import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/claim_ticket_feature/utils/claim_ticket_utils.dart';
import 'package:piix_mobile/general_app_feature/domain/bloc/ui_bloc.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_assets.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/ui/tickets_deprecated/widgets_deprecated/claim_ticket_button_deprecated.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

/// Creates a [Dialog] widget that shows the alternatives to contact the benefit supplier.
class ClaimDialogDeprecated extends StatelessWidget {
  const ClaimDialogDeprecated({
    Key? key,
    this.image,
    this.name = '',
    required this.isBenefit,
    required this.fromHistory,
  }) : super(key: key);
  final String? image;
  final String name;
  final bool isBenefit;
  final bool fromHistory;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final uiBLoC = context.watch<UiBLoC>();
    return Dialog(
      child: uiBLoC.isLoading
          ? SizedBox(
              height: kMinInteractiveDimension * 4,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  SizedBox(height: 8.h),
                  Text(uiBLoC.loadText),
                ],
              ),
            )
          : SizedBox(
              width: size.width * .85,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 100.h,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        if (image != null)
                          Image.memory(
                            base64Decode(image!),
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, exception, stackTrace) {
                              return Image.asset(PiixAssets.placeholderBen);
                            },
                          )
                        else
                          Image.asset(
                            PiixAssets.placeholderBen,
                          ),
                        Container(
                          color: PiixColors.clearBlue.withOpacity(.7),
                        ),
                        Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                            ),
                            child: Text(
                              getNameOfTicket(benefitName: name),
                              style: context.textTheme?.displaySmall?.copyWith(
                                color: PiixColors.space,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 12.w,
                          right: 12.w,
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: const Icon(
                              Icons.clear,
                              color: PiixColors.errorText,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 8.h,
                        ),
                        Text(
                          PiixCopiesDeprecated.goingToStartRequestProcess,
                          textAlign: TextAlign.center,
                          style: context.primaryTextTheme?.titleSmall?.copyWith(
                            color: PiixColors.primary,
                          ),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Icon(
                          Icons.check_circle_outline,
                          color: PiixColors.successMain,
                          size: 25.w,
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Text(
                          '${PiixCopiesDeprecated.contactSupplier}:',
                          style: context.primaryTextTheme?.titleSmall,
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        ClaimTicketButtonDeprecated(
                          fromHistory: fromHistory,
                          isBenefit: isBenefit,
                        ),
                        ClaimTicketButtonDeprecated(
                          fromHistory: fromHistory,
                          isBenefit: isBenefit,
                          isPhoneClaim: false,
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: Theme.of(context).elevatedButtonTheme.style,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: context.width * 0.023,
                            ),
                            child: Text(
                              PiixCopiesDeprecated.cancelButton,
                              style: context.primaryTextTheme?.titleMedium
                                  ?.copyWith(
                                color: PiixColors.space,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
