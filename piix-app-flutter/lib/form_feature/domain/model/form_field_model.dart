import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:piix_mobile/camera_feature/camera_utils_barrel_file.dart';
import 'package:piix_mobile/file_feature/file_model_barrel_file.dart';

part 'form_field_model.freezed.dart';
part 'form_field_model.g.dart';

@Freezed(
  copyWith: true,
  fromJson: true,
  toJson: false,
  equal: true,
  makeCollectionsUnmodifiable: true,
  unionKey: 'modelType',
  fallbackUnion: 'text',
)

///The class which encapsulates and handles all the entities used
///to describe each field when a form is requested by the api service.
///
///There are some general fields used by all the entities which
///are [required].
///
///The [index] must be passed as a safe measure to always keep the
///same position and order of fields even if any sorting occurs, the
///original state can be restored without having to store a backup instance.
///
///The [formFieldId] is the idenfication value of the field which
///explains what specific information the field will require.
///
///The [dataTypeId] is the identification of the data type it
///may contain, for example [String], [Object], [int], etc...
///
///The [name] is the coloquial value based on the [formFieldId]
/// which is shown to the user to easily comprehend what the field requires.
///
/// The [required] property sets the field as a 'must contain a value'
/// before submitting the filled form.
///
/// The [isEditable] property either allows or prevents a field from
/// further modification by the user.
///
/// The [isHidden] property is a special case when some fields values
/// must be returned to the service but should not appear in the [UI]
/// either because the field is already filled and [isEditable] is false.
/// Or some other rule that prevents from showing it.
///
/// The [defaultValue] is a value that may be included when requesting a form
/// and its value is based on the [dataTypeId]. Normally the [defaultValue] is
/// only present after a sumbitted form is again requested and the values in
/// the fields already filled should be shown.

class FormFieldModel with _$FormFieldModel {
  @JsonSerializable(explicitToJson: true)
  const FormFieldModel._();

  const factory FormFieldModel.text({
    @JsonKey(required: true) required int index,
    @JsonKey(required: true) required String formFieldId,
    @JsonKey(required: true) required String dataTypeId,
    @JsonKey(required: true) required String name,
    @JsonKey(required: true) required bool required,
    @JsonKey(required: true) required bool isEditable,
    @Default(false) bool isHidden,

    ///Used for the [_TextFormFieldModel] to let the presentation
    ///layer know what [BaseAppTextFormField] to draw.
    @JsonKey(required: true) required TextType textType,

    ///Determines the minimum number of characters that must have
    ///the field before submitting.
    int? minLength,

    ///Determines the maximum number of characters that can have
    ///the field before submitting.
    int? maxLength,
    String? defaultValue,
  }) = _TextFormFieldModel;

  const factory FormFieldModel.date({
    @JsonKey(required: true) required int index,
    @JsonKey(required: true) required String formFieldId,
    @JsonKey(required: true) required String dataTypeId,
    @JsonKey(required: true) required String name,
    @JsonKey(required: true) required bool required,
    @JsonKey(required: true) required bool isEditable,
    @Default(false) bool isHidden,

    ///The minimum date value allowed in the field.
    DateTime? minDate,

    ///The maximum date value allowed in the field.
    DateTime? maxDate,
    DateTime? defaultValue,
  }) = _DateFormFieldModel;

  const factory FormFieldModel.uniqueIdSelect({
    ///Used to always locate the same model in the same position.
    @JsonKey(required: true) required int index,
    @JsonKey(required: true) required String formFieldId,
    @JsonKey(required: true) required String dataTypeId,
    @JsonKey(required: true) required String name,
    @JsonKey(required: true) required bool required,
    @JsonKey(required: true) required List<ValueModel> values,
    @JsonKey(required: true) required bool isEditable,
    @Default(false) bool isHidden,

    ///Marks the field so the answer returns the id of the values.
    @Default(false) returnId,

    ///Marks the field so when the user selects 'other' a
    ///custom value can be entered.
    @Default(false) includesOtherOption,
    defaultValue,
  }) = _UniqueIdSelectFormFieldModel;

  ///Built similar to the [text] constructor
  ///but specific for phone numbers.
  const factory FormFieldModel.phone({
    @JsonKey(required: true) required int index,
    @JsonKey(required: true) required String formFieldId,
    @JsonKey(required: true) required String dataTypeId,
    @JsonKey(required: true) required String name,
    @JsonKey(required: true) required bool required,
    @JsonKey(required: true) required bool isEditable,
    @Default(false) bool isHidden,
    String? defaultValue,
  }) = _PhoneFormFieldModel;

  const factory FormFieldModel.document({
    @JsonKey(required: true) required int index,
    @JsonKey(required: true) required String formFieldId,
    @JsonKey(required: true) required String dataTypeId,
    @JsonKey(required: true) required String name,
    @JsonKey(required: true) required bool required,
    @JsonKey(required: true) required bool isEditable,
    @Default(false) bool isHidden,

    ///A special element that includes information into
    ///what document is required,
    String? document,

    ///The minimum number of photos that must be submitted.
    int? minPhotos,

    ///The maximum number of photos that can be submitted.
    int? maxPhotos,
    String? defaultValue,

    ///Indicates the camera whether to draw a silhouette and if so which
    ///silhouette to draw over the preview camera screen.
    @JsonKey(
      includeFromJson: false,
    )
    @Default(CameraSilhouette.id)
    CameraSilhouette cameraSilhouette,

    ///Stores the information to request the image if
    ///[defaultValue] has a S3 url path.
    @JsonKey(
      includeFromJson: false,
    )
    RequestFileModel? requestFile,

    ///Stores the information passed to
    ///the proper [FormField].
    @JsonKey(
      includeFromJson: false,
    )
    FileContentModel? fileContent,
  }) = _DocumentFormFieldModel;

  const factory FormFieldModel.selfie({
    @JsonKey(required: true) required int index,
    @JsonKey(required: true) required String formFieldId,
    @JsonKey(required: true) required String dataTypeId,
    @JsonKey(required: true) required String name,
    @JsonKey(required: true) required bool required,
    @JsonKey(required: true) required bool isEditable,
    @Default(false) bool isHidden,

    ///A special element that includes information into
    ///what document is required,
    String? document,

    ///The minimum number of photos that must be submitted.
    int? minPhotos,

    ///The maximum number of photos that can be submitted.
    int? maxPhotos,
    String? defaultValue,
    @JsonKey(
      includeFromJson: false,
    )
    @Default(CameraSilhouette.selfie)
    CameraSilhouette cameraSilhouette,
    @JsonKey(
      includeFromJson: false,
    )
    RequestFileModel? requestFile,
    @JsonKey(
      includeFromJson: false,
    )
    FileContentModel? fileContent,
  }) = _SelfieFormFieldModel;

  ///Checks the [DataType] name value and compares it to the
  ///[dataTypeId] if a match is found returns a 'specific
  ///modelType' else returns the 'text modelType' as the default.
  static String _getModelType(Map<String, dynamic> json) {
    final dataTypeId = json['dataTypeId'];
    if (dataTypeId == DataType.string.name) {
      final isArray = json['isArray'] ?? false;
      final isMultiple = json['isMultiple'] ?? false;
      if (isArray && !isMultiple) return 'uniqueIdSelect';
      return 'text';
    }
    if (dataTypeId == DataType.phone.name) return 'phone';
    if (dataTypeId == DataType.date.name) return 'date';
    if (dataTypeId == DataType.uniqueSelect.name) return 'uniqueSelect';
    if (dataTypeId == DataType.camera_documents_picture.name) return 'document';
    if (dataTypeId == DataType.camera_selfie_picture.name) return 'selfie';
    return dataTypeId;
  }

  ///Processes a [text] 'modelType' and assigns a [TextType]
  ///based on the value of the [formFieldId].
  static void _processTextFormField(Map<String, dynamic> json) {
    final formFieldId = json['formFieldId'].toLowerCase();
    if (formFieldId.contains('email'))
      json['textType'] = 'email';
    else if (formFieldId.contains('name'))
      json['textType'] = 'name';
    else {
      json['textType'] = 'text';
    }
  }

  factory FormFieldModel.fromJson(Map<String, dynamic> json) {
    //Obtain the corresponding 'modelType'.
    final modelType = _getModelType(json);
    //If the 'modelType' is 'text then it is processed
    //to assign a [TextType] to the json.
    if (modelType == 'text') {
      _processTextFormField(json);
    }
    //Assigns the 'modelType' before converting
    //the json into a FormFieldModel.
    json['modelType'] = modelType;
    return _$FormFieldModelFromJson(json);
  }
}

///An enum that shows all possible constructor
///types for the [FormFieldModel].
enum DataType {
  string,
  phone,
  date,
  uniqueSelect,
  camera_selfie_picture,
  camera_documents_picture,
}

///All the possible values that are considered for a
///[_TextFormFieldModel] subclass.
enum TextType {
  text,
  email,
  name,
}

@JsonSerializable(createToJson: false)

///Used for the [FormFieldModel] constructors that contain [values]
///and need to return an [id] as the answer.
final class ValueModel {
  const ValueModel({
    required this.id,
    required this.name,
  });

  ///The id to return to as part of the answers
  @JsonKey(required: true, name: 'valueId')
  final String id;

  ///The coloquial value shown to the user
  @JsonKey(required: true)
  final String name;

  factory ValueModel.fromJson(Map<String, dynamic> json) =>
      _$ValueModelFromJson(json);
}
