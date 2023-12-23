import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';

///This tab row shows coverage and addition tabs in single membership screen.
class TabRow extends StatelessWidget {
  const TabRow({Key? key, required this.isAdditions, required this.toggleTab})
      : super(key: key);
  final bool isAdditions;
  final Function toggleTab;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: PiixColors.white, boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 4,
          offset: const Offset(0, 3), // changes position of shadow
        ),
      ]),
      child: Row(
        children: [
          Expanded(
              child: SizedBox(
            child: InkWell(
              onTap: () {
                toggleTab();
              },
              splashColor: PiixColors.clearBlue.withOpacity(0.1),
              highlightColor: Colors.transparent,
              child: Container(
                padding:
                    EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(8)),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: isAdditions
                                ? Colors.transparent
                                : PiixColors.clearBlue,
                            width: 2))),
                child: Center(
                  child: Text(PiixCopiesDeprecated.myCoverage.toUpperCase()),
                ),
              ),
            ),
          )),
          Expanded(
              child: SizedBox(
            child: InkWell(
              onTap: () {
                toggleTab();
              },
              splashColor: PiixColors.clearBlue.withOpacity(0.1),
              highlightColor: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: !isAdditions
                                ? Colors.transparent
                                : PiixColors.clearBlue,
                            width: 2))),
                child: Center(
                  child: Text(PiixCopiesDeprecated.myAdditions.toUpperCase()),
                ),
              ),
            ),
          )),
        ],
      ),
    );
  }
}
