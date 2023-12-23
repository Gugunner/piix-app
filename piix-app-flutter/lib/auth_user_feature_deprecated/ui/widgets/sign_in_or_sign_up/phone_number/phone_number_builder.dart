import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/ui/widgets/auth_input_widget.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/ui/widgets/sign_in_or_sign_up/phone_number/lada_widget.dart';

///Builds a phone number with a lada selector and a number input
class PhoneNumberBuilder extends StatelessWidget {
  const PhoneNumberBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Flexible(
            flex: 1,
            child: LadaWidget(),
          ),
          SizedBox(
            width: 8.w,
          ),
          const Flexible(
            flex: 3,
            child: AuthInputWidget(
              textInputType: TextInputType.phone,
            ),
          ),
        ],
      ),
    );
  }
}
