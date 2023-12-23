import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

//TODO: Analyze and refactor for 4.0
///This widget depends a content type renders a pdf file or render an image;
class RenderFileContainer extends StatelessWidget {
  const RenderFileContainer(
      {Key? key, required this.base64Content, required this.contentType})
      : super(key: key);
  final String contentType;
  final String base64Content;

  @override
  Widget build(BuildContext context) {
    return contentType.contains('pdf')
        ? const PDF().fromPath(base64Content)
        : Image.memory(base64Decode(base64Content),
            width: double.infinity,
            fit: BoxFit.cover, errorBuilder: (context, exception, stackTrace) {
            return Center(
              child: Text(
                exception.toString(),
                textAlign: TextAlign.center,
              ),
            );
          });
  }
}
