import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:piix_mobile/general_app_feature/domain/bloc/ui_bloc.dart';
import 'package:piix_mobile/file_feature/domain/model/file_content_model.dart';
import 'package:piix_mobile/ui/common/clamping_scale_deprecated.dart';
import 'package:piix_mobile/ui/common/piix_full_loader_deprecated.dart';
import 'package:piix_mobile/ui/common/render_file_container.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/ui/widgets/membership/piix_app_bar_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:provider/provider.dart';

//TODO: Analyze and refactor for 4.0
/// This screen renders file using a base64 string, using the RenderFileContainer.
class PDFDetailScreen extends StatefulWidget {
  const PDFDetailScreen({Key? key}) : super(key: key);
  static const routeName = '/pdf';

  @override
  State<PDFDetailScreen> createState() => _PDFDetailScreenState();
}

class _PDFDetailScreenState extends State<PDFDetailScreen> {
  bool _isLoading = true;
  late String? _base64Content;
  late String? _contentType;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final fileField =
          ModalRoute.of(context)?.settings.arguments as FileContentModel?;
      context.read<UiBLoC>().loadText = PiixCopiesDeprecated.renderingPDF;
      await _loadDocument(
        base64Content: fileField?.base64Content ?? '',
        contentType: fileField?.contentType ?? '',
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClampingScaleDeprecated(
      child: Scaffold(
        appBar:
            const PiixAppBarDeprecated(title: PiixCopiesDeprecated.PdfTitle),
        body: _isLoading
            ? const PiixFullLoaderDeprecated()
            : RenderFileContainer(
                base64Content: _base64Content ?? '',
                contentType: _contentType ?? '',
              ),
      ),
    );
  }

  Future<void> _loadDocument(
      {required String base64Content, required String contentType}) async {
    if (contentType.contains('pdf')) {
      final encodedStr = base64Content;
      final bytes = base64Decode(encodedStr);
      final dir = (await getApplicationDocumentsDirectory()).path;
      final file = File(
        '$dir/${DateTime.now().millisecondsSinceEpoch}.pdf',
      );
      await file.writeAsBytes(bytes);
      setState(() {
        _base64Content = file.path;
      });
    } else {
      setState(() {
        _base64Content = base64Content;
      });
    }
    setState(() {
      _contentType = contentType;
      _isLoading = false;
    });
  }
}
