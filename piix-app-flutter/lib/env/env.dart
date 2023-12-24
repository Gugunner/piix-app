import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'BACKEND_ENDPOINT_ONE', obfuscate: true)
  static final backendEndpointOne = _Env.backendEndpointOne;
  @EnviedField(varName: 'CATALOG_ENDPOINT_ONE', obfuscate: true)
  static final catalogEndpointOne = _Env.catalogEndpointOne;
  @EnviedField(varName: 'BACKEND_ENDPOINT_TWO', obfuscate: true)
  static final backendEndpointTwo = _Env.backendEndpointTwo;
  @EnviedField(varName: 'CATALOG_ENDPOINT_TWO', obfuscate: true)
  static final catalogEndpointTwo = _Env.catalogEndpointTwo;
  @EnviedField(varName: 'PAYMENT_ENDPOINT', obfuscate: true)
  static final paymentEndpoint = _Env.paymentEndpoint;
  @EnviedField(varName: 'SIGNUP_ENDPOINT', obfuscate: true)
  static final signUpEndpoint = _Env.signUpEndpoint;
  @EnviedField(varName: 'PIIX_APP_S3', obfuscate: true)
  static final piixAppS3 = _Env.piixAppS3;
}
