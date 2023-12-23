import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/widgets/tag/tag_barrel_file.dart';

///Declares the tags in the app and provides the basic class
///
///Any subclass of [AppTag] will always build the [child].
abstract base class AppTag extends StatelessWidget {
  const AppTag({super.key, required this.child});

  ///The content of a tag.
  final Widget child;

  @override
  Widget build(BuildContext context) => child;
}

///The class that contains all the factory constructors to
///build Tags for the app.
///
///This class cannot be extended or inherited and must be used
///instead with composition.
final class Tag extends AppTag {
  const Tag({super.key, required super.child});

  ///Builds a [Tag] that contains only an Icon.
  ///
  ///The [Icon] shape to present must be passed as an [IconData] icon value.
  ///
  ///The [Tag] color must be decided by passing a [tagColor] and the label.
  ///
  ///The [Icon] color may also be changed by passing a new [iconColor].
  factory Tag.icon(
    Color tagColor, {
    Key? key,
    required IconData icon,
    Color iconColor = PiixColors.space,
  }) =>
      Tag(
        child: SimpleTagCountour(
          tagColor,
          minWidth: 28.w,
          maxWidth: 288.w,
          child: TagIcon(
            icon: icon,
            color: iconColor,
          ),
        ),
      );

  ///Builds a [Tag] that contains an [Icon] and a [Text] label inside a [Row].
  ///
  ///The order of the [Icon] and [Text] can be reverse by changing
  ///[textDirection] that by default has a value of [TextDirection.ltr] meaning
  ///the [Icon] goes as a suffix of the [Text] label. If the [Icon] should be
  ///positioned as a prefix then the [textDirection] value should change to
  ///[TextDirection.rtl].
  ///
  ///The [Icon] shape to present must be passed as an [IconData] icon value.
  ///
  ///The [String] value of the [Text] label must also be passed.
  ///
  ///The [Tag] color must be decided by passing a [tagColor] and the label.
  ///
  ///The [Text] label color may also be changed by passing a new [textColor].
  factory Tag.label(
    Color tagColor, {
    Key? key,
    required String label,
    required IconData icon,
    Color textColor = PiixColors.space,
    TextDirection textDirection = TextDirection.ltr,
  }) =>
      Tag(
        child: SimpleTagCountour(
          tagColor,
          minWidth: 40.w,
          maxWidth: 288.w,
          child: TagIconAndLabel(
            label: label,
            color: textColor,
            icon: icon,
            textDirection: textDirection,
          ),
        ),
      );

  ///Builds a [Tag] that can be actionable meaning it can execute a callback
  ///[action] when pressed or it can be an inactionable [Tag] that only presents
  ///a label String.
  ///
  ///The [Tag] color must be decided by passing a [tagColor] and the label
  ///
  ///The [Text] label color may also be changed by passing a new [textColor].
  factory Tag.actionable(
    Color tagColor, {
    Key? key,
    required String label,
    VoidCallback? action,
    Color textColor = PiixColors.space,
  }) =>
      Tag(
        child: ActionableTagCountour(
          tagColor,
          action: action,
          minWidth: 40.w,
          maxWidth: 288.w,
          child: TagLabel(
            label: label,
            color: textColor,
          ),
        ),
      );
}
