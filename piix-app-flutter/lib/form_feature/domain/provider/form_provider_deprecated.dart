import 'package:image_picker/image_picker.dart';
import 'package:piix_mobile/app_config.dart';
import 'package:piix_mobile/auth_feature/domain/provider/user_provider.dart';
import 'package:piix_mobile/form_feature/domain/model/form_field_model_deprecated.dart';
import 'package:piix_mobile/utils/extensions/list_extend.dart';
import 'package:piix_mobile/utils/extensions/string_extend.dart';
import 'package:piix_mobile/form_feature/domain/model/form_model_deprecated.dart';
import 'package:piix_mobile/membership_feature/domain/provider/membership_provider.dart';
import 'package:piix_mobile/utils/app_copies_barrel_file.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'form_provider_deprecated.g.dart';

@Deprecated('Will be removed in 4.0')

///The values that reference
///specific formField ids used
///in the app
enum FormFieldErrorDeprecated {
  none,
  uniqueId,
  packageId,
  name,
  firstLastName,
  phoneNumber,
  email,
  signature,
  generic;

  String? get errorMessage {
    switch (this) {
      case FormFieldErrorDeprecated.email:
        return PiixCopiesDeprecated.emailError;
      case FormFieldErrorDeprecated.name:
        return PiixCopiesDeprecated.namesError;
      case FormFieldErrorDeprecated.firstLastName:
        return PiixCopiesDeprecated.lastNamesError;
      case FormFieldErrorDeprecated.generic:
        return '*El formulario tiene campos invalidos';
      default:
        return null;
    }
  }
}

@Deprecated('Use a PiixApiError passed to a TextFormField with a validator')

///A Riverpod Notifier that handles the state of the
///[FormFieldErrorDeprecated] value
@Riverpod(keepAlive: true)
class FormFieldErrorNotifierDeprecatedPod
    extends _$FormFieldErrorNotifierDeprecatedPod {
  @override
  FormFieldErrorDeprecated build() => FormFieldErrorDeprecated.none;
  void setFormFieldError(FormFieldErrorDeprecated error) {
    state = error;
  }
}

@Deprecated('Will be removed in 4.0')

///A Riverpod Notifier class that handles the state of the [FormModelOld]
///this class also handles logic to replace [FormFieldModelOld] from
///the [formFields] property and replacing the [form] when it is required.
///
///It also adds a proxy logic for specific actions such as updating values
///inside a [formField] which allow notifying the watcher [ConsumerWidget]
///classes
@Riverpod(keepAlive: true)
class FormNotifier extends _$FormNotifier {
  @override
  FormModelOld? build() => null;
  @Deprecated('Will be removed in 4.0')
  FormModelOld? get form => state;
  @Deprecated('Will be removed in 4.0')
  void setForm(FormModelOld? form) {
    state = form;
  }

  @Deprecated('Will be removed in 4.0')
  List<FormFieldModelOld> get formFields => [];
  // state?.formFields ?? [];
  @Deprecated('Will be removed in 4.0')

  ///Returns a new form by replacing a an old [formField] with
  ///the [newFormField] to correctly replace the instance
  ///it checks if it is a parent or a childFormField, since
  ///the [formField] and [form] is immutable it returns a new
  ///cloned instance of it with the new [formFields]
  FormModelOld? getNewForm(FormFieldModelOld? newFormField) {
    if (newFormField == null) return form;
    //Checks if the newFormField has a parent formField
    if (newFormField.parentFormFieldId.isNotNullEmpty) {
      //Finds the parent formField by it's id
      final parentFormField = form
          ?.formFieldBy(newFormField.parentFormFieldId!)
          ?.replaceFormFieldBy(newFormField);
      if (parentFormField == null) return form;
      return form?.replaceFormFieldBy(parentFormField) ?? form;
    }
    return form?.replaceFormFieldBy(newFormField) ?? form;
  }

  @Deprecated('Will be removed in 4.0')

  ///Replaces a list of [oldFormFields] with the [newFormFields]
  void replaceFormFields(List<FormFieldModelOld> newFormFields) {
    FormModelOld? newForm;
    //For each newFormField a new form is returned
    for (final newFormField in newFormFields) {
      //When newForm is null it recovers a new one
      //with the newFormField
      if (newForm == null) {
        newForm = getNewForm(newFormField);
        //Goes to next iteration of the for loop
        continue;
      }
      //If newForm is not null it still returns a new form with
      //the newFormField after which it clones with the accumulated
      //formFields already changed
      newForm =
          getNewForm(newFormField)?.copyWith(formFields: newForm.formFields);
    }
    //Replaces the current form with the new form
    setForm(newForm);
  }

  @Deprecated('Will be removed in 4.0')

  ///Replaces an [oldFormField] with a [newFormField]
  void replaceFormField(FormFieldModelOld? newFormField) {
    final newForm = getNewForm(newFormField);
    setForm(newForm);
  }

  @Deprecated('Will be removed in 4.0')

  ///Using a [FormFieldModelOld] update the response and notify the listener.
  ///It always returns the updated formField
  FormFieldModelOld updateFormField(
      {required FormFieldModelOld formField,
      String? value,
      XFile? capturedImage,
      ResponseType type = ResponseType.string}) {
    FormFieldModelOld? newFormField;
    if (type == ResponseType.image) {
      newFormField = formField.updateFormFieldCapturedImage(capturedImage);
    } else {
      newFormField =
          formField.updateFormFieldResponse(value: value, type: type);
    }
    //Each time the formField is updated the error dissapears of the formField
    //until a new submit, if the error is generic it clears it after any form
    //field updates it's value
    final formFieldError =
        ref.read(formFieldErrorNotifierDeprecatedPodProvider);
    if (formFieldError.name == newFormField.formFieldId ||
        formFieldError == FormFieldErrorDeprecated.generic) {
      ref
          .read(formFieldErrorNotifierDeprecatedPodProvider.notifier)
          .setFormFieldError(FormFieldErrorDeprecated.none);
    }
    //Specifically clears the errorText of the formField
    newFormField = newFormField.cleanResponseErrorText();
    replaceFormField(newFormField);
    return newFormField;
  }

  @Deprecated('Will be removed in 4.0')

  ///Adds an error text to the formField and
  ///sets the [FormFieldErrorDeprecated] to generic
  FormFieldModelOld? addResponseErrorTextToField(
    String formFieldId, {
    required String text,
  }) {
    final formField =
        state?.formFieldBy(formFieldId)?.setResponseErrorText(text);
    if (formField == null) return null;
    replaceFormField(formField);
    //Any error triggers a generic error
    ref
        .read(formFieldErrorNotifierDeprecatedPodProvider.notifier)
        .setFormFieldError(FormFieldErrorDeprecated.generic);
    return formField;
  }

  @Deprecated('Will be removed in 4.0')

  ///Adds the images from the gallery file picker to the
  ///[formField]
  FormFieldModelOld addGalleryImages(
      FormFieldModelOld formField, List<XFile> images) {
    final newFormField = formField.addCapturedImages(images);
    replaceFormField(newFormField);
    return newFormField;
  }

  @Deprecated('Will be removed in 4.0')

  ///Removes any image from the [formField] by it's index
  FormFieldModelOld removeCapturedImage(
      FormFieldModelOld formField, int index) {
    final newFormField = formField.removeCapturedImageBy(index);
    replaceFormField(newFormField);
    return newFormField;
  }

  @Deprecated('Will be removed in 4.0')

  ///Clears all images from the [formField]
  FormFieldModelOld removeAllImages(FormFieldModelOld formField) {
    final newFormField = formField.removeCapturedImages();
    replaceFormField(newFormField);
    return newFormField;
  }

  @Deprecated('Will be removed in 4.0')

  ///Cleans any [stringResponse], [idResponse] and [otherResponse]
  ///as well as any [capturedImages] from the [formField] by
  ///it's [formFieldId]
  void cleanFormResponses({
    bool skip = false,
    List<String>? formFieldIds,
  }) {
    final newFormFields = <FormFieldModelOld>[];
    for (var formField in formFields) {
      if (skip &&
          formFieldIds.isNotNullOrEmpty &&
          formFieldIds!.contains(formField.formFieldId)) continue;
      if (formField.capturedImages.isNotNullOrEmpty) {
        formField = formField.removeCapturedImages();
      }
      //Conditions used to avoid cleaning any value when loading the form
      if (formField.idResponse == formField.defaultValue ||
          formField.stringResponse == formField.defaultValue) continue;
      if (formField.stringResponse.isNotNullEmpty) {
        formField = formField.updateFormFieldResponse(
            value: null, type: ResponseType.string);
      }
      if (formField.idResponse.isNotNullEmpty) {
        formField = formField.updateFormFieldResponse(
            value: null, type: ResponseType.id);
      }
      if (formField.otherResponse.isNotNullEmpty) {
        formField = formField.updateFormFieldResponse(
            value: null, type: ResponseType.other);
      }
      newFormFields.add(formField);
    }
    // setForm(state?.copyWith(formFields: newFormFields));
  }

  @Deprecated('Will be removed in 4.0')

  ///A recursive function that checks if the property
  ///required of each [formField] nested to N level
  ///has a valid response (not null and not empty).
  ///
  ///When false the function exits without checking any other pending formfield
  ///whether nested or not.
  bool requiredFieldsFilled(List<FormFieldModelOld> formFields) {
    if (formFields.isEmpty) {
      return false;
    }
    for (final formField in formFields) {
      List<FormFieldModelOld>? childFormFields;
      if (formField.childFormFields.isNotNullOrEmpty) {
        childFormFields = formField.childFormFields;
      }
      //TODO: Uncomment when secondaryFieldsArray is added to FormFieldModel
      // else if (formField
      //         .secondaryFieldsArray?.childFormFields.isNotNullEmpty ??
      //     false) {
      //   childFormFields = formField.secondaryFieldsArray!.childFormFields;
      // }
      if (childFormFields.isNotNullOrEmpty) {
        if (!requiredFieldsFilled(childFormFields!)) return false;
      }
      if (!formField.required) continue;
      if (!formField.isValidDataTypeResponse) return false;
    }
    return true;
  }
}

///A Riverpod Notifier that handles setting the image urls in the
///[otherResponse] of the formField so the images can be uploaded
@riverpod
class ImageUrlNotifier extends _$ImageUrlNotifier with FormUrlPathBuilder {
  @override
  void build() => {};
  @Deprecated('Will be removed in 4.0')

  ///A recursive method that checks for each form field and child form field
  ///to determine if the form field requires setting an image url.
  ///It checks the [modelType] to determine whether is an image from
  ///the camera or file picker or an image from a signature field.
  List<FormFieldModelOld> setImagesUrls(List<FormFieldModelOld> formFields) =>
      formFields.map<FormFieldModelOld>((formField) {
        if (formField.childFormFields.isNotNullOrEmpty) {
          final newChildFormFields = setImagesUrls(formField.childFormFields!);
          return formField.setChildFormFields(newChildFormFields);
        }
        return formField.maybeMap(
          (value) => value,
          document: (value) {
            if (value.stringResponse.isNotNullEmpty) return formField;
            if (value.capturedImages.isNullOrEmpty && !value.required) {
              return value;
            }
            return setImageUrls(value);
          },
          signature: (value) => setSignatureImageUrl(value),
          orElse: () => formField,
        );
      }).toList();
  @Deprecated('Will be removed in 4.0')

  ///Calculates the image path for a camera picture or file picker picture
  ///and stores it in the property [otherResponses], if there are multiple
  ///images it stores all the paths as a single String split by a comma ","
  FormFieldModelOld setImageUrls(FormFieldModelOld formField,
      {bool isBenefitForm = false}) {
    final form = ref.read(formNotifierProvider);
    final capturedImages = formField.capturedImages;
    if (capturedImages == null) return formField;
    final currentDate = DateTime.now().toString().split(' ')[0];
    final userId = ref.read(userPodProvider)?.userId;
    final membership = ref.read(membershipNotifierPodProvider);
    if (userId == null ||
        form == null ||
        formField.stringResponse.isNotNullEmpty) return formField;
    final capturedImageOtherResponses = <String>[];
    for (var index = 0; index < capturedImages.length; index++) {
      String path;
      if (isBenefitForm) {
        path = getBucketS3BenefitFormPath(
          packageId: membership?.package?.packageId ?? '',
          benefitFormId: form.formId,
          userId: userId,
          filename:
              '$currentDate/${form.name.replaceAll(' ', '')}_${index + 1}.jpg',
        );
      } else {
        path =
            'userMainForms/userDocumentationForm/$userId/${formField.formFieldId}_$index';
      }
      capturedImageOtherResponses.add(path);
    }
    return formField.setOtherResponse(capturedImageOtherResponses.join(','));
  }

  @Deprecated('Will be removed in 4.0')

  ///Calculates the image path for a signature field and stores
  ///it in the property [otherResponses]
  FormFieldModelOld setSignatureImageUrl(FormFieldModelOld formField) {
    final form = ref.read(formNotifierProvider);
    final currentDate = DateTime.now().toString().split(' ')[0];
    final userId = ref.read(userPodProvider)?.userId;
    final membership = ref.read(membershipNotifierPodProvider);
    if (membership == null ||
        userId.isNullOrEmpty ||
        form == null ||
        formField.stringResponse.isNotNullEmpty) return formField;
    final path = getBucketS3BenefitFormPath(
      packageId: membership.package?.packageId ?? '',
      benefitFormId: form.formId,
      userId: userId!,
      filename: '$currentDate/${form.name.replaceAll(' ', '')}.png',
    );
    return formField.setOtherResponse(path);
  }
}

mixin FormUrlPathBuilder {
  ///This method generate a s3 bucket url
  String getImageBucketS3Url(String path) {
    final appConfig = AppConfig.instance;
    return 'https://${appConfig.piixAppS3}.s3.amazonaws.com/${path}';
  }

  /// Build and return the path for an image
  String getBucketS3BenefitFormPath(
      {required String packageId,
      required String benefitFormId,
      required String userId,
      required String filename}) {
    return 'packages/$packageId/userBenefitForms/$benefitFormId/$userId/$filename';
  }
}
