import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:piix_mobile/app_config.dart';
import 'package:piix_mobile/env/dev.env.dart';
import 'package:piix_mobile/general_app_feature/api/piix_api_deprecated.dart';
import 'package:piix_mobile/general_app_feature/data/repository/file_system_repository_deprecated.dart';
import 'package:piix_mobile/general_app_feature/data/repository/file_system_repository_app_use_test_deprecated.dart';
import 'package:piix_mobile/general_app_feature/di/service_locator.dart';
import 'package:piix_mobile/general_app_feature/domain/bloc/file_system_bloc.dart';
import 'package:piix_mobile/file_feature/domain/model/request_file_model.dart';
import 'package:piix_mobile/file_feature/domain/model/s3_file_model.dart';

import '../api/mock_dio.mocks.dart';

void main() {
  setupGetIt();
  final appConfig = AppConfig.instance;
  appConfig
    ..setBackendEndPoint(DevEnv.backendEndpoint)
    ..setCatalogSQLURL(DevEnv.catalogEndpoint)
    ..setSignUpEndpoint(DevEnv.signUpEndpoint)
    ..setPaymentEndpoint(DevEnv.paymentEndpoint);
  final mockDio = MockDio();
  final fileSystemBLoC = FileSystemBLoC();
  final fakeFile = getIt<FileSystemRepositoryDeprecated>()
      .fakeJsonFile('cbb3c0b45ccf0871d8bf101c1/cardImage');
  fakeFile.remove('state');
  PiixApiDeprecated.setDio(mockDio);
  const userId = 'cbb3c0b45ccf0871d8bf101c';
  const filePath = '/memberships/level/cards/';
  const propertyName = 'image/png';
  const contentType = 'image/png';
  const fileFullRoute =
      'packages/CNOC-2022-01/userBenefitForms/CNOC-2022-Indemnizatorio/b48678cd40feb620894ec9b87c0ca9c9474b7708e75ff18358ccadb945072c60/signature.png';
  const fileContentType = 'image/png';
  const fileObjectData =
      'iVBORw0KGgoAAAANSUhEUgAAAQ4AAABkCAYAAAB3qd4tAAABMWlDQ1BBZG9iZSBSR0IgKDE5OTgpAAAoz62OsUrDUBRAz4ui4lArBHFweJMoKLbqYMakLUUQrNUhydakoUppEl5e1X6Eo1sHF3e/wMlRcFD8Av9AcergECGDgwie6dzD5XLBqNh1p2GUYRBr1W460vV8OfvEDFMA0Amz1G61DgDiJI74w...';
  var path = '';
  late RequestFileModel requestFileModel;
  late S3FileModel s3FileModel;

  group('get file from path', () {
    setUpAll(() {
      requestFileModel = RequestFileModel(
          userId: userId, filePath: filePath, propertyName: propertyName);
      path = '${appConfig.backendEndpoint}/files/get/fromPath';
    });

    setUp(() {
      fileSystemBLoC.fileState = FileStateDeprecated.idle;
      fileSystemBLoC.file = null;
    });

    test(
        'when the service http code response is 200 and includes data '
        ' that is a valid FileModel, the FileState is retrieved', () async {
      expect(fileSystemBLoC.fileState, FileStateDeprecated.idle);
      expect(fileSystemBLoC.file, null);
      when(mockDio.post(path, data: requestFileModel.toJson()))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(path: path),
                statusCode: HttpStatus.ok,
                data: fakeFile,
              ));
      await fileSystemBLoC.getFileFromPath(
          userId: userId, filePath: filePath, propertyName: propertyName);
      expect(fileSystemBLoC.file?.fileContent != null, true);
      expect(fileSystemBLoC.file!.fileContent!.contentType, contentType);
      expect(fileSystemBLoC.fileState, FileStateDeprecated.retrieved);
    });

    test(
        'when the service http code response is 200 but does not include data '
        ' that is a valid FileModel, the FileState is error', () async {
      expect(fileSystemBLoC.fileState, FileStateDeprecated.idle);
      when(mockDio.post(path, data: requestFileModel.toJson()))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(path: path),
                statusCode: HttpStatus.ok,
                data: null,
              ));
      await fileSystemBLoC.getFileFromPath(
          userId: userId, filePath: filePath, propertyName: propertyName);
      expect(fileSystemBLoC.file, null);
      expect(fileSystemBLoC.fileState, FileStateDeprecated.error);
    });

    test(
        'when the service http code response is 404, '
        'the FileState is notFound', () async {
      expect(fileSystemBLoC.fileState, FileStateDeprecated.idle);
      expect(fileSystemBLoC.file, null);
      when(mockDio.post(path, data: requestFileModel.toJson()))
          .thenThrow(DioError(
        requestOptions: RequestOptions(path: path),
        response: Response(
          requestOptions: RequestOptions(path: path),
          statusCode: HttpStatus.notFound,
          data: <String, dynamic>{
            'errorName': 'Piix Error Resource not found',
            'errorMessage': 'There was an error finding the file',
            'errorMessages': '[]'
          },
        ),
        type: DioErrorType.badResponse,
      ));
      await fileSystemBLoC.getFileFromPath(
          userId: userId, filePath: filePath, propertyName: propertyName);
      expect(fileSystemBLoC.file, null);
      expect(fileSystemBLoC.fileState, FileStateDeprecated.notFound);
    });

    test(
        'when the service http code response is 400, '
        'the FileState is error', () async {
      expect(fileSystemBLoC.fileState, FileStateDeprecated.idle);
      expect(fileSystemBLoC.file, null);
      when(mockDio.post(path, data: requestFileModel.toJson()))
          .thenThrow(DioError(
        requestOptions: RequestOptions(path: path),
        response: Response(
          requestOptions: RequestOptions(path: path),
          statusCode: HttpStatus.badRequest,
          data: <String, dynamic>{
            'errorName': 'Piix Error Bad Request',
            'errorMessage': "The server can't send a response",
            'errorMessages': '[]'
          },
        ),
        type: DioErrorType.badResponse,
      ));
      await fileSystemBLoC.getFileFromPath(
          userId: userId, filePath: filePath, propertyName: propertyName);
      expect(fileSystemBLoC.file, null);
      expect(fileSystemBLoC.fileState, FileStateDeprecated.error);
    });
  });

  group('get file from path exceptions', () {
    setUpAll(() {
      requestFileModel = RequestFileModel(
          userId: userId, filePath: filePath, propertyName: propertyName);
      path = '${appConfig.backendEndpoint}/files/get/fromPath';
    });

    setUp(() {
      fileSystemBLoC.fileState = FileStateDeprecated.idle;
      fileSystemBLoC.file = null;
    });

    test(
        'when the app throws a DioErrorType ConnectionTimeout or other, '
        'the FileState is error', () async {
      expect(fileSystemBLoC.fileState, FileStateDeprecated.idle);
      expect(fileSystemBLoC.file, null);
      when(mockDio.post(path, data: requestFileModel.toJson()))
          .thenThrow(DioError(
        requestOptions: RequestOptions(path: path),
        type: DioErrorType.connectionTimeout,
      ));
      await fileSystemBLoC.getFileFromPath(
          userId: userId, filePath: filePath, propertyName: propertyName);
      expect(fileSystemBLoC.file, null);
      expect(fileSystemBLoC.fileState, FileStateDeprecated.error);
    });
  });

  group('upload file to S3', () {
    setUpAll(() {
      s3FileModel = S3FileModel(
          fileFullRoute: fileFullRoute,
          fileContentType: fileContentType,
          fileObjectData: fileObjectData,
          userId: userId);
      path = '${appConfig.catalogEndpoint}/upload/file';
    });

    setUp(() {
      fileSystemBLoC.fileState = FileStateDeprecated.idle;
    });

    test(
        'when the service http code response is 200, the FileState is uploaded',
        () async {
      expect(fileSystemBLoC.fileState, FileStateDeprecated.idle);
      when(mockDio.put(path, data: s3FileModel.toJson()))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(path: path),
                statusCode: HttpStatus.ok,
                data: null,
              ));
      await fileSystemBLoC.uploadS3File(
          fileFullRoute: fileFullRoute,
          fileContentType: fileContentType,
          fileObjectData: fileObjectData,
          userId: userId);
      expect(fileSystemBLoC.fileState, FileStateDeprecated.uploaded);
    });

    test(
        'when the service http code response is 409, the FileState is uploadError',
        () async {
      expect(fileSystemBLoC.fileState, FileStateDeprecated.idle);
      when(mockDio.put(path, data: s3FileModel.toJson())).thenThrow(
        DioError(
          requestOptions: RequestOptions(path: path),
          response: Response(
            requestOptions: RequestOptions(path: path),
            statusCode: HttpStatus.conflict,
            data: <String, dynamic>{
              'errorName': 'Piix Error Resource Conflict',
              'errorMessage': 'There was an error with S3 upload',
              'errorMessages': '[]'
            },
          ),
          type: DioErrorType.badResponse,
        ),
      );
      await fileSystemBLoC.uploadS3File(
          fileFullRoute: fileFullRoute,
          fileContentType: fileContentType,
          fileObjectData: fileObjectData,
          userId: userId);
      expect(fileSystemBLoC.fileState, FileStateDeprecated.uploadError);
    });

    test(
        'when the service http code response is 401, the FileState is uploadError',
        () async {
      expect(fileSystemBLoC.fileState, FileStateDeprecated.idle);
      when(mockDio.put(path, data: s3FileModel.toJson())).thenThrow(
        DioError(
          requestOptions: RequestOptions(path: path),
          response: Response(
              requestOptions: RequestOptions(path: path),
              statusCode: HttpStatus.unauthorized,
              data: <String, dynamic>{
                'errorName': 'Piix Error Unauthorized',
                'errorMessage':
                    'The user is not allowed to upload files to that path',
                'errorMessages': '[]'
              }),
          type: DioErrorType.badResponse,
        ),
      );
      await fileSystemBLoC.uploadS3File(
          fileFullRoute: fileFullRoute,
          fileContentType: fileContentType,
          fileObjectData: fileObjectData,
          userId: userId);
      expect(fileSystemBLoC.fileState, FileStateDeprecated.uploadError);
    });
  });

  group('upload S3 file exceptions', () {
    setUpAll(() {
      s3FileModel = S3FileModel(
          fileFullRoute: fileFullRoute,
          fileContentType: fileContentType,
          fileObjectData: fileObjectData,
          userId: userId);
      path = '${appConfig.catalogEndpoint}/upload/file';
    });

    setUp(() {
      fileSystemBLoC.fileState = FileStateDeprecated.idle;
    });

    test(
        'when the app throws a DioErrorType ConnectionTimeout or other, '
        'the FileState is error', () async {
      expect(fileSystemBLoC.fileState, FileStateDeprecated.idle);
      when(mockDio.put(path, data: s3FileModel.toJson())).thenThrow(
        DioError(
          requestOptions: RequestOptions(path: path),
          type: DioErrorType.connectionTimeout,
        ),
      );
      await fileSystemBLoC.uploadS3File(
          fileFullRoute: fileFullRoute,
          fileContentType: fileContentType,
          fileObjectData: fileObjectData,
          userId: userId);
      expect(fileSystemBLoC.fileState, FileStateDeprecated.error);
    });
  });
}
