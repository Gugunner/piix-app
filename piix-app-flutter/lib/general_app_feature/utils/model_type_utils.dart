import 'package:piix_mobile/general_app_feature/utils/extension/map_json_extension.dart';

class ModelTypeUtils {
  static Object? _addToMapType(
      Map<dynamic, dynamic> json, String id, String type) {
    if (json.isNoEmptyValue<Map<String, dynamic>?>(json[id])) {
      json[id]['modelType'] = type;
    }
    return json[id];
  }

  static Object? _addToListType(
      Map<dynamic, dynamic> json, String id, String type) {
    final values = json[id];
    if (json.isNoEmptyValue<List<dynamic>?>(values)) {
      for (final value in json[id]) {
        value['modelType'] = type;
      }
    }
    return json[id];
  }

  static Object? addType(
    Map<dynamic, dynamic> json,
    String id,
    String type,
  ) {
    if (json[id] is List<dynamic>) {
      return _addToListType(json, id, type);
    } else if (json[id] is Map) {
      return _addToMapType(json, id, type);
    }
    return json[id];
  }
}
