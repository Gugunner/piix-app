import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';
import 'package:piix_mobile/widgets/button/app_button_barrel_file.dart';
import 'package:piix_mobile/form_feature/ui/widgets/text_form_field/text_form_field_barrel_file.dart';

final class AppTextFieldScreen extends StatefulWidget {
  static const routeName = '/app_text_field_screen';

  const AppTextFieldScreen({super.key});

  @override
  State<AppTextFieldScreen> createState() => _AppTextFieldScreenState();
}

class _AppTextFieldScreenState extends State<AppTextFieldScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20.h),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // const AppOnActionPasswordField(
                        //   useInternalFocusNode: true,
                        // ),
                        SizedBox(height: 16.h),
                        const Text('Example of Number Input'),
                        const NumberFormField(),
                        SizedBox(height: 8.h),
                        const NumberFormField(
                          showLimits: true,
                          minValue: 50,
                          maxValue: 4500,
                        ),
                        SizedBox(height: 8.h),
                        const NumberFormField(
                          showLimits: true,
                          numberType: NumberType.DECIMAL_CURRENCY,
                        ),
                        SizedBox(height: 8.h),
                        const NumberFormField(
                          numberType: NumberType.DECIMAL_PERCENTAGE,
                        ),
                        SizedBox(height: 8.h),
                        const NumberFormField(
                          numberType: NumberType.WHOLE_PERCENTAGE,
                          showLimits: true,
                          minValue: 0,
                          maxValue: 100,
                        ),
                        SizedBox(height: 8.h),
                        AppFilledSizedButton(
                            text: 'Enviar',
                            onPressed: () {
                              if (_formKey.currentState == null) return;
                              _formKey.currentState!.save();
                              if (!_formKey.currentState!.validate()) return;
                            }),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
