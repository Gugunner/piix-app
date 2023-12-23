import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/navigation_feature/utils/navigator_key_state.dart';
import 'package:piix_mobile/widgets/button/app_button_barrel_file.dart';
import 'package:piix_mobile/widgets/modal/modal_barrel_file.dart';
import 'package:piix_mobile/form_feature/ui/widgets/text_form_field/text_form_field_barrel_file.dart';

final class AppModalScreen extends StatefulWidget {
  static const routeName = '/app_modal_screen';

  const AppModalScreen({super.key});

  @override
  State<AppModalScreen> createState() => _AppModalScreenState();
}

class _AppModalScreenState extends State<AppModalScreen> {
  bool loading = false;
  Timer? timer;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
          child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20.h),
            AppFilledSizedButton(
              text: 'App Modal One Button',
              onPressed: () async {
                final value = await showDialog(
                    context: context,
                    builder: (context) {
                      return const AppModal(
                          title: AppModalTitle(
                              'Lorem ipsum dolor sit amet, consectetur '
                              'adipiscing elit, sed do eiusmod tempor'),
                          child: AppModalDescription(
                              'Lorem ipsum dolor sit amet, '
                              'consectetur adipiscing elit, sed do eiusmod tempor '
                              'incididunt ut labore et dolore magna aliqua. Tortor '
                              'posuere ac ut consequat semper viverra nam libero justo.'
                              ' Tellus at urna condimentum mattis pellentesque id nibh.'
                              ' Malesuada bibendum arcu vitae elementum curabitur vitae'
                              ' nunc sed. Aliquam nulla facilisi cras fermentum odio.'));
                    });
                return value;
              },
            ),
            SizedBox(
              height: 8.h,
            ),
            AppFilledSizedButton(
              text: 'App Modal Two Buttons',
              onPressed: () async {
                final value = await showDialog(
                    context: context,
                    builder: (context) {
                      return AppModal(
                        title: const AppModalTitle(
                            'Lorem ipsum dolor sit amet, consectetur '
                            'adipiscing elit, sed do eiusmod tempor'),
                        child: const AppModalDescription(
                            'Lorem ipsum dolor sit amet, '
                            'consectetur adipiscing elit, sed do eiusmod tempor '
                            'incididunt ut labore et dolore magna aliqua. Tortor '
                            'posuere ac ut consequat semper viverra nam libero justo.'
                            ' Tellus at urna condimentum mattis pellentesque id nibh.'
                            ' Malesuada bibendum arcu vitae elementum curabitur vitae'
                            ' nunc sed. Aliquam nulla facilisi cras fermentum odio.'),
                        onCancel: () {
                          debugPrint('Cancel');
                        },
                      );
                    });
                return value;
              },
            ),
            SizedBox(
              height: 8.h,
            ),
            AppFilledSizedButton(
              text: 'App Modal Loading',
              onPressed: () async {
                final value = await showDialog(
                    context: context,
                    barrierDismissible: !loading,
                    builder: (context) {
                      return StatefulBuilder(
                        builder: (context, setDialogState) => AppModal(
                          title: const AppModalTitle(
                              'Lorem ipsum dolor sit amet, consectetur '
                              'adipiscing elit, sed do eiusmod tempor'),
                          child: Form(
                            key: _formKey,
                            child: const Column(
                              children: [
                                AppModalDescription(
                                    'Lorem ipsum dolor sit amet, '
                                    'consectetur adipiscing elit, sed do eiusmod tempor '
                                    'incididunt ut labore et dolore magna aliqua. Tortor '
                                    'posuere ac ut consequat semper viverra nam libero justo.'
                                    ' Tellus at urna condimentum mattis pellentesque id nibh.'
                                    ' Malesuada bibendum arcu vitae elementum curabitur vitae'
                                    ' nunc sed. Aliquam nulla facilisi cras fermentum odio.'),
                                EmailFormField(
                                  handleFocusNode: true,
                                ),
                              ],
                            ),
                          ),
                          onAccept: () {
                            if (_formKey.currentState == null) return;
                            _formKey.currentState!.save();
                            if (!_formKey.currentState!.validate()) return;
                            setDialogState(() {
                              loading = true;
                            });
                            if (loading) {
                              Timer.periodic(const Duration(seconds: 4),
                                  (timer) {
                                timer.cancel();
                                NavigatorKeyState().getNavigator()?.pop(true);
                              });
                            }
                          },
                          loading: loading,
                          onCancel: () {
                            debugPrint('Cancel');
                          },
                        ),
                      );
                    });

                Future.microtask(() => setState(() {
                      loading = false;
                    }));

                return value;
              },
            ),
          ],
        ),
      )),
    );
  }
}
