import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

@Deprecated('Will be removed in 4.0')

///This list shows a list of claim cards for shimmer effect
///
class ShimmerClaimTicketCardsDeprecated extends StatelessWidget {
  const ShimmerClaimTicketCardsDeprecated({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        4,
        (index) => Card(
          child: SizedBox(
            height: 110.h,
            width: context.width,
          ),
        ),
      ),
    );
  }
}
