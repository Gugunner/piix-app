//Use keep tabs payment provider
//api status
enum PaymentStatus {
  rejected,
  charged_back,
  refunded,
  in_mediation,
  authorized,
  in_process,
  pending,
  approved,
  cancelled,
  none,
}

//Use for controlling the product life cycle
enum ProductStatus {
  active,
  pending,
  inactive,
  canceled,
  idle,
}

extension ProductStatusExtend on ProductStatus {
  bool get productUnavailable {
    switch (this) {
      case ProductStatus.canceled:
      case ProductStatus.inactive:
        return true;
      default:
        return false;
    }
  }

  String get activeText {
    if (this == ProductStatus.active) return 'activo';
    if (this == ProductStatus.inactive) return 'inactivo';
    return '';
  }
}
