import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:piix_mobile/form_feature/domain/model/app_form_field_deprecated.dart';
import 'package:piix_mobile/general_app_feature/domain/model/selector_model.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/extension/freezed_utils.dart';
import 'package:piix_mobile/general_app_feature/utils/extension/map_json_extension.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';

part 'form_field_model_deprecated.freezed.dart';
part 'form_field_model_deprecated.g.dart';

enum SignatureType {
  UNDEFINED,
  SIGNING,
  NAME_AND_PLACE,
}

///A collection of values to know what kind of response to store inside a [FormFieldModelOld].
///
/// otherResponse is stored when [other] is assigned.
/// idResponse is stored when [id] is assigned.
/// stringResponse is stored  when [string] is assigned.
enum ResponseType {
  other,
  id,
  string,
  image,
}

@Deprecated('Use insted FormFieldModel')

///The implemented class of [AppFormFieldDeprecated] that can create different
///[FormFieldModelOld] types based on the [dataTypeId].
@Freezed(
  copyWith: true,
  fromJson: true,
  toJson: true,
  makeCollectionsUnmodifiable: false,
  unionKey: 'modelType',
)
class FormFieldModelOld extends AppFormFieldDeprecated
    with _$FormFieldModelOld {
  @JsonSerializable(explicitToJson: true)
  const FormFieldModelOld._();

  const factory FormFieldModelOld({
    @JsonKey(required: true) required String dataTypeId,
    required String formFieldId,
    required String name,
    @Default(true) bool required,
    @Default(true) bool isEditable,
    @Default(false) bool isArray,
    @Default(false) bool isMultiple,
    @Default(false) bool includesOtherOption,
    @Default(false) bool returnId,
    String? defaultValue,
    String? errorText,

    ///App derived properties
    @JsonKey(includeToJson: false) String? stringResponse,
    @JsonKey(includeToJson: false) String? parentFormFieldId,
  }) = _FormFieldModel;

  ///String FormFieldModel
  const factory FormFieldModelOld.string({
    @JsonKey(required: true) required String dataTypeId,
    required String formFieldId,
    required String name,
    @Default(true) bool required,
    @Default(true) bool isEditable,
    @Default(1) int minLength,
    @Default(100) int maxLength,
    String? defaultValue,
    String? tooltip,
    String? helperText,
    String? errorText,

    ///App derived properties
    @JsonKey(includeToJson: false) String? stringResponse,
    @JsonKey(includeFromJson: false, includeToJson: false)
    String? responseErrorText,
    @JsonKey(includeFromJson: false, includeToJson: false)
    @Default(false)
    bool lastField,
    @JsonKey(includeToJson: false) String? parentFormFieldId,
  }) = _StringFormFieldModel;

  const factory FormFieldModelOld.time({
    @JsonKey(required: true) required String dataTypeId,
    required String formFieldId,
    required String name,
    @Default(true) bool required,
    @Default(true) bool isEditable,
    String? defaultValue,
    String? minTime,
    String? maxTime,
    String? helperText,

    ///App derived properties
    @JsonKey(includeToJson: false) String? stringResponse,
    @JsonKey(includeToJson: false) String? parentFormFieldId,
  }) = _TimeFormFieldModel;

  const factory FormFieldModelOld.unique({
    @JsonKey(required: true) required String dataTypeId,
    required String formFieldId,
    required String name,
    @Default(true) bool required,
    @Default(true) bool isEditable,
    @Default(false) bool isArray,
    @Default(false) bool isMultiple,
    @Default(false) bool includesOtherOption,
    @Default(false) bool returnId,
    List<SelectorModel>? values,
    String? helperText,
    String? errorText,
    String? relatedFormFieldId,
    String? defaultValue,

    ///App derived properties
    @JsonKey(includeToJson: false) String? stringResponse,
    @JsonKey(includeToJson: false) String? idResponse,
    @JsonKey(includeFromJson: false, includeToJson: false)
    List<String>? stringValues,
    @JsonKey(includeToJson: false) String? otherResponse,
    @JsonKey(includeFromJson: false, includeToJson: false)
    VoidCallback? onChanged,
    @JsonKey(includeToJson: false) String? parentFormFieldId,
  }) = _UniqueSelectFormFieldModel;

  const factory FormFieldModelOld.multiple({
    @JsonKey(required: true) required String dataTypeId,
    required String formFieldId,
    required String name,
    @Default(true) bool required,
    @Default(true) bool isEditable,
    @Default(false) bool isArray,
    @Default(false) bool isMultiple,
    @Default(false) bool returnId,
    @Default(1) int maxOptions,
    String? defaultValue,
    List<SelectorModel>? values,
    String? helperText,

    ///App derived properties
    @JsonKey(includeToJson: false) String? stringResponse,
    @JsonKey(includeToJson: false) String? idResponse,
    @JsonKey(includeFromJson: false, includeToJson: false)
    List<String>? stringValues,
    @JsonKey(includeToJson: false) String? parentFormFieldId,
  }) = _MultipleSelectFormFieldModel;

  const factory FormFieldModelOld.signature({
    @JsonKey(required: true) required String dataTypeId,
    required String formFieldId,
    required String name,
    @Default(true) bool required,
    @Default(true) bool isEditable,
    String? defaultValue,
    SignatureType? signatureType,

    ///App derived properties
    @JsonKey(includeToJson: false) String? stringResponse,
    @JsonKey(includeToJson: false) String? otherResponse,
    @JsonKey(includeToJson: false) String? parentFormFieldId,
  }) = _SignatureFormFieldModel;

  const factory FormFieldModelOld.section({
    @JsonKey(required: true) required String dataTypeId,
    required String formFieldId,
    required String name,
    @Default(false) bool required,
    @Default(false) bool isEditable,
    @JsonKey(readValue: addChildFields)
    List<FormFieldModelOld>? childFormFields,
    String? defaultValue,

    ///App derived properties
    @JsonKey(includeToJson: false) String? stringResponse,
    @JsonKey(includeToJson: false) String? parentFormFieldId,
  }) = _SectionFormFieldModel;

  const factory FormFieldModelOld.phone({
    @JsonKey(required: true) required String dataTypeId,
    required String formFieldId,
    required String name,
    @Default(true) bool required,
    @Default(true) bool isEditable,
    String? defaultValue,
    String? helperText,

    ///App derived properties
    @JsonKey(includeToJson: false) String? stringResponse,
    @JsonKey(includeToJson: false) String? otherResponse,
    @JsonKey(includeFromJson: false, includeToJson: false)
    String? responseErrorText,
    @JsonKey(includeToJson: false) String? parentFormFieldId,
  }) = _PhoneNumberFormFieldModel;

  const factory FormFieldModelOld.object({
    @JsonKey(required: true) required String dataTypeId,
    required String formFieldId,
    required String name,
    @Default(true) bool required,
    @Default(true) bool isEditable,
    @Default(false) bool isArray,
    @Default(false) bool isMultiple,
    String? defaultValue,
    String? helperText,

    ///App derived properties
    @JsonKey(includeToJson: false) String? stringResponse,
    @JsonKey(includeToJson: false) List<SelectorObjectModel>? objectValues,
    @JsonKey(includeToJson: false) String? parentFormFieldId,
  }) = _ObjectSelectFormFieldModel;

  const factory FormFieldModelOld.number({
    @JsonKey(required: true) required String dataTypeId,
    required String formFieldId,
    required String name,
    @Default(true) bool required,
    @Default(true) bool isEditable,
    @Default(1) int min,
    @Default(99999) int max,
    String? helperText,
    NumberType? numberType,
    String? defaultValue,

    ///App derived properties
    @JsonKey(includeToJson: false) String? stringResponse,
    @JsonKey(includeToJson: false) @Default(false) bool lastField,
    @JsonKey(includeToJson: false) String? parentFormFieldId,
  }) = _NumberFormFieldModel;

  //TODO: Separate in selfie and document type
  const factory FormFieldModelOld.document({
    @JsonKey(required: true) required String dataTypeId,
    required String formFieldId,
    required String name,
    @Default(true) bool required,
    @Default(true) bool isEditable,
    @Default(false) bool lastField,
    @Default(1) int minPhotos,
    @Default(2) int maxPhotos,
    String? document,
    String? defaultValue,

    ///App derived properties
    @JsonKey(includeToJson: false) String? stringResponse,
    @JsonKey(includeToJson: false) String? otherResponse,
    @JsonKey(includeFromJson: false, includeToJson: false)
    List<XFile>? capturedImages,
    @JsonKey(includeFromJson: false, includeToJson: false)
    String? responseErrorText,
    @JsonKey(includeToJson: false) String? parentFormFieldId,
  }) = _DocumentFormFieldModel;

  const factory FormFieldModelOld.display({
    @JsonKey(required: true) required String dataTypeId,
    required String formFieldId,
    required String name,
    @Default(true) bool required,
    @Default(false) bool isEditable,
    @Default(false) bool lastField,
    @JsonKey(includeToJson: false) String? parentFormFieldId,
    String? defaultValue,

    ///App derived properties
    @JsonKey(includeToJson: false) String? stringResponse,
  }) = _DisplayFormFieldModel;

  const factory FormFieldModelOld.date({
    @JsonKey(required: true) required String dataTypeId,
    required String formFieldId,
    required String name,
    @Default(true) bool required,
    @Default(true) bool isEditable,
    @Default(false) bool lastField,
    String? minDate,
    String? maxDate,
    String? helperText,
    String? defaultValue,

    ///App derived properties
    @JsonKey(includeToJson: false) String? stringResponse,
    @JsonKey(includeToJson: false) String? parentFormFieldId,
  }) = _DateFormFieldModel;

  //TODO: Add array factory constructor model type

  ///Returns the [modelType] used when constructing the specific FormFieldModel
  ///in [FormField.fromJson] method by mapping the [dataTypeId]
  static String getModelType(Map<String, dynamic> json) {
    //Checks that dataTypeId is included in the json
    final dataTypeId = json['dataTypeId'] ?? 'default';
    switch (dataTypeId) {
      case ConstantsDeprecated.stringType:
        final isArray = json['isArray'] ?? false;
        final isMultiple = json['isMultiple'] ?? false;
        //When it is not an array it is always a string form field
        if (!isArray) return 'string';
        //If it can't select multiple options is a unique
        //option select form field
        if (!isMultiple) return 'unique';
        return 'multiple';
      case ConstantsDeprecated.signatureType:
        return 'signature';
      case ConstantsDeprecated.selfieType:
      case ConstantsDeprecated.documentType:
        return 'document';
      default:
        return dataTypeId;
    }
  }

  ///Assigns the response to the json before instantiating the
  ///[FormFieldModelOld]
  static void _assignIdResponse(Map<String, dynamic> json) {
    if (json.isNoEmptyValue<List<dynamic>?>(json['values'])) {
      //While the model is not parsed, consider using dynamic in the list
      final List<dynamic> values = json['values'];
      //Check if any values valueId is equalToStringResponse,
      //only works with [isArray] form fields
      final valueIdIndex = values.indexWhere((value) =>
          ((json['stringResponse'] ?? '') as String) == value['valueId']);
      //Assigns the responses to the json to get initial values
      //that can be displayed
      if (valueIdIndex > -1) {
        final defaultValue = values[valueIdIndex];
        json['stringResponse'] = defaultValue['name'] ?? '';
        json['idResponse'] = defaultValue['valueId'] ?? '';
        return;
      }
      //Check if any values name is equalToStringResponse,
      //only works with [isArray] form fields
      final nameIndex = values.indexWhere((value) =>
          ((json['stringResponse'] ?? '') as String) == value['name']);
      if (nameIndex > -1) {
        //Assigns the responses to the json to get initial values
        //that can be displayed
        final defaultValue = values[nameIndex];
        json['stringResponse'] = defaultValue['name'] ?? '';
        json['idResponse'] = defaultValue['valueId'] ?? '';
        return;
      }
    }
  }

  ///Adds additiona
  static void _addProperties(Map<String, dynamic> json) {
    //Assign an idResponse if the form field returns an id
    //in the form answer
    if (json['returnId'] ?? false) {
      _assignIdResponse(json);
    }

    ///Object values and values are not instantiated the same,
    ///this reassignment keeps each field separate
    if (json['dataTypeId'] == ConstantsDeprecated.objectType) {
      json['objectValues'] = json['values'];
      json.remove('values');
      return;
    }
    //If the form field is not a String then it can exit
    if (json['dataTypeId'] != ConstantsDeprecated.stringType) return;
    //If the form field is a String type but not an array it can exit
    if (!(json['isArray'] ?? false)) return;
    //If the form field returns an Id it can exit
    if (json['returnId'] == true) return;
    //If the form field does not allow including another option it can exit
    if (!(json['includesOtherOption'] ?? false)) return;
    //Checks that the form field values not only allow another option
    //but have the option in the values
    final hasOtherOption = (json['values'] as List<dynamic>)
        .any((v) => v.toLowerCase() == 'otro' || v.toLowerCase() == 'otra');
    //If no other option value is present it adds the value
    if (!hasOtherOption) {
      (json['values'] as List<dynamic>).add('Otro');
    }
    //Reassigns the values to stringValues as other option
    //only work with string unique select form fields
    json['stringValues'] = json['values'];
    json.remove('values');
  }

  factory FormFieldModelOld.fromJson(Map<String, dynamic> json) {
    //Assigns to the formField the model type
    json['modelType'] = getModelType(json);
    if (json['defaultValue'] != null) {
      //By default any default value is assigned to the
      //stringResponse of any form field
      json['stringResponse'] = json['defaultValue'];
    }
    if (json['returnId'] ?? false) {
      _assignIdResponse(json);
    }
    _addProperties(json);
    return _$FormFieldModelOldFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    final json = toJson();
    json.remove('modelType');
    return json;
  }

  @override
  bool get isArray => maybeMap(
        (value) => value.isArray,
        unique: (value) => value.isArray,
        multiple: (value) => value.isArray,
        object: (value) => value.isArray,
        orElse: () => false,
      );

  int get min => maybeMap(
        (_) => 1,
        number: (value) => value.min,
        orElse: () => 1,
      );

  int get max => maybeMap(
        (_) => 99999,
        number: (value) => value.max,
        orElse: () => 99999,
      );

  int get maxOptions => maybeMap(
        (_) => 1,
        multiple: (value) => value.maxOptions,
        orElse: () => 1,
      );

  int get minLength => maybeMap(
        (_) => 1,
        multiple: (value) => value.minLength,
        orElse: () => 1,
      );

  int get maxLength => maybeMap(
        (_) => 100,
        multiple: (value) => value.maxLength,
        orElse: () => 100,
      );

  int get minPhotos => maybeMap(
        (value) => 1,
        document: (value) => value.minPhotos,
        orElse: () => 1,
      );

  int get maxPhotos => maybeMap(
        (value) => 2,
        document: (value) => value.maxPhotos,
        orElse: () => 2,
      );

  List<FormFieldModelOld>? get childFormFields => mapOrNull(
        (value) => null,
        section: (value) => value.childFormFields,
      );

  NumberType? get numberType => mapOrNull(
        (value) => null,
        number: (value) => value.numberType,
      );

  String? get document => mapOrNull(
        (value) => null,
        document: (value) => value.document,
      );

  String? get tooltip => mapOrNull(
        (value) => null,
        string: (value) => value.tooltip,
      );

  String? get helperText => mapOrNull(
        (value) => null,
        string: (value) => value.helperText,
        time: (value) => value.helperText,
        unique: (value) => value.helperText,
        multiple: (value) => value.helperText,
        phone: (value) => value.helperText,
        object: (value) => value.helperText,
        number: (value) => value.helperText,
      );

  String? get errorText => mapOrNull(
        (value) => value.helperText,
        string: (value) => value.helperText,
        unique: (value) => value.helperText,
      );

  String? get relatedFormFieldId => mapOrNull(
        (value) => null,
        unique: (value) => value.relatedFormFieldId,
      );

  String? get minDate => mapOrNull(
        (value) => null,
        date: (value) => value.minDate,
      );

  String? get maxDate => mapOrNull(
        (value) => null,
        date: (value) => value.maxDate,
      );

  String? get minTime => mapOrNull(
        (value) => null,
        time: (value) => value.minTime,
      );

  String? get maxTime => mapOrNull(
        (value) => null,
        time: (value) => value.maxTime,
      );

  SignatureType? get signatureType => mapOrNull(
        (value) => null,
        signature: (value) => value.signatureType,
      );

  ///App derived properties
  String? get idResponse => mapOrNull(
        (value) => null,
        unique: (value) => value.idResponse,
        multiple: (value) => value.idResponse,
      );

  String? get otherResponse => mapOrNull(
        (value) => null,
        unique: (value) => value.otherResponse,
        phone: (value) => value.otherResponse,
        document: (value) => value.otherResponse,
        signature: (value) => value.otherResponse,
      );

  List<XFile>? get capturedImages => mapOrNull(
        (value) => null,
        document: (value) => value.capturedImages,
      );

  List<SelectorModel>? get values => mapOrNull(
        (value) => null,
        unique: (value) => value.values,
        multiple: (value) => value.values,
      );

  List<String>? get stringValues => mapOrNull(
        (value) => null,
        unique: (value) => value.stringValues,
        multiple: (value) => value.stringValues,
      );

  List<SelectorObjectModel>? get objectValues => mapOrNull(
        (value) => null,
        object: (value) => value.objectValues,
      );

  String? get responseErrorText => mapOrNull(
        (value) => null,
        string: (value) => value.responseErrorText,
        phone: (value) => value.responseErrorText,
        document: (value) => value.responseErrorText,
      );

  VoidCallback? get onChanged => mapOrNull(
        (value) => null,
        unique: (value) => value.onChanged,
      );

  bool get lastField => maybeMap(
        (_) => false,
        string: (value) => value.lastField,
        number: (value) => value.lastField,
        orElse: () => false,
      );

  List<String> get networkImages => (stringResponse ?? '')
      .split(',')
      .where((response) => response.isNotEmpty)
      .toList();

  int get minimumImages => minPhotos;

  bool get hasMinimumImages {
    if (capturedImages.isNotNullOrEmpty) {
      return capturedImages!.length >= minimumImages;
    }
    return true;
  }
}

extension FormFieldModelValidResponse on FormFieldModelOld {
  bool get isValidResponse =>
      stringResponse.isNotNullEmpty ||
      idResponse.isNotNullEmpty ||
      otherResponse.isNotNullEmpty;

  bool get isValidPhoneResponse =>
      otherResponse.isNotNullEmpty &&
      otherResponse!.contains('+') &&
      stringResponse.isNotNullEmpty;

  bool get isValidStringResponse {
    final checkStringResponse = stringResponse.isNotNullEmpty;
    if (!checkStringResponse) return false;
    if (!isArray) return checkStringResponse;
    //If the response is to return the id then the
    //idResponse must not be null or Empty
    if (returnId) return idResponse.isNotNullEmpty;
    final lowerStringResponse = stringResponse!.toLowerCase();
    const otherOptions = ['otro', 'otra'];
    //If the response is not another option then it is valid
    if (!includesOtherOption || !otherOptions.contains(lowerStringResponse)) {
      return true;
    }
    //If the response is another option then it checks it is not null
    //nor empty
    return otherResponse.isNotNullEmpty;
  }

  bool get isValidImages {
    //Case when the image url are loaded from the server, but the image urls
    //are not in the response
    if (capturedImages.isNullOrEmpty && stringResponse.isNullOrEmpty) {
      return false;
    }
    //Case when the image url are loaded from the server, and the image urls
    //are in the response
    if (capturedImages.isNullOrEmpty && stringResponse.isNotNullEmpty) {
      return true;
    }
    //Case when the images are being uploaded from the device
    final imagesLength = capturedImages!.length;
    if (imagesLength < minPhotos || imagesLength > maxPhotos) return false;
    return true;
  }

  bool get isValidDataTypeResponse => maybeMap(
        (_) => isValidResponse,
        string: (_) => isValidStringResponse,
        time: (_) => isValidStringResponse,
        signature: (_) => isValidStringResponse,
        section: (_) => true,
        phone: (_) => isValidPhoneResponse,
        object: (_) => isValidStringResponse,
        document: (_) => isValidImages,
        date: (_) => isValidStringResponse,
        orElse: () => isValidResponse,
      );
}

extension MutableFormFieldModel on FormFieldModelOld {
  FormFieldModelOld setDocument(String? value) => maybeMap(
        (formField) => formField,
        document: (formField) => formField.copyWith(document: value),
        orElse: () => this,
      );

  FormFieldModelOld setHelperText(String? value) => maybeMap(
        (formField) => formField,
        string: (formField) => formField.copyWith(helperText: value),
        time: (formField) => formField.copyWith(helperText: value),
        unique: (formField) => formField.copyWith(helperText: value),
        multiple: (formField) => formField.copyWith(helperText: value),
        phone: (formField) => formField.copyWith(helperText: value),
        object: (formField) => formField.copyWith(helperText: value),
        number: (formField) => formField.copyWith(helperText: value),
        orElse: () => this,
      );

  FormFieldModelOld setIdResponse(String? value) => maybeMap(
        (formField) => formField,
        unique: (formField) => formField.copyWith(idResponse: value),
        multiple: (formField) => formField.copyWith(idResponse: value),
        orElse: () => this,
      );

  FormFieldModelOld setOtherResponse(String? value) => maybeMap(
        (formField) => formField,
        unique: (formField) => formField.copyWith(otherResponse: value),
        phone: (formField) => formField.copyWith(otherResponse: value),
        document: (formField) => formField.copyWith(otherResponse: value),
        signature: (formField) => formField.copyWith(otherResponse: value),
        orElse: () => this,
      );

  FormFieldModelOld setCapturedImages(List<XFile>? images) => maybeMap(
        (formField) => formField,
        document: (formField) => formField.copyWith(capturedImages: images),
        orElse: () => this,
      );

  FormFieldModelOld setResponseErrorText(String? value) => maybeMap(
        (formField) => formField,
        string: (formField) => formField.copyWith(responseErrorText: value),
        phone: (formField) => formField.copyWith(responseErrorText: value),
        document: (formField) => formField.copyWith(responseErrorText: value),
        orElse: () => this,
      );

  FormFieldModelOld setChildFormFields(
          List<FormFieldModelOld> childFormFields) =>
      maybeMap(
        (formField) => formField,
        section: (formField) =>
            formField.copyWith(childFormFields: childFormFields),
        orElse: () => this,
      );

  FormFieldModelOld setOnchanged(VoidCallback? calback) => maybeMap(
        (formField) => formField,
        unique: (formField) => formField.copyWith(onChanged: calback),
        orElse: () => this,
      );

  FormFieldModelOld updateFormFieldResponse({
    String? value,
    ResponseType type = ResponseType.string,
  }) {
    //TODO: Modify how to update all responses when necessary
    switch (type) {
      case ResponseType.id:
        return setIdResponse(value);
      case ResponseType.string:
        return copyWith(stringResponse: value);
      case ResponseType.other:
        return setOtherResponse(value);
      default:
        return this;
    }
  }

  FormFieldModelOld addCapturedImages(List<XFile> images) {
    if (capturedImages.isNullOrEmpty) {
      return setCapturedImages(images);
    }
    return setCapturedImages([...capturedImages!, ...images]);
  }

  FormFieldModelOld updateFormFieldCapturedImage(XFile? image) {
    if (image == null) return this;
    if (capturedImages.isNullOrEmpty) {
      return setCapturedImages([image]);
    }
    return setCapturedImages([...capturedImages!, image]);
  }

  FormFieldModelOld cleanResponseErrorText() {
    if (responseErrorText.isNullOrEmpty) return this;
    return setResponseErrorText(null);
  }

  FormFieldModelOld removeCapturedImageBy(int index) {
    if (capturedImages.isNullOrEmpty) return this;
    cleanResponseErrorText();
    final newCapturedImages = capturedImages!.removeIndexValue<XFile>(index);
    if (newCapturedImages.isEmpty) return setCapturedImages(null);
    return setCapturedImages(newCapturedImages);
  }

  FormFieldModelOld removeCapturedImages() {
    if (capturedImages.isNullOrEmpty) return this;
    cleanResponseErrorText();
    return setCapturedImages(null);
  }

  FormFieldModelOld replaceFormFieldBy(FormFieldModelOld newFormField) {
    final index =
        childFormFields?.indexWhere((formField) => formField == newFormField);
    if (index == null || index < 0) return this;
    final newFormFields =
        childFormFields!.updateIndexValue(index, value: newFormField);
    return setChildFormFields(newFormFields);
  }
}
