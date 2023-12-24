import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

/// Creates a card with a subtitle text.
class SubtitleCard extends StatelessWidget {
  const SubtitleCard({Key? key, required this.subtitle}) : super(key: key);

  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h),
      padding: EdgeInsets.only(left: width * .07),
      alignment: Alignment.centerLeft,
      width: double.infinity,
      child: Text(
        subtitle,
        style: context.primaryTextTheme?.titleSmall,
      ),
    );
  }
}
