import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:csv/csv.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image/image.dart' as IMG;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';
import 'package:piix_mobile/app_config.dart';
import 'package:piix_mobile/auth_feature/domain/provider/user_provider.dart';
import 'package:piix_mobile/comms_feature/domain/provider/legal_reference_provider_deprecated.dart';
import 'package:piix_mobile/file_feature/domain/provider/file_provider_deprecated.dart';
import 'package:piix_mobile/form_feature/domain/model/form_field_model_deprecated.dart';
import 'package:piix_mobile/form_feature/domain/provider/form_provider_deprecated.dart';
import 'package:piix_mobile/general_app_feature/data/repository/file_system_repository_deprecated.dart';
import 'package:piix_mobile/general_app_feature/di/service_locator.dart';
import 'package:piix_mobile/general_app_feature/domain/bloc/file_system_bloc.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:piix_mobile/utils/date_util.dart';
import 'package:piix_mobile/utils/extensions/string_extend.dart';

import 'package:piix_mobile/general_app_feature/utils/location_utils.dart';
import 'package:piix_mobile/input_form_feature_deprecated/data/repository/ip_repository_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/model/answer_request_item_model.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/membership_provider_deprecated.dart';
import 'package:piix_mobile/utils/log_utils.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'form_answer_provider_deprecated.g.dart';

enum LegalAnswerState {
  idle,
  retrieving,
  retrieved,
  error,
}

///A Riverpod Notifier that stores the pdf path
///for any file
@Riverpod(keepAlive: true)
class PdfPathNotifier extends _$PdfPathNotifier {
  @override
  String build() => '';

  void setPdfPath(String path) {
    state = path;
  }
}

///A Riverpod Notifier that handles the state of [LegalAnswerState]
///when sending a form
@Riverpod(keepAlive: true)
class LegalAnswerStateNotifier extends _$LegalAnswerStateNotifier {
  @override
  LegalAnswerState build() => LegalAnswerState.idle;

  void setState(LegalAnswerState value) {
    state = value;
  }
}

///A Riverpod Notifier class that handles the exact hour
///with minutes and seconds when a form is signed.
@riverpod
class SignedHourNotifier extends _$SignedHourNotifier {
  @override
  AnswerRequestItemModel build() {
    final date = DateTime.now();
    final hour24Format = DateFormat('HH:mm:ss');
    final signedHour = hour24Format.format(date);
    return AnswerRequestItemModel(
      formFieldId: ConstantsDeprecated.signedHour,
      dataTypeId: ConstantsDeprecated.timeType,
      name: 'Hora',
      answer: signedHour,
      csvAnswer: signedHour,
    );
  }
}

///A Riverpod Notifier class that handles the exact date
///as an iso8601 String when a form is signed.

@riverpod
class SignedDateNotifier extends _$SignedDateNotifier {
  @override
  AnswerRequestItemModel build() {
    final date = DateTime.now();
    return AnswerRequestItemModel(
      formFieldId: ConstantsDeprecated.signedDate,
      dataTypeId: ConstantsDeprecated.dateType,
      name: 'Fecha',
      answer: toIsoString(date),
      csvAnswer: toIsoString(date),
    );
  }
}

@Deprecated('Will be removed in 4.0')
///A Riverpod Notifier class that handles the devices ip
///when a form is signed.
@riverpod
class SignedIpNotifier extends _$SignedIpNotifier {
  @override
  void build() => {};

  @Deprecated('Will be removed in 4.0')
  FutureOr<AnswerRequestItemModel> getSignedIp() async {
    final signedIp = await ref.read(ipNotifierProvider.notifier).getIpAddress();
    return AnswerRequestItemModel(
      formFieldId: ConstantsDeprecated.signedIp,
      dataTypeId: ConstantsDeprecated.stringType,
      name: 'IP',
      answer: signedIp,
      csvAnswer: signedIp,
    );
  }
}

  @Deprecated('Will be removed in 4.0')
///A Riverpod Notifier class that handles the devices location
///when a form is signed.
@riverpod
class SignedLocationNotifier extends _$SignedLocationNotifier {
  @override
  void build() => {};

  @Deprecated('Will be removed in 4.0')
  Future<AnswerRequestItemModel> getSignedLocation() async {
    final signedGeoLocalization =
        await ref.read(locationNotifierProvider.notifier).getLocation();
    final answer = '${signedGeoLocalization.latitude}, '
        '${signedGeoLocalization.longitude}';
    return AnswerRequestItemModel(
      formFieldId: ConstantsDeprecated.signedGeolocalization,
      dataTypeId: ConstantsDeprecated.locationType,
      name: 'Ubicación',
      answer: answer,
      csvAnswer: answer,
    );
  }
}

@Deprecated('Will be removed in 4.0')
///A Riverpod Notifier class that handles each signed answer
///and returns a list of answers that are considered legal answers
///due to the nature of the answers that provides where, how, when and what
///was used to fill and sign a form
@riverpod
class FormLegalAnswerNotifier extends _$FormLegalAnswerNotifier
    with LogAppCall {
  @override
  void build() => {};

  @Deprecated('Will be removed in 4.0')
  Future<List<AnswerRequestItemModel>> answers() async {
    try {
      final signedHour = ref.read(signedHourNotifierProvider);
      final signedDate = ref.read(signedDateNotifierProvider);
      final signedIp =
          await ref.read(signedIpNotifierProvider.notifier).getSignedIp();
      final signedLocation = await ref
          .read(signedLocationNotifierProvider.notifier)
          .getSignedLocation();
      return [
        signedHour,
        signedDate,
        signedIp,
        signedLocation,
      ];
    } catch (error) {
      logError(error, className: 'FormLegalAnswer');
      rethrow;
    }
  }
}


///A Riverpod Notifier class that handles all the
///methods used to convert [FormFieldModelOld] responses
///into [AnswerRequestItemModel] answers when
///submitting a form
@Riverpod(keepAlive: true)
class FormAnswerNotifier extends _$FormAnswerNotifier
    with LogAppCall, LogApiCall {
  @override
  void build() => {};

  ///Builds an [answer] as a String for each model type of [FormFieldModelOld]
  AnswerRequestItemModel responseToAnswer(FormFieldModelOld formField) {
    final answer = formField.maybeMap<String?>(
      (value) => null,
      display: (value) => null,
      section: (value) => null,
      phone: (value) {
        final stringResponse = formField.stringResponse ?? '';
        final otherResponse = formField.otherResponse ?? '';
        final answer =
            '${otherResponse}${stringResponse.replaceAll(otherResponse, '')}';
        if (answer == otherResponse) return null;
        return answer;
      },
      number: (value) {
        if (value.stringResponse.isNullOrEmpty) return null;
        if (value.numberType == NumberType.WHOLE_PERCENTAGE ||
            value.numberType == NumberType.DECIMAL_PERCENTAGE) {
          return divideBy100(value.stringResponse!).toStringAsFixed(2);
        } else if (value.numberType == NumberType.DECIMAL ||
            value.numberType == NumberType.DECIMAL_CURRENCY) {
          return double.parse(value.stringResponse!).toStringAsFixed(2);
        }
        return value.stringResponse;
      },
      orElse: () {
        //For any other form field not specifically declared
        //it checks in order of generality starting with the most uncommon
        //otherResponse, then idResponse and finally the global property
        //stringResponse
        if (formField.otherResponse.isNotNullEmpty) {
          return formField.otherResponse;
        } else if (formField.idResponse.isNotNullEmpty) {
          return formField.idResponse;
        }
        return formField.stringResponse;
      },
    );

    ///A CSV answer can only be retrieved for an array
    ///selector either unique or multiple
    final csvAnswer = formField.mapOrNull(
      (value) => null,
      unique: (value) => value.stringResponse,
      multiple: (value) => value.stringResponse,
    );
    //Builds and returns the model
    //with the information of the answer
    return AnswerRequestItemModel(
      formFieldId: formField.formFieldId,
      dataTypeId: formField.dataTypeId,
      name: formField.name,
      answer: answer ?? null,
      csvAnswer: csvAnswer ?? answer,
    );
  }

  ///A recursive method that checks each form field including any child form
  ///field and returns all form field answers in a single list filtering any
  ///null answer
  List<AnswerRequestItemModel> formResponsesToFormAnswers(
      List<FormFieldModelOld> formFields) {
    final answers = formFields
        .map<List<AnswerRequestItemModel>>(
          (formField) {
            if (formField.childFormFields.isNotNullOrEmpty)
              return formResponsesToFormAnswers(formField.childFormFields!)
                  .toList();
            return [responseToAnswer(formField)];
          },
        )
        .expand((element) => element)
        .where((element) => element.answer != null)
        .toList();
    return answers;
  }

  double divideBy100(String answer) {
    final percentage = num.parse(answer);
    return (percentage / 100).toDouble();
  }
}

///A Riverpod AsyncNotifier class that handles uploading
///image files to the S3 note that it can work both by returning
///an AsyncValue<void> or a void result depending if the
///provider or the notifier is called.
@riverpod
class S3ImageAnswerNotifier extends _$S3ImageAnswerNotifier
    with LogAppCall, LogApiCall {
  @override
  FutureOr<void> build(List<FormFieldModelOld>? formFields) async {
    if (formFields.isNotNullOrEmpty) return;
    return uploadImages(formFields!);
  }

  //A recursive method that uploads either pictures taken from the camera
  //or a file picker or pictures taken from the signature form field.
  //It checks each form field and child form field if applicable.
  Future<void> uploadImages(List<FormFieldModelOld> formFields) async {
    for (final formField in formFields) {
      if (formField.childFormFields.isNotNullOrEmpty)
        return uploadImages(formField.childFormFields!);
      await formField.mapOrNull<Future<void>>(
        (value) async => {},
        document: (value) async {
          if (value.capturedImages.isNullOrEmpty ||
              value.otherResponse.isNullOrEmpty) {
            return null;
          }
          return uploadCapturedImages(
            value.capturedImages!,
            value.otherResponse!.split(','),
          );
        },
        signature: (value) async {
          if (value.stringResponse.isNullOrEmpty ||
              value.otherResponse.isNullOrEmpty) {
            return null;
          }
          return uploadSignatureImage(
            value.stringResponse!,
            value.otherResponse!,
          );
        },
      );
    }
  }

  //Uploads an image captured by the camera or the file picker
  Future<void> uploadCapturedImages(
      List<XFile> capturedImages, List<String> imagePaths) async {
    if (capturedImages.length != imagePaths.length) return;
    for (var index = 0; index < capturedImages.length; index++) {
      try {
        final uInt8Image = await capturedImages[index].readAsBytes();
        final base64Image = base64Encode(uInt8Image);
        await ref.read(s3FileNotifierProvider.notifier).sendFile(
              path: imagePaths[index],
              contentType: ConstantsDeprecated.imageJpgFileType,
              data: base64Image,
            );
      } catch (error) {
        if (error is! DioError) {
          logError(error, className: 'FormAnswerNotifier');
          rethrow;
        }
        logDioException(error, className: 'FormAnswerNotifier');
        rethrow;
      }
    }
    return;
  }

  //Uploads the image of the signature in the form field
  Future<void> uploadSignatureImage(
      String base64Image, String imagePath) async {
    try {
      await ref.read(s3FileNotifierProvider.notifier).sendFile(
            path: imagePath,
            contentType: ConstantsDeprecated.imagePngFileType,
            data: base64Image,
          );
      return;
    } catch (error) {
      if (error is! DioError) {
        logError(error, className: 'FormAnswerNotifier');
        rethrow;
      }
      logDioException(error, className: 'FormAnswerNotifier');
      rethrow;
    }
  }
}

///A Riverpod AsyncNotifier class that handles uploading
///a csv file to the S3 note that it can work both by returning
///an AsyncValue<void> or a void result depending if the
///provider or the notifier is called.
@riverpod
class S3CsvAnswerNotifier extends _$S3CsvAnswerNotifier
    with FormUrlPathBuilder {
  @override
  FutureOr<void> build([bool isAsyncValue = false]) async {
    if (!isAsyncValue) return;
    return uploadCsvToS3();
  }

  ///Converts form answers into a matrix (a list) where each list inside is a
  ///a row and each value is a cell value, in this case the first value is the
  ///column formField name and the second value is the column formField response
  List<List<dynamic>>? _getCSVAnswers() {
    final formFields = ref.read(formNotifierProvider.notifier).formFields;
    return ref
        .read(formAnswerNotifierProvider.notifier)
        .formResponsesToFormAnswers(formFields)
        .map((answer) {
          if (answer.dataTypeId == ConstantsDeprecated.signatureType) return [];
          final stringAnswer = answer.csvAnswer ?? '-';
          return ['${answer.name}', '$stringAnswer'];
        })
        .where((answer) => answer.isNotEmpty)
        .toList();
  }

  ///Writes a temporary csv file in the device
  ///and then uploads the device to S3 after which
  ///it deletes the temporary file from the device
  Future<void> uploadCsvToS3() async {
    final userId = ref.read(userPodProvider)?.userId;
    final packageId =
        getIt<MembershipProviderDeprecated>().selectedMembership?.package.id;
    final form = ref.read(formNotifierProvider);
    final formName = form?.name;
    final benefitFormId = form?.formId;
    final csvAnswers = _getCSVAnswers();
    if (userId.isNullOrEmpty ||
        packageId.isNullOrEmpty ||
        formName.isNullOrEmpty ||
        benefitFormId.isNullOrEmpty ||
        csvAnswers.isNullOrEmpty) return;
    final temporaryDirectory = await getTemporaryDirectory();
    final csvData = const ListToCsvConverter().convert(csvAnswers);
    final filePath = '${temporaryDirectory.path}_piix_'
        '${userId}_${formName}_$benefitFormId.csv';
    final file = await ref
        .read(localFileNotifierProvider.notifier)
        .writeAsString(File(filePath), contents: csvData);
    final uint8Csv = await file.readAsBytes();
    final currentDate = DateTime.now().toString().split(' ')[0];
    final csvName = '${userId}_$benefitFormId';
    final base64Csv = base64Encode(uint8Csv);
    final path = getBucketS3BenefitFormPath(
      packageId: packageId!,
      benefitFormId: benefitFormId!,
      userId: userId!,
      filename: '${currentDate}/$csvName.csv',
    );
    await ref.read(s3FileNotifierProvider.notifier).sendFile(
          path: path,
          contentType: ConstantsDeprecated.csvFileType,
          data: base64Csv,
        );
    ref.read(localFileNotifierProvider.notifier).delete(file);
  }
}

final formAnswersProvider = ChangeNotifierProvider<FormAnswersNotifier>(
    (ref) => FormAnswersNotifier(ref));

@Deprecated('Use instead FormAnswerNotifier')
class FormAnswersNotifier extends ChangeNotifier with LogApiCall, LogAppCall {
  FormAnswersNotifier(this.ref);

  final ChangeNotifierProviderRef<FormAnswersNotifier> ref;

  ///Injection of [CatalogBLoC]
  IpRepositoryDeprecated get _ipRepository => getIt<IpRepositoryDeprecated>();

  ///Injection of [MembershipProviderDeprecated]
  MembershipProviderDeprecated get _membershipBLoC =>
      getIt<MembershipProviderDeprecated>();

  FileSystemBLoC get _fileSystemBLoC => getIt<FileSystemBLoC>();

  Future<String?> _getIpAddress() async {
    LegalAnswerState legalAnswerState;
    try {
      legalAnswerState = LegalAnswerState.retrieving;
      final data = await _ipRepository.getIpAddressRequested();
      if (data is LegalAnswerState) {
        legalAnswerState = data;
      } else {
        legalAnswerState = data['state'];
        return data['ip'];
      }
    } catch (error) {
      if (error is! DioError) {
        logError(error, className: 'LegalAnswersNotifier _getIpAddress');
        rethrow;
      }
      logDioException(error, className: 'LegalAnswersNotifier _getIpAddress');
      legalAnswerState = LegalAnswerState.error;
    }
    ref
        .read(legalAnswerStateNotifierProvider.notifier)
        .setState(legalAnswerState);
    return null;
  }

  ///This method add signed location to legal answers
  ///
  Future<void> getSignedLocation(
      {required List<AnswerRequestItemModel> legalAnswers}) async {
    try {
      final signedGeoLocalization = await getLocation();
      final answer = '${signedGeoLocalization.latitude}, '
          '${signedGeoLocalization.longitude}';
      legalAnswers.add(
        AnswerRequestItemModel(
          formFieldId: ConstantsDeprecated.signedGeolocalization,
          dataTypeId: ConstantsDeprecated.locationType,
          name: 'Ubicación',
          answer: answer,
          csvAnswer: answer,
        ),
      );
    } catch (error) {
      logError(error, className: 'LegalAnswerStatePod getSignedLocation');
      rethrow;
    }
  }

  ///This method gets an ip phone and add ip to legal answers
  Future<void> getSignedIp(
      {required List<AnswerRequestItemModel> legalAnswers}) async {
    try {
      final signedIp = await _getIpAddress();
      final legalAnswerState = ref.read(legalAnswerStateNotifierProvider);
      if (legalAnswerState == LegalAnswerState.error) {
        throw Exception('The device ip could not be retrieved');
      }
      legalAnswers.add(
        AnswerRequestItemModel(
          formFieldId: ConstantsDeprecated.signedIp,
          dataTypeId: ConstantsDeprecated.stringType,
          name: 'IP',
          answer: signedIp,
          csvAnswer: signedIp,
        ),
      );
    } catch (error) {
      rethrow;
    }
  }

  ///This method gets a legal form answers, includes screenshot of form,
  ///ip phone, user location, signed hour and signed date.
  ///
  Future<List<AnswerRequestItemModel>> getLegalAnswers() async {
    final date = DateTime.now();
    final hour24Format = DateFormat('HH:mm:ss');
    final signedHour = hour24Format.format(date);
    try {
      var legalAnswers = <AnswerRequestItemModel>[];
      await Future.wait([
        getSignedIp(legalAnswers: legalAnswers),
        getSignedLocation(legalAnswers: legalAnswers),
      ]);
      legalAnswers = [
        ...legalAnswers,
        AnswerRequestItemModel(
          formFieldId: ConstantsDeprecated.signedHour,
          dataTypeId: ConstantsDeprecated.timeType,
          name: 'Hora',
          answer: signedHour,
          csvAnswer: signedHour,
        ),
        AnswerRequestItemModel(
          formFieldId: ConstantsDeprecated.signedDate,
          dataTypeId: ConstantsDeprecated.dateType,
          name: 'Fecha',
          answer: toIsoString(date),
          csvAnswer: toIsoString(date),
        ),
      ];
      return legalAnswers;
    } catch (error) {
      logError(error, className: 'LegalAnswersNotifier getLegalAnswers');
      ref
          .read(legalAnswerStateNotifierProvider.notifier)
          .setState(LegalAnswerState.error);

      return [];
    }
  }

  ///This method add form screenshot to legal answers
  ///
  Future<AnswerRequestItemModel?> processLegalPdfCopy({
    required ByteData screenshotForm,
  }) async {
    final userId = ref.read(userPodProvider)?.userId;
    final membership = _membershipBLoC.selectedMembership;
    final currentDate = DateTime.now().toString().split(' ')[0];
    try {
      final pngBytes = screenshotForm.buffer.asUint8List();
      final img = IMG.decodeImage(pngBytes)!;
      //According to the pdf library, a letter size sheet is
      //  static const PdfPageFormat letter =PdfPageFormat(8.5 * inch, 11.0 *
      //inch, marginAll: inch);
      //and inch is equal to static const double inch = 72.0;
      //then multiplying 8.5 x 72 we get 612
      const letterWidth = 612.0;
      final pdf = pw.Document();
      final screenShot = pw.MemoryImage(pngBytes);
      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat(
            letterWidth,
            img.height.toDouble(),
            marginAll: 24,
          ),
          build: (pw.Context context) => pw.Image(screenShot),
        ),
      );

      final pdfFile = await pdf.save();
      final base64PDF = base64Encode(pdfFile);
      final form = ref.read(formNotifierProvider);
      if (userId != null && membership != null && form != null) {
        final path = _fileSystemBLoC.getBenefitFormPath(
          packageId: membership.package.id,
          benefitFormId: form.formId,
          userId: userId,
          filename: '$currentDate/form-copy.pdf',
        );
        await _fileSystemBLoC.uploadS3File(
          fileFullRoute: path,
          fileContentType: ConstantsDeprecated.pdfFileType,
          fileObjectData: base64PDF,
          userId: userId,
        );
        if (_fileSystemBLoC.fileState == FileStateDeprecated.uploaded) {
          ref.read(pdfPathNotifierProvider.notifier).setPdfPath(path);
          return AnswerRequestItemModel(
            formFieldId: ConstantsDeprecated.signedUsersFormPhoto,
            dataTypeId: ConstantsDeprecated.stringType,
            name: 'PDF',
            answer: getBucketS3Url(path),
            csvAnswer: getBucketS3Url(path),
          );
        }
        return null;
      }
    } catch (error) {
      if (error is! DioError) {
        logError(error, className: 'LegalAnswersNotifier processLegalPdfCopy');
      } else {
        logDioException(error,
            className: 'LegalAnswersNotifier processLegalPdfCopy');
      }
      _fileSystemBLoC.fileState = FileStateDeprecated.uploadError;
    }
    return null;
  }

  Future<List<FormFieldModelOld>> checkFormForS3ImagesUploads(
      List<FormFieldModelOld> formFields) async {
    final newFormFields = <FormFieldModelOld>[];
    _fileSystemBLoC.fileState = FileStateDeprecated.idle;
    for (final formField in formFields) {
      if (formField.childFormFields.isNotNullOrEmpty) {
        final newChildFormFields =
            await checkFormForS3ImagesUploads(formField.childFormFields!);
        final newFormField = formField.setChildFormFields(newChildFormFields);
        newFormFields.add(newFormField);
      }
      final newFormField = await _shouldUploadImagesToS3(formField);
      newFormFields.add(newFormField);
    }
    return newFormFields;
  }

  Future<FormFieldModelOld> _shouldUploadImagesToS3(
          FormFieldModelOld formField) async =>
      formField.maybeMap<FutureOr<FormFieldModelOld>>(
        (value) => value,
        document: (value) {
          if (value.stringResponse.isNotNullEmpty) return formField;
          if (value.capturedImages.isNullOrEmpty && !value.required) {
            return value;
          }
          return uploadPictureImagesToS3(value);
        },
        signature: (value) => uploadSignatureImagesToS3(value),
        orElse: () => formField,
      );

  Future<FormFieldModelOld> uploadPictureImagesToS3(
      FormFieldModelOld formField) async {
    final currentDate = DateTime.now().toString().split(' ')[0];
    final membership = _membershipBLoC.selectedMembership;
    final userId = ref.read(userPodProvider)?.userId;
    if (userId.isNullOrEmpty || formField.capturedImages.isNullOrEmpty) {
      _fileSystemBLoC.fileState = FileStateDeprecated.uploadError;
      return formField;
    }
    FormFieldModelOld? newFormField;
    final name = formField.name;
    newFormField = formField.setOtherResponse('');
    for (var index = 0; index < formField.capturedImages!.length; index++) {
      String? path;
      final form = ref.read(formNotifierProvider);
      if (membership != null && form != null) {
        path = _fileSystemBLoC.getBenefitFormPath(
          packageId: membership.package.id,
          benefitFormId: form.formId,
          userId: userId!,
          filename: '$currentDate/${name.replaceAll(' ', '')}_${index + 1}.jpg',
        );
      } else {
        path =
            'userMainForms/userDocumentationForm/$userId/${formField.formFieldId}_$index';
      }
      if (newFormField == null) {
        newFormField = formField.setOtherResponse(getBucketS3Url(path));
      } else {
        //Concatenates a new image path to the string
        newFormField = newFormField.setOtherResponse(
            '${newFormField.otherResponse},${getBucketS3Url(path)}');
      }
      final capturedImage = formField.capturedImages![index];
      try {
        final file = File(capturedImage.path);
        final uInt8Image = await file.readAsBytes();
        final base64Image = base64Encode(uInt8Image);
        await _fileSystemBLoC.uploadS3File(
          fileFullRoute: path,
          fileContentType: ConstantsDeprecated.imageJpgFileType,
          fileObjectData: base64Image,
          userId: userId!,
        );
      } catch (error) {
        if (error is! DioError) {
          logError(error,
              className: 'LegalAnswersNotifier uploadPictureImagesToS3');
        } else {
          logDioException(error,
              className: 'LegalAnswersNotifier uploadPictureImagesToS3');
        }
        _fileSystemBLoC.fileState = FileStateDeprecated.uploadError;
        break;
      }
    }
    if (newFormField == null) return formField;
    return newFormField;
  }

  Future<FormFieldModelOld> uploadSignatureImagesToS3(
      FormFieldModelOld formField) async {
    final currentDate = DateTime.now().toString().split(' ')[0];
    final membership = _membershipBLoC.selectedMembership;
    final userId = ref.read(userPodProvider)?.userId;
    final form = ref.read(formNotifierProvider);
    if (membership == null ||
        userId == null ||
        form == null ||
        formField.stringResponse.isNullOrEmpty) return formField;
    final name = formField.name;
    final path = _fileSystemBLoC.getBenefitFormPath(
      packageId: membership.package.id,
      benefitFormId: form.formId,
      userId: userId,
      filename: '$currentDate/${name.replaceAll(' ', '')}.png',
    );
    await _fileSystemBLoC.uploadS3File(
      fileFullRoute: path,
      fileContentType: ConstantsDeprecated.imagePngFileType,
      fileObjectData: formField.stringResponse!,
      userId: userId,
    );
    final newFormField = formField.setOtherResponse(getBucketS3Url(path));
    return newFormField;
  }

  Future<void> uploadCsvToS3(List<AnswerRequestItemModel> answers) async {
    try {
      final currentDate = DateTime.now().toString().split(' ')[0];
      final userId = ref.read(userPodProvider)?.userId;
      final packageId = _membershipBLoC.selectedMembership?.package.id;
      final form = ref.read(formNotifierProvider);
      final formName = form?.name;
      final benefitFormId = form?.formId;
      if (userId != null &&
          packageId != null &&
          formName != null &&
          benefitFormId != null) {
        final temporaryDirectory = await getTemporaryDirectory();
        final file = File('${temporaryDirectory.path}_piix_${userId}_'
            '${formName}_$benefitFormId.csv');
        final csvAnswer = <List<String>>[];
        for (final answer in answers) {
          final stringAnswer = answer.csvAnswer ?? '-';
          if (answer.dataTypeId == ConstantsDeprecated.signatureType) {
            continue;
          }
          csvAnswer.add(['${answer.name}', '$stringAnswer']);
        }
        final csvName = '${userId}_$benefitFormId';
        final csvData = const ListToCsvConverter().convert(csvAnswer);
        await file.writeAsString(csvData);
        final uint8Csv = await file.readAsBytes();
        final base64Csv = base64Encode(uint8Csv);
        final path = _fileSystemBLoC.getBenefitFormPath(
          packageId: packageId,
          benefitFormId: benefitFormId,
          userId: userId,
          filename: '${currentDate}/$csvName.csv',
        );
        await _fileSystemBLoC.uploadS3File(
          fileFullRoute: path,
          fileContentType: ConstantsDeprecated.csvFileType,
          fileObjectData: base64Csv,
          userId: userId,
        );
        return;
      }
      throw Exception('The CSV Form File could not be uploaded to S3');
    } catch (error) {
      if (error is! DioError) {
        logError(error, className: 'SignUpSignInService');
      } else {
        logDioException(error, className: 'SignUpSignInService');
      }
      _fileSystemBLoC.fileState = FileStateDeprecated.uploadError;
    }
  }

  List<AnswerRequestItemModel> responsesToAnswers(
      List<FormFieldModelOld> formFields) {
    final listAnswers = <AnswerRequestItemModel>[];
    for (final formField in formFields) {
      if (formField.dataTypeId == ConstantsDeprecated.displayType) {
        continue;
      }
      // TODO: Add secondary array and main fields array
      if (formField.childFormFields.isNotNullOrEmpty) {
        listAnswers.addAll(
          responsesToAnswers(formField.childFormFields!),
        );
      }
      if (formField.dataTypeId == ConstantsDeprecated.sectionType) {
        continue;
      }
      String? answer;
      String? csvAnswer;
      if (formField.dataTypeId == ConstantsDeprecated.phoneType) {
        final stringResponse = formField.stringResponse ?? '';
        final otherResponse = formField.otherResponse ?? '';
        answer =
            '${otherResponse}${stringResponse.replaceAll(otherResponse, '')}';
        if (answer == otherResponse) {
          answer = null;
        }
      } else if (formField.otherResponse.isNotNullEmpty) {
        answer = formField.otherResponse;
      } else if (formField.idResponse.isNotNullEmpty) {
        answer = formField.idResponse;
        csvAnswer = formField.stringResponse;
      } else {
        answer = formField.stringResponse;
      }
      if (formField.numberType != null && answer.isNotNullEmpty) {
        if (formField.numberType == NumberType.WHOLE_PERCENTAGE ||
            formField.numberType == NumberType.DECIMAL_PERCENTAGE) {
          if (answer.isNotNullEmpty) {
            answer = divideBy100(answer!).toStringAsFixed(2);
          }
        } else if (formField.numberType == NumberType.DECIMAL ||
            formField.numberType == NumberType.DECIMAL_CURRENCY) {
          answer = double.parse(answer!).toStringAsFixed(2);
        }
      }
      if (csvAnswer == null) {
        csvAnswer = answer;
      }
      final answerItem = AnswerRequestItemModel(
        formFieldId: formField.formFieldId,
        dataTypeId: formField.dataTypeId,
        name: formField.name,
        answer: answer,
        csvAnswer: csvAnswer,
      );
      listAnswers.add(answerItem);
    }
    return listAnswers;
  }

  double divideBy100(String answer) {
    final percentage = num.parse(answer);
    return (percentage / 100).toDouble();
  }

  ///This method generate a s3 bucket url
  ///
  String getBucketS3Url(String path) {
    final appConfig = AppConfig.instance;
    return 'https://${appConfig.piixAppS3}.s3.amazonaws.com/${path}';
  }
}
