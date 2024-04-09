import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:piix_mobile/src/constants/app_sizes.dart';
import 'package:piix_mobile/src/features/authentication/presentation/web/welcome_to_piix_one_time_code_login.dart';
import 'package:piix_mobile/src/theme/theme_barrel_file.dart';

/// A layout that displays two columns when the user is running the app
/// in the web in biggher screens.
class TwoColumnSignIn extends StatelessWidget {
  const TwoColumnSignIn({super.key});

  final padding = Sizes.p64;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: padding, top: padding, bottom: padding),
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Sizes.p16),
                  bottomLeft: Radius.circular(Sizes.p16),
                ),
                color: PiixColors.space,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: Sizes.p16),
                child: WelcomeToPiixOneTimeCodeLogin(
                  width: MediaQuery.of(context).size.width * 0.25,
                  parentPadding: padding,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
                decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/4x/family_image_x4.jpeg'),
                fit: BoxFit.cover,
              ),
            )),
          ),
        ],
      ),
    );
  }
}

