import 'dart:io';
import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

mixin FileManager {
  ///Retrieves the current local directory and returns the path where files
  ///can be temporarily written to and read from.
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }
  
  
  ///Writes a new temporary file with the [imageData]
  ///and returns a new [XFile] with the temporal
  ///path and [imageData].
  Future<XFile> getImageXFile(Uint8List imageData) async {
    final path = await _localPath;
    final randomValue = Random().nextInt(1000000);
    final file = File('$path/$randomValue.jpg');
    await file.writeAsBytes(imageData);
    final xfile = XFile(
      file.path,
      bytes: imageData,
      mimeType: 'image/jpg',
    );
    return xfile;
  }
}
