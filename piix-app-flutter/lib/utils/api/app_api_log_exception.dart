import 'dart:io';

import 'package:dio/dio.dart';

class AppApiLogException implements Exception {
  late String message;
  Map<String, dynamic>? data;
  StackTrace? stackTrace;
  RequestOptions? requestOptions;

  AppApiLogException.fromDioException(DioException exception) {
    stackTrace = exception.stackTrace;
    requestOptions = exception.requestOptions;
    switch (exception.type) {
      case DioExceptionType.cancel:
        message = 'Request to API server was cancelled';
        break;
      case DioExceptionType.connectionTimeout:
        message = 'Connection timeout with API server - ${exception.message}';
        break;
      case DioExceptionType.receiveTimeout:
        message =
            'Receive timeout in connection with API server - ${exception.message}';
        break;
      case DioExceptionType.badResponse:
        message = _handleError(
          exception.response?.statusCode,
          exception.response?.data,
        );
        if (exception.response?.data is String) {
          data = {'data': message};
          break;
        }
        data = exception.response?.data;
        break;
      case DioExceptionType.sendTimeout:
        message =
            'Send timeout in connection with API server - ${exception.message}';
        break;
      case DioExceptionType.unknown:
        if (exception.message?.contains('SocketException') ?? false) {
          message =
              'There was an error with a socket connection - ${exception.message}';
          break;
        }
        message = 'Unexpected error occurred: ${exception.message}';
        break;
      default:
        message = 'Something went wrong: ${exception.message}';
        break;
    }
  }

  String _handleError(int? statusCode, dataError) {
    String buildErrorString(String statusString) {
      if (dataError is String && dataError.contains('<!DOCTYPE html>'))
        return statusString;
      if (dataError != null) {
        var errorString = '\n';
        if (dataError['errorName'] != null) {
          errorString += 'errorName: ${dataError['errorName']}\n';
        }
        if (dataError['errorMessage'] != null) {
          errorString += 'errorMessage: ${dataError['errorMessage']}\n';
        }
        if (dataError['errorMessages'] != null) {
          errorString += 'errorMessages: ${dataError['errorMessages']}\n';
        }
        if (dataError['errorCodes'] != null) {
          errorString += 'errorCodes: ${dataError['errorCodes']}\n';
        }
        if (dataError['detailedErrorCodes'] != null) {
          errorString += 'detailedErrorCodes: '
              '${dataError['detailedErrorCodes']}\n';
        }
        errorString += 'statusCode: ${statusCode.toString()}\n';
        errorString += 'statusString: $statusString';
        return errorString;
      }
      return dataError.toString();
    }

    switch (statusCode) {
      case HttpStatus.badRequest:
        return buildErrorString('Bad request');
      case HttpStatus.unauthorized:
        return buildErrorString('Unauthorized');
      case HttpStatus.forbidden:
        return buildErrorString('Forbidden');
      case HttpStatus.notFound:
        return buildErrorString('Not Found');
      case HttpStatus.conflict:
        return buildErrorString('Conflict');
      case HttpStatus.internalServerError:
        return buildErrorString('Internal server error');
      case HttpStatus.badGateway:
        return buildErrorString('Bad gateway');
      case HttpStatus.gatewayTimeout:
        return buildErrorString('Gateway timeout');
      default:
        return buildErrorString('Other');
    }
  }

  @override
  String toString() => message;
}

extension PiixApiExceptionsExtend on AppApiLogException {
  ///Gets an error message as a string and parses the
  ///status code of the api response error, if there is no status code
  ///returns -1.
  int get statusCode {
    final errorMessages = toString();
    //TODO: Add a new logic that returns an Enum Value for the different HTTP Code Responses
    const statusCodeString = 'statusCode';
    if (errorMessages.contains(statusCodeString)) {
      final codeStartIndex =
          errorMessages.indexOf(statusCodeString) + statusCodeString.length + 2;
      final codeEndIndex = codeStartIndex + 4;
      return int.parse(
          errorMessages.substring(codeStartIndex, codeEndIndex).trim());
    }
    return -1;
  }
}

bool isApiException(Object error) => error is AppApiLogException;
