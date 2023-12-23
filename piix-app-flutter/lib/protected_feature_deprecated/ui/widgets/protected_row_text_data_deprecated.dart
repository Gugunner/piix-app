import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/extensions/widget_extend.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/protected_feature_deprecated/ui/widgets/protected_value_data_cell_deprecated.dart';

@Deprecated('Will be removed in 4.0')

/// Creates a [Column] of [Row]s with formatted text and aligned with space
/// between them.
class ProtectedRowTextDataDeprecated extends StatelessWidget {
  const ProtectedRowTextDataDeprecated({
    Key? key,
    required this.data,
  }) : super(key: key);

  final Map<String, String> data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: data.entries.map((val) {
        final key = val.key;
        final value = val.value;
        final isMaxLenght = value.length > 25;
        final ellipsisValue =
            isMaxLenght ? '${value.substring(0, 22)}...' : value;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              key,
              style: context.primaryTextTheme?.titleSmall,
              textAlign: TextAlign.start,
            ),
            if (isMaxLenght)
              Tooltip(
                verticalOffset: 12,
                message: value,
                child: ProtectedValueDataCellDeprecated(
                  label: ellipsisValue,
                ),
              )
            else
              ProtectedValueDataCellDeprecated(
                label: value,
              )
          ],
        ).padBottom(
          4.h,
        );
      }).toList(),
    ).padOnly(
      top: 4.h,
      bottom: 16.h,
    );
  }
}
