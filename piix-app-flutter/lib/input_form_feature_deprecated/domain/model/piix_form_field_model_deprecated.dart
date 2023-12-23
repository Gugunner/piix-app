// import 'package:camera/camera.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:json_annotation/json_annotation.dart';
// import 'package:piix_mobile/general_app_feature/domain/model/selector_model.dart';
// import 'package:piix_mobile/general_app_feature/utils/constants/constants.dart';
// import 'package:piix_mobile/general_app_feature/utils/extension/map_json_extension.dart';
// import 'package:piix_mobile/general_app_feature/utils/extension/string_extend.dart';
// import 'package:piix_mobile/general_app_feature/utils/form_field_utils.dart';
// import 'package:piix_mobile/input_form_feature_deprecated/domain/model/secondary_fields_array_model.dart';

// part 'piix_form_field_model.g.dart';

// enum SignatureType {
//   UNDEFINED,
//   SIGNING,
//   NAME_AND_PLACE,
// }

// enum NumberType {
//   UNDEFINED,
//   WHOLE,
//   DECIMAL,
//   WHOLE_PERCENTAGE,
//   DECIMAL_PERCENTAGE,
//   WHOLE_CURRENCY,
//   DECIMAL_CURRENCY
// }

// ///A collection of values to know what kind of response to store inside a [PiixFormFieldModel].
// ///
// /// otherResponse is stored when [other] is assigned.
// /// idResponse is stored when [id] is assigned.
// /// stringResponse is stored  when [string] is assigned.
// enum ResponseType {
//   other,
//   id,
//   string,
//   image,
// }

// @Deprecated('Use FormFieldModel instead')
// @JsonSerializable()
// class PiixFormFieldModel {
//   PiixFormFieldModel({
//     required this.dataTypeId,
//     required this.name,
//     required this.formFieldId,
//     this.required = true,
//     this.isArray = false,
//     this.isMultiple = false,
//     this.includesOtherOption = false,
//     this.returnId = false,
//     this.isEditable = true,
//     this.lastField = false,
//     this.numberType = NumberType.WHOLE,
//     this.defaultValue,
//     this.document,
//     this.maxLength = 100,
//     this.minLength = 1,
//     this.values,
//     this.min = 1,
//     this.max = 99999,
//     this.secondaryFieldsArrayId,
//     this.secondaryFieldsArray,
//     this.maxDate,
//     this.minDate,
//     this.maxTime,
//     this.minTime,
//     this.minPhotos = 1,
//     this.maxPhotos = 2,
//     this.maxOptions = 1,
//     this.childFormFields,
//     this.tooltip,
//     this.errorText,
//     this.helperText,
//     this.stringResponse,
//     this.idResponse,
//     this.otherResponse,
//     this.objectValues,
//     this.stringValues,
//     this.signatureType,
//     this.capturedImages,
//     this.responseErrorText,
//     this.relatedFormFieldId,
//     this.onChanged,
//   });

//   ///This properties are part of the service model
//   //TODO: Make properties final
//   ///Properties that are always included in service
//   @JsonKey(required: true)
//   final String formFieldId;
//   @JsonKey(required: true)
//   final String dataTypeId;
//   @JsonKey(required: true)
//   final String name;
//   final bool required;
//   final bool isEditable;

//   ///Properties that if not included have default values
//   final int minLength;
//   final int maxLength;
//   final int min;
//   final int max;
//   final int minPhotos;
//   final int maxPhotos;
//   final int maxOptions;
//   final bool isArray;
//   final bool isMultiple;
//   final bool includesOtherOption;
//   final bool returnId;
//    ///Properties that are optional
//   List<SelectorModel>? values;
//   String? defaultValue;
//   String? document;
//   String? minDate;
//   String? maxDate;
//   String? minTime;
//   String? maxTime;
//   List<PiixFormFieldModel>? childFormFields;
//   String? secondaryFieldsArrayId;
//   SecondaryFieldsArrayModel? secondaryFieldsArray;
//   String? tooltip;
//   String? helperText;
//   String? errorText;
//   NumberType? numberType;
//   SignatureType? signatureType;
//   String? relatedFormFieldId;

//   ///These properties are used by the app internal models and ara calculated
//   //TODO: Delete suffixIcon
//   String? stringResponse;
//   String? idResponse;
//   List<SelectorObjectModel>? objectValues;
//   List<String>? stringValues;
//   @JsonKey(includeFromJson: false, includeToJson: false)
//   String? otherResponse;
//   @JsonKey(includeFromJson: false, includeToJson: false)
//   List<XFile>? capturedImages;
//   @JsonKey(includeFromJson: false, includeToJson: false)
//   String? responseErrorText;
//   @JsonKey(includeFromJson: false, includeToJson: false)
//   VoidCallback? onChanged;
//   @JsonKey(includeFromJson: false, includeToJson: false)
//   bool lastField;

//   static void _assignIdResponse(Map<String, dynamic> json) {
//     if (json.isNoEmptyValue<List<dynamic>?>(json['values'])) {
//       //While the model is not parsed, consider using dynamic in the list
//       final List<dynamic> values = json['values'];

//       final valueIdIndex = values.indexWhere((value) =>
//           ((json['stringResponse'] ?? '') as String) == value['valueId']);

//       if (valueIdIndex > -1) {
//         final defaultValue = values[valueIdIndex];
//         json['stringResponse'] = defaultValue['name'] ?? '';
//         json['idResponse'] = defaultValue['valueId'] ?? '';
//         return;
//       }
//       final nameIndex = values.indexWhere((value) =>
//           ((json['stringResponse'] ?? '') as String) == value['name']);
//       if (nameIndex > -1) {
//         final defaultValue = values[nameIndex];
//         json['stringResponse'] = defaultValue['name'] ?? '';
//         json['idResponse'] = defaultValue['valueId'] ?? '';
//         return;
//       }
//     }
//   }

//   factory PiixFormFieldModel.fromJson(Map<String, dynamic> json) {
//     if (json['defaultValue'] != null) {
//       json['stringResponse'] = json['defaultValue'];
//     }
//     if (json['returnId'] ?? false) {
//       _assignIdResponse(json);
//     }
//     if (json['dataTypeId'] == Constants.objectType) {
//       json['objectValues'] = json['values'];
//       json.remove('values');
//     } else if (json['dataTypeId'] == Constants.stringType) {
//       if (json['isArray'] == true) {
//         if (!(json['returnId'] ?? false)) {
//           if (json['includesOtherOption'] ?? false) {
//             final hasOtherOption = (json['values'] as List<dynamic>).any(
//                 (v) => v.toLowerCase() == 'otro' || v.toLowerCase() == 'otra');
//             if (!hasOtherOption) {
//               (json['values'] as List<dynamic>).add('Otro');
//             }
//           }
//           json['stringValues'] = json['values'];
//           json.remove('values');
//         }
//       }
//     }
//     return _$PiixFormFieldModelFromJson(json);
//   }

//   Map<String, dynamic> toJson() => _$PiixFormFieldModelToJson(this);

//   PiixFormFieldModel copyWith({
//     String? dataTypeId,
//     String? defaultValue,
//     String? document,
//     String? name,
//     String? formFieldId,
//     int? maxLength,
//     int? minLength,
//     bool? isArray,
//     bool? isMultiple,
//     List<SelectorModel>? values,
//     int? min,
//     int? max,
//     bool? required,
//     int? arrayRepetition,
//     String? secondaryFieldsArrayId,
//     SecondaryFieldsArrayModel? secondaryFieldsArray,
//     String? maxDate,
//     String? minDate,
//     String? maxTime,
//     String? minTime,
//     int? minPhotos,
//     int? maxPhotos,
//     int? maxOptions,
//     List<PiixFormFieldModel>? childFormFields,
//     bool? multipleImages,
//     bool? isId,
//     int? protectedIndex,
//     bool? allRepetitionsAreRequired,
//     String? tooltip,
//     int? prefixCodePoint,
//     int? matrixIndex,
//     bool? includesOtherOption,
//     bool? returnId,
//     bool? nonEditable,
//     bool? notVisible,
//     bool? noValues,
//     bool? isVisible,
//     String? errorText,
//     String? nameSection,
//     String? helperText,
//     Widget? suffixIcon,
//     bool? isEditable,
//     NumberType? numberType,
//     SignatureType? signatureType,
//     String? answer,
//     String? stringResponse,
//     String? idResponse,
//     String? otherResponse,
//     List<SelectorObjectModel>? objectValues,
//     List<String>? stringValues,
//     List<XFile>? capturedImages,
//   }) {
//     return PiixFormFieldModel(
//       dataTypeId: dataTypeId ?? this.dataTypeId,
//       defaultValue: defaultValue ?? this.defaultValue,
//       document: document ?? document,
//       name: name ?? this.name,
//       formFieldId: formFieldId ?? this.formFieldId,
//       maxLength: maxLength ?? this.maxLength,
//       minLength: minLength ?? this.minLength,
//       isArray: isArray ?? this.isArray,
//       isMultiple: isMultiple ?? this.isMultiple,
//       values: values ?? this.values,
//       min: min ?? this.min,
//       max: max ?? this.max,
//       required: required ?? this.required,
//       secondaryFieldsArrayId:
//           secondaryFieldsArrayId ?? this.secondaryFieldsArrayId,
//       secondaryFieldsArray: secondaryFieldsArray ?? this.secondaryFieldsArray,
//       maxDate: maxDate ?? this.maxDate,
//       minDate: minDate ?? this.minDate,
//       maxTime: maxTime ?? this.maxTime,
//       minTime: minTime ?? this.minTime,
//       minPhotos: minPhotos ?? this.minPhotos,
//       maxPhotos: maxPhotos ?? this.maxPhotos,
//       maxOptions: maxOptions ?? this.maxOptions,
//       childFormFields: childFormFields != null
//           ? childFormFields.map((e) => e.copyWith()).toList()
//           : this.childFormFields,
//       tooltip: tooltip ?? this.tooltip,
//       includesOtherOption: includesOtherOption ?? this.includesOtherOption,
//       returnId: returnId ?? this.returnId,
//       errorText: errorText ?? this.errorText,
//       helperText: helperText ?? this.helperText,
//       isEditable: isEditable ?? this.isEditable,
//       numberType: numberType ?? this.numberType,
//       signatureType: signatureType ?? this.signatureType,
//       stringResponse: stringResponse ?? this.stringResponse,
//       idResponse: idResponse ?? this.idResponse,
//       otherResponse: otherResponse ?? this.otherResponse,
//       objectValues: objectValues ?? this.objectValues,
//       stringValues: stringValues ?? this.stringValues,
//       capturedImages: capturedImages ?? this.capturedImages,
//     );
//   }
// }

// extension PiixFormFieldModelValidResponse on PiixFormFieldModel {
//   bool get isValidDataTypeResponse {
//     switch (dataTypeId) {
//       case Constants.phoneType:
//         return isValidPhoneResponse;
//       case Constants.stringType:
//       case Constants.dateType:
//       case Constants.timeType:
//       case Constants.objectType:
//       case Constants.signatureType:
//         return isValidStringResponse;
//       case Constants.selfieType:
//       case Constants.documentType:
//         return isValidImages;
//       case Constants.sectionType:
//         return true;
//       default:
//         return isValidResponse;
//     }
//   }

//   bool get isValidPhoneResponse =>
//       otherResponse.isNotNullEmpty &&
//       otherResponse!.contains('+') &&
//       stringResponse.isNotNullEmpty;

//   bool get isValidStringResponse {
//     final checkStringResponse = stringResponse.isNotNullEmpty;
//     if (!checkStringResponse) return false;
//     if (!isArray) return checkStringResponse;
//     if (returnId) return idResponse.isNotNullEmpty;
//     final lowerStringResponse = stringResponse!.toLowerCase();
//     const otherOptions = ['otro', 'otra'];
//     if (!includesOtherOption || !otherOptions.contains(lowerStringResponse)) {
//       return checkStringResponse;
//     }
//     return otherResponse.isNotNullEmpty;
//   }

//   bool get isValidImages {
//     //Case when the image url are loaded from the server, the image urls
//     //should be on the string response
//     if (capturedImages.isNullOrEmpty && stringResponse.isNullOrEmpty) {
//       return false;
//     }
//     if (capturedImages.isNullOrEmpty && stringResponse.isNotNullEmpty) {
//       return true;
//     }
//     //Case when the images are being uploaded from the device
//     final imagesLength = capturedImages!.length;
//     if (imagesLength < minPhotos || imagesLength > maxPhotos) return false;
//     return true;
//   }

//   bool get isValidResponse =>
//       stringResponse.isNotNullEmpty ||
//       idResponse.isNotNullEmpty ||
//       otherResponse.isNotNullEmpty;
// }

// extension PiixFormFieldModelMutable on PiixFormFieldModel {
//   void updateFormFieldResponse({
//     String? value,
//     ResponseType type = ResponseType.string,
//   }) {
//     switch (type) {
//       case ResponseType.id:
//         idResponse = value;
//         return;
//       case ResponseType.string:
//         stringResponse = value;
//         return;
//       case ResponseType.other:
//         otherResponse = value;
//         return;
//       default:
//         return;
//     }
//   }

//   void addCapturedImages(List<XFile> images) {
//     if (capturedImages.isNotNullOrEmpty) {
//       capturedImages = images;
//       return;
//     }
//     capturedImages = [...capturedImages!, ...images];
//   }

//   void updateFormFieldCapturedImage(XFile? image) {
//     if (image == null) return;
//     if (capturedImages.isNotNullOrEmpty) {
//       capturedImages = [image];
//       return;
//     }
//     capturedImages = [...capturedImages!, image];
//   }

//   void cleanErrorText() {
//     if (responseErrorText.isNullOrEmpty) return;
//     responseErrorText = null;
//   }

//   void removeCapturedImageBy(int index) {
//     if (capturedImages.isNotNullOrEmpty) return;
//     capturedImages?.removeAt(index);
//     cleanErrorText();
//   }

//   void removeCapturedImages() {
//     if (capturedImages.isNotNullOrEmpty) return;
//     capturedImages = null;
//     cleanErrorText();
//   }

//   void setLastField(bool value) {
//     if (childFormFields.isNotNullOrEmpty) {
//       childFormFields!.last.lastField = value;
//     } else {
//       lastField = value;
//     }
//   }
// }

// extension PiixFormFieldModelSelectors on PiixFormFieldModel {
//   String get _otherOptionId =>
//       values.isNotNullEmpty ? '${values!.last}-other' : 'other';

//   List<String> get networkImages => (stringResponse ?? '')
//       .split(',')
//       .where((response) => response.isNotEmpty)
//       .toList();

//   void addOtherOptionSelector() {
//     if (includesOtherOption) {
//       values = [
//         ...?values,
//         SelectorModel(
//           id: _otherOptionId,
//           folio: 'OTH',
//           name: 'Otro',
//           // catalogName: _otherOptionCatalog
//         ),
//       ];
//     }
//   }

//   bool get isUniqueSelectFormField =>
//       dataTypeId == Constants.stringType && isArray && !isMultiple;
// }
