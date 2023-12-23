import 'package:piix_mobile/html_feature/domain/model/html_model.dart';

abstract interface class IHtmlRepository {
  ///Returns the [HtmlModel] with the terms and 
  ///conditions [htmlText] inside.
  Future<HtmlModel> getTermsAndConditions();
}
