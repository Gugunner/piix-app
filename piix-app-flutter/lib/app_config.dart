enum Endpoint {
  APP_BACKEND,
  PAYMENTS,
  CATALOG,
}

class AppConfig {
  AppConfig._();
  static final instance = AppConfig._();

  String _backendSQLURL = '';
  String _paymentURL = '';
  String _signUpURL = '';
  String _catalogSQLURL = '';
  String _piixAppS3 = '';

  void setBackendEndPoint(String endpoint) {
    _backendSQLURL = endpoint;
  }

  String get backendEndpoint => _backendSQLURL;

  void setPaymentEndpoint(String endpoint) {
    _paymentURL = endpoint;
  }

  String get paymentEndpoint => _paymentURL;

  void setSignUpEndpoint(String endpoint) {
    _signUpURL = endpoint;
  }

  String get signUpEndpoint => _signUpURL;

  void setCatalogSQLURL(String endpoint) {
    _catalogSQLURL = endpoint;
  }

  String get catalogEndpoint => _catalogSQLURL;

  void setPiixAppS3(String bucket) {
    _piixAppS3 = bucket;
  }

  String get piixAppS3 => _piixAppS3;

  String getEndpoint(String path) {
    if (path.contains(catalogEndpoint)) return Endpoint.CATALOG.name;
    if (path.contains(paymentEndpoint)) return Endpoint.PAYMENTS.name;
    if (path.contains(backendEndpoint)) return Endpoint.APP_BACKEND.name;

    return 'none';
  }
}
