import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:piix_mobile/auth_feature/domain/provider/user_provider.dart';
import 'package:piix_mobile/file_feature/data/repository/file_repository_deprecated.dart';
import 'package:piix_mobile/file_feature/domain/model/file_model.dart';
import 'package:piix_mobile/file_feature/domain/model/request_file_model.dart';
import 'package:piix_mobile/file_feature/domain/model/s3_file_model.dart';
import 'package:piix_mobile/utils/log_utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'file_provider_deprecated.g.dart';

@Deprecated('Will be removed in 4.0')
///A Riverpod Notifier class that handles any request to send or retrieve
///S3 files.
@riverpod
class S3FileNotifier extends _$S3FileNotifier with LogAppCall, LogApiCall {
  @override
  void build() => {};

  @Deprecated('Will be removed in 4.0')
  ///Requests a file by creating a [RequestFileModel] with
  ///the [path] and [propertyName] of the file for the
  ///current [userId]
  Future<FileModel> getFile({
    required String path,
    required String propertyName,
  }) {
    final userId = ref.read(userPodProvider)?.userId;
    final repository = ref.read(s3FileRepositoryProvider.notifier);
    try {
      final requestModel = RequestFileModel(
        userId: userId ?? '',
        filePath: path,
        propertyName: propertyName,
      );
      return repository.getFile(requestModel);
    } catch (error) {
      if (error is! DioError) {
        logError(error, className: 'S3FileNotifier');
        rethrow;
      }
      logDioException(error, className: 'S3FileNotifier');
      rethrow;
    }
  }

  @Deprecated('Will be removed in 4.0')
  ///Uploads a file wrapped inside a [S3FileModel] that contains
  ///the [data], the [path] where the file will be stored and
  ///the [contentType]
  Future<void> sendFile({
    required String path,
    required String contentType,
    required String data,
  }) async {
    final userId = ref.read(userPodProvider)?.userId;
    final repository = ref.read(s3FileRepositoryProvider.notifier);
    try {
      final fileModel = S3FileModel(
        fileFullRoute: path,
        fileContentType: contentType,
        fileObjectData: data,
        userId: userId ?? '',
      );
      await repository.sendFile(fileModel);
    } catch (error) {
      if (error is! DioError) {
        logError(error, className: 'S3FileNotifier');
        rethrow;
      }
      logDioException(error, className: 'S3FileNotifier');
      rethrow;
    }
  }
}

@Deprecated('Will be removed in 4.0')
///A Riverpod Notifier class that handles local file manipulation
@riverpod
class LocalFileNotifier extends _$LocalFileNotifier with LogAppCall {
  @override
  void build() => {};

  @Deprecated('Will be removed in 4.0')
  ///Writes to a [file] and returns the [File] instance with the
  ///path where it was written.
  FutureOr<File> writeAsString(
    File file, {
    required String contents,
    FileMode mode = FileMode.write,
    Encoding encoding = utf8,
    bool flush = false,
  }) async {
    try {
      return file.writeAsString(contents,
          mode: mode, encoding: encoding, flush: false);
    } catch (error) {
      logError(error, className: 'LocalFileNotifier');
      return file;
    }
  }

  @Deprecated('Will be removed in 4.0')
  ///Deletes a [file]
  Future<void> delete(File file) async {
    try {
      file.delete();
    } catch (error) {
      logError(error, className: 'LocalFileNotifier');
    }
  }
}
