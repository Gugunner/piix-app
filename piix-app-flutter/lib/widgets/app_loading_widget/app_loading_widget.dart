import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/utils/extensions/string_extend.dart';
import 'package:piix_mobile/utils/log_utils.dart';
import 'package:piix_mobile/widgets/app_bar/logo_app_bar.dart';
import 'package:piix_mobile/widgets/loader/app_circular_loader.dart';
import 'package:piix_mobile/widgets/screen/app_screen/pop_app_screen.dart';

abstract class AppLoadingWidget extends ConsumerStatefulWidget {
  const AppLoadingWidget({
    super.key,
    this.message,
    this.imagePath,
  });

  ///Message to show while loading
  final String? message;

  ///Image name in the assets folder
  final String? imagePath;
}

///Base class that has an explicit animation for the opacity of the image
abstract class AppLoadingWidgetState<T extends AppLoadingWidget>
    extends ConsumerState<T> with LogAnalytics {
  bool isRequesting = true;

  bool isSubmitting = false;

  bool requestError = false;

  bool submitError = false;

  ///Executes an Asynchrounous operation that can be run with
  ///a ref.watch(provider).whenOrNull()
  ///``` @override
  ///
  ///Widget build(BuildContext context) {
  ///
  ///if (isRequesting) whileIsRequesting();
  ///
  ///return Container()
  ///
  ///} ```
  Future<void> whileIsRequesting() => throw UnimplementedError();

  ///Executes an Asynchrounous operation that can be run with
  ///a ref.watch(provider).whenOrNull()
  ///``` @override
  ///
  ///Widget build(BuildContext context) {
  ///
  ///if (isRequesting) whileIsRequesting();
  ///
  ///return Container()
  ///
  ///} ```
  Future<void> whileIsSubmitting() => throw UnimplementedError();

  ///Sets [isRequesting] to false.
  void endRequest() {
    Future.microtask(() => setState(() {
          isRequesting = false;
        }));
  }

  ///Sets [isRequesting] to true.
  void startRequest() {
    Future.microtask(() => setState(() {
          isRequesting = true;
        }));
  }

  ///Sets [isSubmitting] to false.
  void endSubmit() {
    Future.microtask(() => setState(() {
          isSubmitting = false;
        }));
  }

  ///Sets [isSubmitting] to true.
  void startSubmit() {
    Future.microtask(() => setState(() {
          isSubmitting = true;
        }));
  }

  @override
  Widget build(BuildContext context) {
    if (isRequesting) whileIsRequesting();
    return PopAppScreen(
      onWillPop: () async => false,
      appBar: LogoAppBar(
        leading: const SizedBox(),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 24.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 70.h,
              ),
              if (widget.imagePath.isNotNullEmpty)
                Image.asset(
                  widget.imagePath!,
                  width: 224.w,
                  height: 112.h,
                  fit: BoxFit.cover,
                  errorBuilder: ((context, error, stackTrace) =>
                      const Placeholder()),
                ),
              SizedBox(
                height: 20.h,
              ),
              if (widget.message.isNotNullEmpty)
                Text(
                  widget.message!,
                  style: context.headlineSmall?.copyWith(
                    color: PiixColors.infoDefault,
                  ),
                  textAlign: TextAlign.center,
                ),
              SizedBox(
                height: 20.h,
              ),
              const AppCircularLoader()
            ],
          ),
        ),
      ),
    );
  }
}
