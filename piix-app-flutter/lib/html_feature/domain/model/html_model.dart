import 'package:flutter_html/flutter_html.dart';

///The model used in all web services or api calls
///that retrieve a String HTML type structure.
class HtmlModel {
  HtmlModel({
    required this.htmlText,
    this.style = null,
  });

  final String htmlText;

  final Map<String, Style>? style;

  factory HtmlModel.fromJson(Map<String, dynamic> json) {
    return HtmlModel(htmlText: json['htmlText'] as String);
  }

  HtmlModel copyWith({
    String? htmlText,
    Map<String, Style>? style,
  }) =>
      HtmlModel(
        htmlText: htmlText ?? this.htmlText,
        style: style ?? this.style,
      );
}

extension HtmlModelStyle on HtmlModel {
  HtmlModel addStyle(Map<String, Style> style) => copyWith(style: style);
}
