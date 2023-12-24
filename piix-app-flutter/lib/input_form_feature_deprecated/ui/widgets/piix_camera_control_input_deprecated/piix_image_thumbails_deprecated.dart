import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/form_feature/domain/provider/form_provider_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

@Deprecated('Will be removed in 4.0')
//TODO: Add documentation
class PiixImageThumbnailsDeprecated extends ConsumerWidget {
  const PiixImageThumbnailsDeprecated({
    Key? key,
    required this.images,
  }) : super(key: key);

  //TODO: Explain property
  final List<XFile> images;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(formNotifierProvider);
    return Stack(
      children: images.asMap().entries.toList().map((entry) {
        final index = entry.key;
        final file = entry.value;
        return Positioned(
          top: index.toDouble(),
          left: index.toDouble(),
          child: TweenAnimationBuilder<Size?>(
            duration: const Duration(milliseconds: 200),
            tween: SizeTween(
              begin: Size(context.width, 0),
              end: Size(
                60.h,
                60.h,
              ),
            ),
            builder: (context, value, _) {
              return SizedBox(
                width: value!.width,
                height: value.height,
                child: Image.file(
                  File(file.path),
                  errorBuilder: (context, obj, error) {
                    //Safe guard if image can't be loaded
                    return const Placeholder();
                  },
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
        );
      }).toList(),
    );
  }
}
