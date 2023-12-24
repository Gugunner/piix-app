import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';

@Deprecated('Will be removed in 4.0')

/// A widget to receive rating input from users.
///
/// [RatingBar] can also be used to display rating
class PiixRatingBarDeprecated extends StatelessWidget {
  const PiixRatingBarDeprecated({
    Key? key,
    this.ratingValue,
    this.onRatingUpdate,
    this.itemSize,
  }) : super(key: key);
  final double? ratingValue;
  final Function(double)? onRatingUpdate;
  final double? itemSize;

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: ratingValue ?? 0,
      ignoreGestures: onRatingUpdate == null,
      minRating: 0,
      direction: Axis.horizontal,
      allowHalfRating: true,
      glow: false,
      itemCount: 5,
      itemSize: itemSize ?? 30.h,
      unratedColor: PiixColors.ratingGrey,
      itemPadding: const EdgeInsets.symmetric(horizontal: 0.0),
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: PiixColors.ratingYellow,
      ),
      onRatingUpdate: onRatingUpdate ?? (rating) {},
    );
  }
}
