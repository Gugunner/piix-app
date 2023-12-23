import 'package:piix_mobile/file_feature/file_model_barrel_file.dart';
import 'package:piix_mobile/form_feature/form_model_barrel_file.dart';

mixin S3FormManager {
  ///Builds the S3 path where the [S3FileModel] will be stored.
  String _getMainFormS3UrlPath({
    required String mainUserInfoFormId,
    required String userId,
    required String formFieldId,
    int index = 0,
  }) {
    return 'userMainForms/$mainUserInfoFormId/$userId/${formFieldId}_$index';
  }

  ///Obtains the byte information of the [fileContent] and
  ///creates a new [S3FileModel] with a 64 encoding of the
  ///data.
  Future<S3FileModel?> _getS3FileModel(
    FileContentModel? fileContent, {
    required String s3UrlPath,
    required String userId,
  }) async {
    if (fileContent == null) return null;
    try {
      return S3FileModel(
        fileFullRoute: s3UrlPath,
        fileContentType: 'image/jpg',
        fileObjectData: fileContent.base64Content,
        userId: userId,
      );
    } catch (error) {
      //TODO: LOG ERROR
      return null;
    }
  }

  ///Returns a cloned [AnswerModel] where the [answer]
  ///property value swaps places to the [s3File] property
  ///and the [answer] property value is the s3UrlPath.
  Future<AnswerModel> _changeAnswerToS3UrlPath(
    AnswerModel answerModel, {
    required String mainUserInfoFormId,
    required String userId,
    required String formFieldId,
  }) async {
    return answerModel.maybeMap(
      //Returns the unmodified value if it is not an s3
      //model.
      (value) => value,
      s3: (value) async {
        final fileContent = value.answer;
        //Gets the s3UrlPath where the picture data
        //will be stored.
        final s3UrlPath = _getMainFormS3UrlPath(
          mainUserInfoFormId: mainUserInfoFormId,
          userId: userId,
          formFieldId: formFieldId,
        );
        //Creates a new s3FileModel
        final s3FileModel = fileContent is FileContentModel?
            ? await _getS3FileModel(fileContent,
                s3UrlPath: s3UrlPath, userId: userId)
            : value.s3File;
        //Returns the cloned value with the modified
        //answer and s3FileModel properties.
        return value.copyWith(
          answer: s3UrlPath,
          s3File: s3FileModel,
          fileContent: fileContent,
        );
      },
      orElse: () => answerModel,
    );
  }

  ///Returns a cloned [responseForm] where the [AnswerModel]
  ///properties of [answer] and [s3File] have the s3UrlPath
  ///and [S3FileModel] in them respectively.
  Future<ResponseFormModel> prepareS3FileModelInAnswer({
    required ResponseFormModel responseForm,
    required String userId,
  }) async {
    final newAnswers = <AnswerModel>[];

    for (final answer in responseForm.answers) {
      final newAnswer = await _changeAnswerToS3UrlPath(
        answer,
        mainUserInfoFormId: responseForm.mainUserInfoFormId,
        userId: userId,
        formFieldId: answer.formFieldId,
      );
      newAnswers.add(newAnswer);
    }
    //Returns the cloned [responseForm] with the new answers.
    return responseForm.copyWith(answers: newAnswers);
  }
}
