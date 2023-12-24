import 'package:piix_mobile/benefit_per_supplier_feature/utils/branch_type_enum.dart';
import 'package:piix_mobile/general_app_feature/utils/extension/map_json_extension.dart';
import 'package:piix_mobile/claim_ticket_feature/domain/model/ticket_model.dart';
import 'package:piix_mobile/purchase_invoice_feature/domain/model/invoice_status_model.dart';
import 'package:piix_mobile/purchase_invoice_feature/utils/purchase_invoice_enums.dart';
import 'package:piix_mobile/purchase_invoice_feature/utils/product_type_enum_deprecated.dart';

Object? _addToMapType(Map<dynamic, dynamic> json, String id, String type) {
  if (json.isNoEmptyValue<Map<String, dynamic>?>(json[id])) {
    json[id]['modelType'] = type;
  }
  return json[id];
}

Object? _addToListType(Map<dynamic, dynamic> json, String id, String type) {
  final values = json[id];
  if (json.isNoEmptyValue<List<dynamic>?>(values)) {
    for (final value in json[id]) {
      value['modelType'] = type;
    }
  }
  return json[id];
}

Object? _addType(
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

Object? addDefaultType(Map<dynamic, dynamic> json, String id) =>
    _addType(json, id, 'default');

Object? addAdditionalType(Map<dynamic, dynamic> json, String id) =>
    _addType(json, id, 'additional');

Object? addPurchasedType(Map<dynamic, dynamic> json, String id) =>
    _addType(json, id, 'purchased');

Object? addCobenefitType(Map<dynamic, dynamic> json, String id) =>
    _addType(json, id, 'cobenefit');

Object? addLevelType(Map<dynamic, dynamic> json, String id) =>
    _addType(json, id, 'level');

Object? addRatesType(Map<dynamic, dynamic> json, String id) =>
    _addType(json, id, 'rates');

Object? addDetailType(Map<dynamic, dynamic> json, String id) =>
    _addType(json, id, 'detail');

Object? addPaymentType(Map<dynamic, dynamic> json, String id) =>
    _addType(json, id, 'payment');

PaymentStatus fromPaymentStringStatus(String paymentStatus) {
  return PaymentStatus.values.firstWhere(
    (element) => element.name == paymentStatus.toLowerCase(),
    orElse: () => PaymentStatus.none,
  );
}

ProductStatus fromControlStringStatus(String controlStatus) {
  return ProductStatus.values.firstWhere(
    (element) => element.name == controlStatus.toLowerCase(),
    orElse: () => ProductStatus.idle,
  );
}

InvoiceStatusModel fromInvoiceStringStatus(String? invoiceStatus) {
  if (invoiceStatus == null)
    return InvoiceStatusModel(
      name: 'unknown',
      status: InvoiceStatus.unknown,
    );
  final status = InvoiceStatus.values.firstWhere(
    (element) =>
        element.name.toLowerCase() ==
        invoiceStatus.replaceAll('_', '').toLowerCase(),
    orElse: () => InvoiceStatus.unknown,
  );
  final data = {
    'name': status.name,
    'modelType': status.name != 'unknown' ? status.name : 'default',
    'status': status.name,
  };
  return InvoiceStatusModel.fromJson(data);
}

TicketStatus fromTicketStringStatus(String ticketStatus) {
  return TicketStatus.values.firstWhere(
    (element) => element.name == ticketStatus.toLowerCase(),
    orElse: () => TicketStatus.unknown,
  );
}

ProductTypeDeprecated fromProductStringStatus(String productType) {
  return ProductTypeDeprecated.values.firstWhere(
    (element) => element.name == productType.toLowerCase(),
    orElse: () => ProductTypeDeprecated.NONE,
  );
}

Object? addBranchTypeEmergencyOption(Map<dynamic, dynamic> json, String id) {
  if (json.isNoEmptyValue<String?>(json[id])) {
    final branchTypes = BranchType.values.map((type) => type.name);
    final hasValidType = branchTypes.contains(json[id]);
    if (!hasValidType) json[id] = 'emergency';
    return json[id];
  }
  json[id] = 'emergency';
  return json[id];
}

void addChildFields(Map<dynamic, dynamic> json, String id) {
  if (json.isNullOrEmpty<List<Map<dynamic, dynamic>>>(json[id])) return;
  final length = (json[id] as List<Map<String, dynamic>>).length;
  for (var index = 0; index < length; index++) {
    final newJson = (json[id] as List<Map<dynamic, dynamic>>)[index];
    newJson.addAll({
      'parentFormFieldId': json['formFieldId'],
      if (index == length - 1) 'lastField': true,
    });
    (json[id] as List<Map<dynamic, dynamic>>)[index] = newJson;
  }
}
