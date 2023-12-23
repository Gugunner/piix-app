@Deprecated('Will be removed in 4.0')

///This extension contains all copies for purchase invoice model
///
class PurchaseInvoiceCopiesDeprecated {
  static const String paymentReference = 'Referencia de pago';

  ///Invoice Dates
  static const String orderDate = 'Fecha de creación';
  static const String paymentDate = 'Fecha de pago';
  static const String canceledDate = 'Fecha de cancelación';
  static const String expiredDate = 'Fecha de expiración';
  static const String activatedDate = 'Fecha de activación';
  static const String endDate = 'Término de vigencia';
  static const String rejectedDate = 'Fecha de rechazo';
  static const String refundedDate = 'Fecha de reembolso';
  static const String updateDate = 'Última actualización';

  ///Invoice product tag labels
  static const String pendingLabel = 'Pendiente';
  static const String expiredLabel = 'Expirado';
  static const String declinedLabel = 'Declinado';
  static const String processedLabel = 'Procesando';
  static const String cancelLabel = 'Cancelado';
  static const String mediationLabel = 'Mediación';
  static const String refundedLabel = 'Reembolsado';
  static const String paidLabel = 'Pagado';

  ///Invoice Payment Status historic
  static const String rejectedPaymentLabel = 'Pago rechazado';
  static const String refundedPaymentLabel = 'Pago reembolsado';
  static const String pendingPaymentLabel = 'Por pagar';
  static const String paidPaymentLabel = 'Pagado';
  static const String paymentInProcessLabel = 'Procesando pago';
  static const String paymentInMediationLabel = 'Pago en mediación';
  static const String expiredPaymentLabel = 'Expiró línea de captura';
  static const String canceledPaymentLabel = 'Pago cancelado';
  static const String orderCreatedLabel = 'Línea de pago creada';
  //Invoice Payment Status detail Title
  static const String rejectedPaymentTitle = 'Pago declinado';
  static const String refundedPaymentTitle = 'Pago reembolsado';
  static const String pendingPaymentTitle = 'Esta compra está por pagar';
  static const String paidPaymentTitle = 'Pago recibido';
  static const String paymentInProcessTitle = 'Tu pago esta en proceso';
  static const String paymentInMediationTitle = 'Mediación en proceso';
  static const String expiredPaymentTitle = 'Ha expirado tu línea de captura';
  static const String canceledPaymentTitle = 'Compra cancelada';
  static const String orderCreatedTitle = 'Se ha creado tu línea de captura';
  static const String endOfValidityTitle =
      'Ha terminado la vigencia de este producto';
  //Invoice Payment Status detail description
  static const String rejectedPaymentDescription =
      'Cotiza y genera una nueva línea de captura para '
      'reintentar el pago.';
  static const String refundedPaymentDescription =
      'La solicitud ha sido procesada y el pago ya fue reembolsado.';
  static const String pendingPaymentDescription =
      'Te recomendamos realizar el pago antes del';
  static const String paidPaymentDescription = 'Esta compra ya fue pagada.';
  static const String paymentInProcessDescription =
      'El pago se verá reflejado en aproximadamente 72 hrs.';
  static const String paymentInMediationDescription =
      'La solicitud de contracargo está siendo procesada.';
  static const String expiredPaymentDescription =
      'Para pagar necesitas una vigente, genera una nueva.';
  static const String canceledPaymentDescription =
      'Este ticket de compra ha sido cancelado.';
  static const String orderCreatedDescription =
      'Para realizar tu pago deberás tener tu línea de captura y pagar en '
      'cualquiera de los establecimientos que seleccionaste.';
  static const String endOfValidityDescription =
      'Esta compra fue pagada y ha terminado su vigencia.';
  //Invoice Payment Status detail instructions
  static const String makePaymentWithPaymentLine =
      'Para realizar tu pago deberás tener tu línea de captura y '
      'acudir al establecimiento que seleccionaste para pagar en efectivo.';
  static String refundMoneyFromModule(String module) =>
      'Se reembolsó el dinero que pagaste por este $module. '
      'Si quieres ver otros similares puedes hacerlo en el siguiente '
      'botón.';
  static String interestedInAcquiredModule(String module) =>
      'Si te interesa adquirir el $module puedes volver a hacer '
      'una cotización o ver productos similares en la tienda.';
  static const String remakePaymentPaymentLine =
      'Para realizar tu pago deberás volver a cotizar, generar tu línea de '
      'captura y acudir al establecimiento que seleccionaste para pagar.';
  //TODO: Add missing copies for each invoice status
  // Invoice Plan information
  static const String recommendAddProtected =
      'Te recomendamos ingresar los nombres y datos de tus protegidos para que '
      'ellos puedan hacer efectiva su membresía con Piix.';
  static const String addProtectedData = 'Ingresar datos de protegidos';
  //
  static const String paymentLineExpireReQuote =
      'Ya expiró tu línea de captura, para obtenerla cotiza nuevamente';
  static const String notLooseDiscount =
      'No pierdas este descuento exclusivo, paga antes del';
  //
  static const String reQuoteLabel = 'Cotiza nuevamente';
  static const String viewPaymentLine = 'Ver línea de captura';
  static const String exploreMoreProducts = 'Explorar más productos';
  static const String continueToStore =
      'Se te llevará a la sección de Tienda, ¿deseas continuar?';
  static const String continueToQuotation =
      'Se te llevará a la sección de cotización, ¿deseas continuar?';
  static const String exitAndViewSimilarProducts =
      'Al presionar “Aceptar”, saldrás de esta sección y se te mostrará '
      'productos similares a este en la Tienda.';
  static const String exitAndViewQuotation =
      'Al presionar “Aceptar” saldrás de esta sección y se cargará la '
      'cotización de este producto ahi puedes generar una nueva '
      'línea de captura.';

  static const String thanksForChoosingUs = 'Gracias por elegirnos.';
  static const String thanksForTrustingPiix = 'Gracias por confiar en piix.';
  static const String thanksForTrustingUs = 'Gracias por confiar en nosotros.';
  static const String processPayToActivate =
      'Se necesita procesar el pago para activarlo';
  //--------------------------------------------------------------------------//

  static String stillImproveCoverageWith(String module) =>
      'Aún puedes mejorar tu cobertura con $module';
  static String goingToImproveCoverageWith(String module) =>
      'Vas a mejorar tu cobertura con $module';
  static String haveImprovedCoverageWith(String module) =>
      'Has mejorado tu cobertura con $module';
  static String validityFromTo(String from, String to) =>
      'Vigencia del $from al $to';
}
