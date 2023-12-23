import 'package:piix_mobile/benefit_per_supplier_feature/domain/model/benefit_per_supplier_model_deprecated.dart';
import 'package:piix_mobile/domain/model/benefits_by_type.dart';

///This extension contains all methods for calculate membership notifications
///
extension BenefitByTypeNotificationExtension on List<BenefitsByType> {
  List<BenefitPerSupplierModel> get flatToBenefitPerSupplierList =>
      map((benefitByType) => benefitByType.benefits ?? [])
          .where((benefits) => (benefits).isNotEmpty)
          .expand((benefits) => benefits)
          .toList();

  int get getFormNotificationsNumber {
    final benefitList = flatToBenefitPerSupplierList;
    final cobenefitList = benefitList.flatToCobenefitPerSupplierList;
    final benefitFormNotifications = benefitList.benefitFormNotifications;
    final cobenefitFormNotifications = cobenefitList.cobenefitFormNotifications;
    final formNotifications =
        benefitFormNotifications + cobenefitFormNotifications;
    return formNotifications;
  }
}

extension BenefitPerSupplierNotificationExtension
    on List<BenefitPerSupplierModel> {
  List<BenefitPerSupplierModel> get flatToCobenefitPerSupplierList => where(
          (e) => e
              .mapOrNull((value) => null, detail: (value) => value)!
              .hasCobenefits)
      .map((e) =>
          e
              .mapOrNull((value) => null, detail: (value) => value)
              ?.cobenefitsPerSupplier ??
          [])
      .expand((element) => element)
      .toList();

  int get benefitFormNotifications => where((e) {
        final benefit = e.mapOrNull((value) => value);
        if (benefit == null) return false;
        return !benefit.hasCobenefits &&
            benefit.hasBenefitForm &&
            !benefit.userHasAlreadySignedTheBenefitForm;
      }).length;
}

extension CobenefitPerSupplierNotificationExtension
    on List<BenefitPerSupplierModel> {
  int get cobenefitFormNotifications => where((cobenefitForm) {
        final cobenefit = cobenefitForm.mapOrNull((value) => null,
            cobenefit: (value) => value);
        if (cobenefit == null) return false;
        return cobenefit.hasBenefitForm &&
            !(cobenefit.userHasAlreadySignedTheBenefitForm);
      }).length;
}
